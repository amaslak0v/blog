from flask import Flask, escape, request, render_template, redirect

app = Flask(__name__)
cv_google_doc_link = 'https://docs.google.com/document/d/1z9YO3m5PKo_EQzLhgE4dDuF1bZDK6WB4zihNsBTNupY' + '/preview'


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/me')
def me():
    return redirect( cv_google_doc_link, code=302)
    # return render_template('about-me.html')

@app.route('/meme')
def meme():
    return render_template('meme.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
