from enum import unique
import flask
from flask_sqlalchemy import SQLAlchemy
from flask import Flask, app, render_template, flash, redirect, url_for, session, request
from functools import wraps
from datetime import datetime, timedelta
from sqlalchemy.orm import query

#* login control 
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "logged_in" in session:
            return f(*args, **kwargs)
        else:
            flash("You have to login first. Unauthorised action.","danger")
            return redirect(url_for("login"))
    return decorated_function

#! ***************************************************************************************************

#* Flask App configs
app = Flask(__name__) 
app.secret_key = "Bzzmans_Secret"

#* Postgresql Database connection configs 
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:Eb914649.@localhost/testdb1' 
db = SQLAlchemy(app)

#* session timeout(5 min.)
@app.before_request
def make_session_permanent():
    session.permanent = True
    app.permanent_session_lifetime = timedelta(minutes=5)

#! ***************************************************************************************************

#* Database tables

# Users
class Users(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    Firstname = db.Column(db.String(40), nullable=False)
    Lastname = db.Column(db.String(40), nullable=False)
    Nickname = db.Column(db.String(40), unique=True, nullable=False)
    Email = db.Column(db.String(120), unique=True, nullable=False)
    Password = db.Column(db.String(40), unique=True, nullable=False)
    CreationDate = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    def __init__(self, Firstname, Lastname, Nickname, Email, Password):
        self.Firstname = Firstname
        self.Lastname = Lastname
        self.Nickname = Nickname
        self.Email = Email
        self.Password = Password

# Foods
class Foods(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    FoodName = db.Column(db.String(40), unique=True, nullable=False)
    FoodCategoryId = db.Column(db.Integer, db.ForeignKey('categories.Id'), nullable=False)
    FoodTypeId = db.Column(db.Integer, db.ForeignKey('foodtype.Id'))
    CuisineId = db.Column(db.Integer, db.ForeignKey('cuisine.Id'))
    DifficultyId = db.Column(db.Integer, db.ForeignKey('difflevel.Id'))
    Calories = db.Column(db.String(40))
    CookingTime = db.Column(db.String(40))
    CookingPlaceId = db.Column(db.Integer, db.ForeignKey('cookplace.Id'))
    Yield = db.Column(db.Integer)
    PriceId = db.Column(db.Integer, db.ForeignKey('price.Id'))
    isFavourite = db.Column(db.Boolean, db.ForeignKey('favourites.isFav'))
    RatingId = db.Column(db.Integer, db.ForeignKey('ratings.Id'))
    Recipe = db.Column(db.Text, nullable=False)
    CreationDate = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    def __init__(self, FoodName, FoodCategoryId, FoodTypeId, CuisineId, DifficultyId, Calories, CookingTime, CookingPlaceId, Yield, PriceId, isFavourite,RatingId, Recipe):
        self.FoodName = FoodName
        self.FoodCategoryId = FoodCategoryId
        self.FoodTypeId = FoodTypeId
        self.CuisineId = CuisineId
        self.DifficultyId = DifficultyId
        self.Calories = Calories
        self.CookingTime = CookingTime
        self.CookingPlaceId = CookingPlaceId
        self.Yield = Yield
        self.PriceId = PriceId
        self.isFavourite = isFavourite
        self.RatingId = RatingId
        self.Recipe = Recipe

# Categories
class Categories(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    CategoryName = db.Column(db.String(40), unique=True, nullable=False)
    Description = db.Column(db.Text, nullable=False)

    def __init__(self, CategoryName, Description):
        self.CategoryName = CategoryName
        self.Description = Description

# Difficulty Level
class Difflevel(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    LevelName = db.Column(db.String(40), unique=True, nullable=False)

    def __init__(self, LevelName):
        self.LevelName = LevelName

# Cuisine
class Cuisine(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    CuisineName = db.Column(db.String(40), nullable=False)

    def __init__(self, CuisineName):
        self.CuisineName = CuisineName

# Ratings
class Ratings(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    RatingScore = db.Column(db.Integer, nullable=False)

    def __init__(self, RatingScore):
        self.RatingScore = RatingScore

# Price
class Price(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    PriceRange = db.Column(db.String(40), nullable=False)

    def __init__(self, PriceRange):
        self.PriceRange = PriceRange

# Ingredients
class Ingredients(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    IngredientName = db.Column(db.String(100), unique=True, nullable=False)
    Description = db.Column(db.Text)
    AccessId = db.Column(db.Integer, db.ForeignKey('accessibility.Id'))

    def __init__(self, IngredientName, Description, AccessId):
        self.IngredientName = IngredientName
        self.Description = Description
        self.AccessId = AccessId

# Food-Ingredient (junction)
class FoodIngredient(db.Model):
    FoodId = db.Column(db.Integer, db.ForeignKey('foods.Id'), primary_key=True)
    IngredientId = db.Column(db.Integer, db.ForeignKey('ingredients.Id'), primary_key=True)

# Favourites
class Favourites(db.Model):
    isFav = db.Column(db.Boolean, primary_key=True)
    FoodId = db.Column(db.Integer, db.ForeignKey('foods.Id'), nullable=False)
    CreationDate = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    def __init__(self, FoodId):
        self.FoodId = FoodId

# Cook Place
class Cookplace(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    PlaceName = db.Column(db.String(40), nullable=False)

    def __init__(self, PlaceName):
        self.PlaceName = PlaceName

# Kitchen Tools
class Kitchentools(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    ToolName = db.Column(db.String, nullable=False)
    AccessId = db.Column(db.Integer, db.ForeignKey('accessibility.Id'))

    def __init__(self, ToolName, AccessId):
        self.ToolName = ToolName
        self.AccessId = AccessId

# Food-Tool (junction)
class FoodTool(db.Model):
    FoodId = db.Column(db.Integer, db.ForeignKey('foods.Id'), primary_key=True)
    ToolId = db.Column(db.Integer, db.ForeignKey('kitchentools.Id'), primary_key=True)

# Accessibility
class Accessibility(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    isRare = db.Column(db.Boolean)
    WhereToBuy = db.Column(db.String(100), nullable=False)

    def __init__(self, isRare, WhereToBuy):
        self.isRare = isRare
        self.WhereToBuy = WhereToBuy

# Food Type
class Foodtype(db.Model):
    Id = db.Column(db.Integer, primary_key=True)
    TypeName = db.Column(db.String(40), nullable=False)
    Description = db.Column(db.Text)

    def __init__(self, TypeName, Description):
        self.TypeName = TypeName
        self.Description = Description

#! ***************************************************************************************************

#* Home page
@app.route('/')
@app.route('/home')
def index():
    return render_template('home.html')

#* About page
@app.route('/about')
def about():
    return render_template('about.html')

#* Register page 
@app.route('/register', methods=["GET","POST"]) 
def register():
    if request.method == 'POST': 
        if not request.form['firstname'] or not request.form['lastname'] or not request.form['nickname'] or not request.form['email'] or not request.form['password']:
            flash("Please enter all the fields", "danger")
        else:
            Firstname = request.form['firstname']
            Lastname =  request.form['lastname']
            Nickname =  request.form['nickname'] 
            Email = request.form['email']
            Password = request.form['password']

            newUser = Users(Firstname=Firstname, Lastname=Lastname, Nickname=Nickname, Email=Email, Password=Password)

            query_result = Users.query.filter_by(Nickname=Nickname, Password=Password).first()
            if query_result:
                flash("User already exists. Try again.", "danger")
                return redirect(url_for('register'))

            db.session.add(newUser)
            db.session.commit()

            flash("Registration successful!", "success")
            return redirect(url_for('login'))
                
    return render_template('register.html')

#* Login page
@app.route('/login', methods=["GET","POST"])
def login():
    if request.method == 'POST':
        if not request.form['nickname'] or not request.form['password']:
            flash("Please enter all the fields.", "danger")
        else:
            Nickname = request.form['nickname']
            Password = request.form['password']
            query_result = Users.query.filter_by(Nickname=Nickname, Password=Password).first_or_404()
            
            if query_result:
                flash("Login successful.", "success")
                session['logged_in'] = True
                session['nickname'] = Nickname  #? doruysa sil.

                return redirect(url_for("dashboard"))
            else:
                flash("User doesn't exist.", "danger")
                return redirect(url_for('login'))

    return render_template('login.html')

#* Dashboard page
@app.route('/dashboard')
@login_required
def dashboard():
    result = Foods.query.all()
    if result:
        return render_template('dashboard.html', result=result)
    else:
        return render_template('dashboard.html')

#* Add Food page
@app.route('/dashboard/addfood', methods=["GET","POST"])
@login_required
def addFood():
    #Queries
    categoryQuery = Categories.query.all()
    cuisineQuery = Cuisine.query.all()
    diffQuery = Difflevel.query.all()
    priceQuery = Price.query.all()
    ratingQuery = Ratings.query.all()
    cookplaceQuery = Cookplace.query.all()
    isFavQuery = Favourites.query.all()
    foodtypeQuery = Foodtype.query.all()

    if request.method == 'POST':
        # Page requests.
        FoodName = request.form['foodname']
        FoodCategoryId =  request.form['category']
        CuisineId =  request.form['cuisine'] 
        DifficultyId = request.form['difficulty']
        PriceId = request.form['price']
        RatingId =  request.form['rating']
        CookPlaceId = request.form['cookplace']
        CookTime = request.form['cooktime']
        IsFav = request.form['isfav']
        FoodTypeId = request.form['foodtype']
        Calories = request.form['calories']
        Yield = request.form['yield']
        Recipe = request.form['recipe']
        
        newFood = Foods(FoodName=FoodName, FoodCategoryId=FoodCategoryId, CuisineId=CuisineId, DifficultyId=DifficultyId, CookingPlaceId=CookPlaceId,
                        CookingTime=CookTime, IsFav=IsFav, FoodTypeId=FoodTypeId, Calories=Calories, Yield=Yield, PriceId=PriceId, RatingId=RatingId, Recipe=Recipe) 

        db.session.add(newFood)
        db.session.commit()

        flash("Food successfully added!", "success")
        return redirect(url_for('dashboard'))

    return render_template('addfood.html', categoryQuery=categoryQuery, cuisineQuery=cuisineQuery, diffQuery=diffQuery, priceQuery=priceQuery, ratingQuery=ratingQuery, 
                                           cookplaceQuery=cookplaceQuery, isFavQuery=isFavQuery, foodtypeQuery=foodtypeQuery)

#* Delete food page
@app.route('/delete/<string:id>')
@login_required
def deleteFood(id):
    query_result1 = Foods.query.filter_by(Id=id).first()
    query_result2 = FoodIngredient.query.filter_by(FoodId=id).first()
    query_result3 = FoodTool.query.filter_by(FoodId=id).first()
    query_result4 = Favourites.query.filter_by(FoodId=id).first()
    if query_result1 and query_result2 and query_result3 and query_result4: #db.execute() ile sql sorgusu?
        db.session.delete(query_result3)
        db.session.delete(query_result2)
        db.session.delete(query_result4)
        db.session.delete(query_result1)
        db.session.commit()
    
        flash("Food successfully deleted!", "success")
        return redirect(url_for('dashboard'))
    else:
        flash("Food doesn't exist. Try again.", "danger")
        return redirect(url_for('dashboard'))

#* Edit Food page 
@app.route('/update/<string:id>', methods=["GET","POST"])
@login_required
def updateFood(id):
    if request.method == "GET":
        query_result = Foods.query.filter_by(Id=id).first()
        if query_result:
            return render_template("update.html", query_result=query_result, id=id)
        else:
            flash("Update error!","danger")
            return render_template("update.html")

#* All Recipes page(list by name)
#? listeleme çeşidi belirleme mümkün mü? Dropdown bootstrap
@app.route('/dashboard/food_list')
@login_required
def foodlist():
    query_result = Foods.query.all()
    if query_result:
        return render_template('foodlist.html', query_result=query_result)
    else:
        return render_template('foodlist.html')


@app.route('/food/<string:id>', methods=['GET'])
def food(id):
    myFood = Foods.query.filter_by(Id = id).first()
    if myFood:
        return render_template("food.html", myFood=myFood, id=id)
    else:
        return render_template("food.html")


#* Logout
@app.route('/logout')
def logout():
    session.clear()
    flash("Logout successful.","success")
    return redirect(url_for("index"))




if __name__ == "__main__":
    db.create_all()
    app.run(debug=True)




