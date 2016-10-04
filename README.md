# simple_bottle_site

p.s. если в js.js убрать в 5-й строке +' #content', то грузиться будут динамические страницы, типа:

<code>
@route('/test')
def test():
    return """
    <html>
    <head></head>
    <body>
    this is just a test!
    </body>
    </html>
    """
</code>    
То есть на жестком шаблона может не быть. 
