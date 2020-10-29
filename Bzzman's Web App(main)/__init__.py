from flask import Flask,render_template,flash,redirect,url_for,session,logging,request,jsonify,app
import pymongo
from bson.objectid import ObjectId
from flask_restplus import Api,Resource   # this contains some kind of error, i dunno
from wtforms import Form,StringField,TextAreaField,PasswordField,validators,BooleanField
from wtforms.csrf.session import SessionCSRF
from passlib.hash import sha256_crypt 
from functools import wraps
import datetime
from datetime import timedelta
from werkzeug.utils import cached_property
import json

# json encoder / gereksiz
class JSONEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, ObjectId):
            return str(o)
        return json.JSONEncoder.default(self, o)
# user entry decorator (kinda default stuff except if)
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "logged_in" in session:
            return f(*args, **kwargs)
        else:
            flash("You have to login first. Unauthorised action.","danger")
            return redirect(url_for("login"))
    return decorated_function
# user register form
class registerForm(Form):
    firstName = StringField("First Name",validators=[validators.Length(min=4,max=25)])
    lastName = StringField("Last Name",validators=[validators.Length(min=1,max=25)])
    nickname = StringField("Nickname",validators=[validators.Length(min=4,max=40)])
    email = StringField("Email Address",validators=[validators.Email(message = "Please enter a valid Email address.")])
    passwd = PasswordField("Password",validators=[
        validators.DataRequired(message="Please enter a password."),
        validators.EqualTo(fieldname="confirmPasswd",message="Your password doesn't match.")
    ])
    confirmPasswd = PasswordField("Confirm Password")
# user login form
class loginForm(Form):
    nicknameEntry = StringField("Nickname",validators=[
        validators.DataRequired(message="Please enter your nickname."),
        validators.length(min=4,max=40)
    ])
    passwordEntry = PasswordField("Password",validators=[
        validators.DataRequired(message="Please enter your password."),
        validators.length(min=4,max=40)
    ])
    rememberMe = BooleanField("remember me")
# adding note
class noteForm(Form):
    title = StringField("Note Title",validators=[validators.length(min=5,max=80)])
    content = TextAreaField("Note Content",validators=[validators.length(min=10)])
 
api = Api()  # api class ( in case of any problem with code you can put a comment.)
app = Flask(__name__)
app.secret_key = "Bzzmans_Secret"

client = pymongo.MongoClient('localhost',27017)
db = client.BzzmansWebApp
collection = db.users
collection1 = db.notes

# timeout
@app.before_request
def make_session_permanent():
    session.permanent = True
    app.permanent_session_lifetime = timedelta(minutes=5)

api.init_app(app)   # api same

@app.route('/')
@app.route('/home')
def index():
    return render_template('home.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/register',methods=["GET","POST"])
def register():
    form = registerForm(request.form)
    if request.method == 'POST' and form.validate():
        user = {
            "firstname" : form.firstName.data,
            "lastname" : form.lastName.data,
            "nickname" : form.nickname.data,
            "email" : form.email.data,
            "password" : sha256_crypt.encrypt(form.passwd.data)
        }
        
        collection.insert_one(user)
        flash("Registration successful!","success")
    
        return redirect(url_for('login'))
        
    else:
        return render_template('register.html',form=form)
        #return jsonify({"success" : ":("})

# registerForm classından çağırdım sonra veritabanına kaydedeceğim / redirect(url_for()) kullanarak istediğimiz url ye yönlendirme yapabiliriz.
@app.route('/login',methods=["GET","POST"])
def login():
    form = loginForm(request.form)
    if request.method == "POST" and form.validate():
        user = {
            "nicknameEntry" : form.nicknameEntry.data,
            "passwordEntry" : form.passwordEntry.data
        }

        usr = collection.find_one({ 'nickname': user['nicknameEntry']})
        
        # print(usr['password'])
        x = sha256_crypt.verify(user['passwordEntry'],usr['password'])
        if x is True:
            print(":)")
        else:
            print(":(")
   
        if x is True:   
            flash("Login successful!","success")
            session["logged_in"] = True
            session["nickname"] = user['nicknameEntry']   

            return redirect(url_for("dashboard"))
        else:
            flash("User doesn't exist.","danger")
            return redirect(url_for("login"))
    else:
        return render_template('login.html',form=form)  

@app.route('/dashboard')
@login_required
def dashboard():
    result = collection1.find() 
    if result:
        return render_template('dashboard.html',result=result)
    else:
        return render_template('dashboard.html')

    return render_template('dashboard.html')

@app.route('/dashboard/addnote',methods=["GET","POST"])
@login_required
def addNote():
    form = noteForm(request.form)
    if request.method == "POST" and form.validate():
        note = {
            "title" : form.title.data,
            "content" : form.content.data,
            "date" : datetime.datetime.utcnow()
        }
        collection1.insert_one(note)
        flash("Your note has been saved successfully!","success")
        return redirect(url_for('dashboard'))

    return render_template("addnote.html",form=form)

@app.route('/delete/<string:id>')
@login_required
def deleteNote(id):
    query = collection1.find_one({'_id' : ObjectId(id)})
    if query:
        deleteQuery = collection1.delete_one({'_id' : ObjectId(id)})
        print(deleteQuery)
        
        flash("Note successfully deleted.","success")
        return redirect(url_for("dashboard"))
    else:
        flash("Note doesn't exist. Or you don't have authorization.","danger")

@app.route('/edit/<string:id>',methods=["GET","POST"])
@login_required
def editNote(id):
    if request.method == "GET":
        query = collection1.find_one({'_id' : ObjectId(id)})
        if query:
            myNote = collection1.find_one({'_id' : ObjectId(id)})
            form = noteForm()
            form.title.data = myNote['title']
            form.content.data = myNote['content']
            return render_template("edit.html", form=form)
        else:
            flash("Note doesn't exist. Or you don't have authorization.","danger")
            return redirect(url_for("index"))
    else:
        # Post request
        form = noteForm(request.form)
        editQuery = collection1.update_one(
            {'_id' : ObjectId(id)},
            {"$set" :
                {'title' : form.title.data , 'content' : form.content.data},
                "$currentDate": {"lastModified": True}
            }
        )
        print(editQuery)
        flash("Note successfully updated.","success")
        return redirect(url_for("dashboard"))

@app.route('/search',methods=["GET","POST"])
def search():
#    if request.method == "GET":
#        return redirect(url_for('dashboard'))
#    else:
#        keyword = request.form.get("keyword")
#        searchIndex = collection1.create_index(
#            {'title' : keyword, 'content' : keyword}
#        )
#        searchQuery = collection1.find(
#            {'$text' : {'$search' : }}                 ----> search 
#        )
    pass
        
@app.route('/dashboard/allnotes')
@login_required
def allNotes():
    query = collection1.find()
    if query:
        return render_template('allnotes.html',query=query)
    else:
        return render_template('allnotes.html')

@app.route('/note/<string:id>',methods=['GET'])
def note(id):
    print(id)
    query = collection1.find({'_id' : ObjectId(id)})
    if query:
        myNote = collection1.find_one({'_id' : ObjectId(id)})
        return render_template("note.html", myNote=myNote, id=id)
        
    else:
        return render_template("note.html")

@app.route('/logout')
def logout():
    session.clear()
    flash("Logout successful.","success")
    return redirect(url_for("index"))

########################
@api.route('/api','/api/')
class get_post(Resource):
    def get(self):
        for user in collection.find({'_id' : ObjectId()}):
            return jsonify(user)

@api.route('/api/<string:id>')
class get_update_delete(Resource):
    def get(self,id):
        return jsonify(collection.find({'_id' : ObjectId(id)}))

########################

if __name__ == "__main__":
    app.run(debug=True)

