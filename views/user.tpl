<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bottle simple site</title>
<script type="text/javascript" src="../static/jquery.js"></script>
<style type="text/css">
@import url(static/css.css);
</style>
<script type="text/javascript" src="../static/js.js"></script>



</head>
<body>
    <div id="wrapper">
    <h1>ajax ... nettuts</h1>
    <ul id="nav">
        <li><a href="/">welcome</a></li>
        <li><a href="/reg">reg</a></li>
        <li><a href="/login">login</a></li>
        <li><a href="views/contact.html">contact</a></li>
        <li><a href="/lk">profile</a></li>
    </ul>
    <div id="content">
          <h2>Edit profile:</h2>
          <div id="main-user">
          <div id="user_main">
            <div class="field">
              <label for="name">Имя:</label>
              <input type="text" name="name"></input>
            </div>
            <div class="field">
              <label for="phone">Телефон:</label>
              <input type="text" name="phone"></input>
            </div>
            <div class="field">
              <label for="skype">Skype:</label>
              <input type="text" name="skype"></input>
            </div>
            <div class="field">
              <label for="telega">Telegram:</label>
              <input type="text" name="telega"></input>
            </div></br>
            <div class="field">
              <label>Пол:</label>
              <input type="radio" name="sex" value="man">м</input><input type="radio" name="sex" value="woman">ж</input></br>
            </div></br></br></br></br>
              <button id="send_user_info">Отправить</button>
          </div>
          <div id="avatar">
              %from bottle import request
              %import sqlite3
              %import os

              %session = request.get_cookie("user")
              %db = sqlite3.connect("site.db")
              %cur = db.cursor()
              %cur.execute("select login from users where session_id=?", (session,))
              %user = cur.fetchone()
              %db.close()
              %user = user[0]
              %path1 = "static/images/users/"
              %path2 = str(user)+'.jpg'
              %path3 = path1+path2
              %ifile = os.path.exists(path3)
              %if ifile:
                  <img id="ava" src={{path3}}></img></br>
                  <div id="f_btn"><button id="set_foto">Добавить фото</button> <button id="del_foto">Убрать фото</button></div>
              %else:
                  <img id="ava" src="../static/images/users/ava.jpg"></img></br>
                  <div id="f_btn"><button id="set_foto">Добавить фото</button> <button id="del_foto">Убрать фото</button></div>
          </div>
              {{path3}}
          </div>
    </div>
    <div id="foot">Bottle tutorial by j7sx</div>
</div>
</body>
</html>
