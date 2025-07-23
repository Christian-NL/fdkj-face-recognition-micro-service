from flask import Flask, request, jsonify
from controllers.face_controller import FaceController
from utils.exception import InvalidRequestError, FaceDetectionError

app = Flask(__name__)

@app.route('/api/compare-faces', methods=['POST'])
def compare_faces():
    try:
        result = FaceController.compare_faces(request)
        return jsonify(result)
    except InvalidRequestError as e:
        return jsonify({"error": str(e)}), 400
    except FaceDetectionError as e:
        return jsonify({"error": str(e)}), 400
    except Exception as e:
        return jsonify({"error": "Erreur interne du serveur"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)