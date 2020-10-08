import subprocess

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
	return "<h1 style='color:blue'>Hello!</h1>"

@app.route("/git-pull")
def git_pull():
    result = subprocess.run(['./scripts/git_fetch_pull.sh'], stdout=subprocess.PIPE)
    return "<h1 style='color:blue'>" + str(result.stdout.decode('utf-8')) + "</h1>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
