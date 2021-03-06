#--*--coding: utf-8--*--
#!/usr/bin/python2

import sqlite3
import random
import hashlib
import base64
import sys
import cgi
import os
from db_create import db_create
from bottle import route, request, post, run, template, static_file, response, redirect, abort

############################### Регистрация пользователя с введенными при регистрации данными ###########
def write_To_DB(login, pwd, email, admin):
    db = sqlite3.connect("site.db")
    cur = db.cursor()
    cur.execute("insert into users(login, password, email, admin) values(?, ?, ?, ?)", (login,pwd, email, admin,))
    db.commit()
    db.close()

####################################### Проверяем свободен ли логин ######################################
def check_login(login):
    db = sqlite3.connect("site.db")
    cur = db.cursor()
    cur.execute("select count(login) from users where login=?", (login,))
    user = cur.fetchone()
    db.close()
    return user[0]

####################################### Получаем пароль пользователя ###################################
def read_pwd(login):
    db = sqlite3.connect("site.db")
    cur = db.cursor()
    cur.execute("select password from users where login=?", (login,))
    result = cur.fetchone()
    db.close()
    return result[0]

######################################## Генерируем ключ сессии ##################################################
def secret_key():
	secret = '2345fgjsdrk/+63gdjsj'
	#выбираем из строки secret 5 символов
	r = random.sample(secret, 5)

	#Преобразуем список из 5-ти символов в строку
	string = ''.join(r)
	sh=string + 'login'
	secret_key = hashlib.sha1(sh).hexdigest()
	return secret_key

##################################### устанавливаем ключ сессии по логину пользователя ########################
def set_session_key(sk, login):
    db = sqlite3.connect("site.db")
    cur = db.cursor()
    cur.execute("update users set session_id=? where login =?", (sk, login,))
    db.commit()
    db.close()

########################   получаем ключ сессии по логину пользователя ########################################
def get_session_key(login):
    db = sqlite3.connect("site.db")
    cur = db.cursor()
    cur.execute("select session_id from users where login =?", (login,))
    sid = cur.fetchone()
    db.close()
    return sid[0]

########################   получаем логин пользователя по ключу сессии   ########################################
def get_username():
    session = request.get_cookie("user")
    db = sqlite3.connect("site.db")
    cur = db.cursor()
    cur.execute("select login from users where session_id=?", (session,))
    user = cur.fetchone()
    db.close()
    return user[0]


############################ определяем админа ##########################################
def is_admin(login):
    db = sqlite3.connect("site.db")
    cur = db.cursor()
    cur.execute("select admin from users where login=?", (login,))
    admin = cur.fetchone()
    db.close()
    return admin[0]


######################### удаляем куки. logout ###########################################
def delete_cookie(sid):
    db = sqlite3.connect("site.db")
    cur = db.cursor()
    cur.execute("update users set session_id=? where session_id =?", (None, sid,))
    db.commit()
    db.close()
    response.delete_cookie('user')

######################## Генерируем хэш пароля #####################################
def pwd_gen(pwd):
    password = hashlib.sha1((pwd).encode('utf-8')).digest()
    hash_pwd = base64.b64encode(password)
    return str(hash_pwd)

######################## Грузим css ################################
@route('/static/<filename:re:.*\.css>')
def stylesheets(filename):
    return static_file(filename, root='static')

######################## Грузим js #########################################
@route('/static/<filename:re:.*\.js>')
def javascripts(filename):
    return static_file(filename, root='static')

######################## Грузим html ########################################
@route('/views/<filename:re:.*\.html>')
def html(filename):
    return static_file(filename, root='views')

####################### Грузим картинки ############################################
@route('/static/images/<filename:re:.*\.(jpg|jpeg|png|gif|ico)>')
def images(filename):
    return static_file(filename, root='static/images')

######################## инсталлятор ##########################################
@route('/install')
def install():
    return template('views/install.tpl')
@post('/install')
def do_install():
    db_create()
    login = request.forms.get('login').decode('utf-8')
    pwd = request.forms.get('password').decode('utf-8')
    email = request.forms.get('email').decode('utf-8')
    admin = 1
    hashed_pwd = pwd_gen(pwd)
    write_To_DB(login, hashed_pwd, email, admin)
    return template("views/reg_success.tpl", name=login)

########### INDEX #################################
@route('/')
def index():
    return template('views/index.tpl')

################### Нужен для отображения главной стрницы, когда залогинились, чтобы главная не повторяла текущую ###########
@route('/welcome')
def welcome():
    return template('views/index.tpl')

@route('/reg')
def reg():
    return template("views/reg.tpl")

@post('/reg')
def do_reg():
    login = request.forms.get('login').decode('utf-8')
    pwd = request.forms.get('pwd').decode('utf-8')
    email = request.forms.get('email').decode('utf-8')
    admin = 0
    hashed_pwd = pwd_gen(pwd)
    write_To_DB(login, hashed_pwd, email, admin)
    return template("views/reg_success.tpl", name=login)

@route('/login')
def login():
    return template("views/login.tpl")

@post('/login')
def do_login():
    login = request.forms.get("login").decode('utf-8')
    pwd = request.forms.get("pwd").decode('utf-8')
    hashed_pwd = pwd_gen(pwd)
    isUser = check_login(login)
    if isUser:
        user_pwd = read_pwd(login)
        if hashed_pwd == user_pwd:
            sk = secret_key()
            set_session_key(sk, login)
            cookie = get_session_key(login)
            response.set_cookie("user", str(cookie), path='/')
            return template('views/lk.tpl', name=login)
        else:
            redirect ("/login?status=bad")
    else:
        redirect ("/login?status=wrong")

@route('/lk')
def lk():
    user = request.get_cookie("user")
    if user:
        admin = is_admin(get_username())
        if admin == 0:
            return template('views/lk.tpl', name=get_username() )
        elif admin == 1:
            return template('views/admin.tpl')
    else:
        return template('views/login.tpl')


def set_avatar():
    user = get_username()
    avatar_dir = os.getcwd() + "/static/images/users/"
    list_avatars = os.listdir(avatar_dir)
    for avatar in list_avatars:
        if user in avatar:
            ava = str(avatar)
            return ava
        else:
            return "ava.jpg"

@post("/load_avatar")
def load_avatar():
    user = get_username()
    output_dir = "static/images/users/"
    avatar = request.files.get("myfile")
    name, ext = os.path.splitext(avatar.filename)
    loading_ava = output_dir+name+ext
    if os.path.exists(loading_ava):
        os.remove(loading_ava)
    ava = str(user)+ext
    if ext not in ('.png','.jpg','.jpeg'):
        return 'File extension not allowed.'
    avatar.save(output_dir)
    loaded_ava = name+ext
    os.chdir(output_dir)
    os.rename(loaded_ava, ava)
    

@route("/user_info")
def user_info():
    test = "qwerty"
    return template("views/user.tpl", name=set_avatar())

@route('/restrict')
def restrict():
    return template("views/restrict.tpl")

@route('/logout')
def logout():
    sid = request.get_cookie("user")
    delete_cookie(sid)
    return template("views/logout.html")

run(reloader=True, port=8092, debug=True)
