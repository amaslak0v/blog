from flask import Flask, escape, request, render_template, redirect

app_version = 'v0.1'

links = {
	"cv": "https://docs.google.com/document/d/1z9YO3m5PKo_EQzLhgE4dDuF1bZDK6WB4zihNsBTNupY/preview",
	"telegram": "https://t.me/amaslak0v",
	"linkedin": "https://www.linkedin.com/in/amaslakov",
	"twitter": "https://twitter.com/intent/follow?screen_name=antoxam97"
}

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html', app_version=app_version, links=links)

@app.route('/test')
def test():
    return render_template('test.html')

@app.route('/me')
def me():
    return redirect(cv_link, code=302)

@app.route('/meme')
def meme():
    return render_template('meme.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
