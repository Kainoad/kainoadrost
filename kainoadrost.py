import subprocess

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
	return "<h1 style='color:blue'>Hello There!</h1>"

@app.route("/git-pull")
def git_pull():
    subprocess.Popen(["nohup", "/bin/bash", "git_fetch_pull.sh"])
    return "<h1 style='color:blue'>Pulling from git repo</h1>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
