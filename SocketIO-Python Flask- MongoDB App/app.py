from flask import Flask,render_template,request,url_for,redirect,json
from flask_socketio import SocketIO
from datetime import datetime
from passlib.hash import sha256_crypt
import pymongo

# inits
app = Flask(__name__)
app.config['SECRET_KEY'] = "BzzmansSecret"
socketio = SocketIO(app, cors_allowed_origins='*')

# mongodb inits
client = pymongo.MongoClient('localhost',27017)
db = client.BzzmansChatApp
collection = db.messages

# socketio
@socketio.on('my event')
def handle_my_custom_event(json):
    print('recieved json: ' + str(json))

    # emitting
    socketio.emit('my response', json) # emit is a broadcasting function
    
    result = collection.insert_one(json)  # todo --> encrypt password?
    if result:
        print(':)')
    else:
        print(":(")

# routing
@app.route('/')
@app.route('/home')
def index():
    return render_template("index.html")


# running app
if __name__ == "__main__":
    socketio.run(app, debug=True)