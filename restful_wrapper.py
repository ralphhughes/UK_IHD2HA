from flask import Flask, jsonify
import subprocess
import time

app = Flask(__name__)

@app.route('/sensor', methods=['GET'])
def get_sensor_reading():
    # Execute your Bash command here
    output = subprocess.check_output(['ssocr -d -1 -b black crop 535 182 426 169 closing ./current.jpg']).decode().strip()
    # Return the sensor reading as JSON
    return jsonify({'sensor_value': output})

if __name__ == '__main__':
    # Run the Flask app with a specified interval
    while True:
        app.run(host='0.0.0.0', port=5000, debug=False)
        time.sleep(10)

