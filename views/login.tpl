<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
        <h2>Sign In:</h2>
        <form action="/login" method="post">
        Login: <input type="text" name="login"/>
        Password: <input type="password" name="pwd"/>
        <input type="submit" value="enter"/>
        </form>
    </div>
    <div id="foot">Bottle tutorial by j7sx</div>
</div>
</body>
</html>
