# simple_bottle_site

p.s. если в js.js убрать в 5-й строке +' #content', то грузиться будут динамические страницы, типа:

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
    
То есть на жестком шаблона может не быть. 
