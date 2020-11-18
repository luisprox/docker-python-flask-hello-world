#!/usr/local/bin/python
# -*- coding: utf-8 -*-
u"""
Main code based on https://github.com/datawire/hello-world-python
"""


import os
import time
from flask import Flask


app = Flask(__name__)
START = time.time()
PORT = os.environ.get('PORT') or 34040


def elapsed():
    running = time.time() - START
    minutes, seconds = divmod(running, 60)
    hours, minutes = divmod(minutes, 60)
    return '%d:%02d:%02d' % (hours, minutes, seconds)


@app.route('/')
def root():
    return '<p>Hello World from Python-Flask!</p><p>Uptime: %s</p>' % elapsed()


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=PORT)
