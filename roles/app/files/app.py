from flask import Flask
import os

app = Flask(__name__)


@app.route("/")
def index():
    return "Hello from Flask + Gunicorn + NGINX!"

@app.route("/health")
def health():
    return "OK"

if __name__ == "__main__":
    app.run()