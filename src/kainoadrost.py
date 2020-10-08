import subprocess

from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/")
def index():
    return render_template('index.html')

@app.route("/git-pull", methods=['GET', 'POST'])
def git_pull():
    result = subprocess.run(['./scripts/git_fetch_pull.sh'], stdout=subprocess.PIPE)
    f = open("test.txt", "a")
    f.write(str(request.get_data()))
    f.close()

    return "<h1 style='color:blue'>" + str(result.stdout.decode('utf-8')) + "</h1>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
