<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>private area</title>
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
        <li><a href="/welcome">welcome</a></li>
        <li><a href="/reg">reg</a></li>
        <li><a href="/login">login</a></li>
        <li><a href="views/contact.html">contact</a></li>
        <li><a href="/lk">profile</a></li>
    </ul>
    <div id="content">    	
    	"Hello,{{name}} Welcome back."	<div id="logout"><a href="/logout">Logout</a></div> 
        <div id="user">
          <a href="/user_info">My INFO</a> <a href="/lots">Лоты</a> <a href="/balance">Пополнить счёт</a>
        </div>
    </div>
    <div id="foot">Bottle tutorial by j7sx</div>
</div>
</body>
</html>
