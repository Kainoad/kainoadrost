import subprocess
import hmac
import hashlib
import json

from flask import Flask, render_template, request, abort

app = Flask(__name__)

@app.route("/")
def index():
    return render_template('index.html')

@app.route("/git-pull", methods=['POST'])
def git_pull():
    if not "X-Hub-Signature" in request.headers:
        abort(400) # bad request if no header present
    
    signature = request.headers['X-Hub-Signature']
    payload = request.get_data()

    with open('github_secret', 'r') as secret_file:
        webhook_secret = secret_file.read().replace("\n", "")

    secret = webhook_secret.encode() # must be encoded to a byte array

    # contruct hmac generator with our secret as key, and SHA-1 as the hashing function
    hmac_gen = hmac.new(secret, payload, hashlib.sha1)

    # create the hex digest and append prefix to match the GitHub request format
    digest = "sha1=" + hmac_gen.hexdigest()

    if not hmac.compare_digest(digest, signature):
        abort(400) # if the signatures don't match, bad request not from GitHub


    result = subprocess.run(['./scripts/git_fetch_pull.sh'], stdout=subprocess.PIPE)
    f = open("test.txt", "a")
    f.write(str(request.get_data()))
    f.close()

    return "<h1 style='color:blue'>" + str(result.stdout.decode('utf-8')) + "</h1>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
