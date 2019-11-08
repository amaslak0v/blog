from flask import Flask, escape, request, render_template, redirect

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/me')
def me():
    return redirect('https://docs.google.com/document/d/1z9YO3m5PKo_EQzLhgE4dDuF1bZDK6WB4zihNsBTNupY/preview', code=302)
    # return render_template('about-me.html')