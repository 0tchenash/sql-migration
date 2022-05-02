from utils import get_cat
from flask import Flask, jsonify


def main():
    app = Flask(__name__)

    @app.route('/animals/<int:idx>')
    def animals(idx):
        data = get_cat(idx)
        return jsonify(data)
    app.run()


if __name__ == '__main__':
    main()

