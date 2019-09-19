from flask import render_template
from app import app

@app.route('/')
@app.route('/index')
def index():
    user = {'username': 'Anton'}
    posts = [
        {
            'author': {'username': 'Jack'},
            'body': 'tralala'
        },
        {
            'author': {'username': 'Marry'},
            'body': 'Some words about me'
        }
    ]
    return render_template('index.html', title='Home', user=user, posts=posts)
