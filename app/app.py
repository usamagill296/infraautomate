from flask import Flask, jsonify
import datetime


app = Flask(__name__)


@app.route('/health')
def health():
    return jsonify({
        'status': 'healthy',
        'timestamp': str(datetime.datetime.now())
    })


@app.route('/info')
def info():
    return jsonify({
        'service': 'infraautomate',
        'version': '1.0.0',
        'environment': 'dev'
    })


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8000)
