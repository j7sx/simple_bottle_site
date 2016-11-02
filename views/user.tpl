<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bottle simple site</title>
<script type="text/javascript" src="../static/jquery.js"></script>
<script src="../static/jquery.uploadfile.min.js"></script>
<script type="text/javascript" src="../static/add_foto.js"></script>
<style type="text/css">
@import url(static/css.css);
@import url(static/uploadfile.css);
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
                  <img id="ava" src="static/images/users/{{name}}"></img></br>
                    <div id="fileuploader" name="avatar">Upload</div>
                        <div id="f_btn"><button id="del_foto">Убрать фото</button></div>
          </div>
          </div>
    </div>
    <div id="foot">Bottle tutorial by j7sx</div>
</div>
</body>
</html>
