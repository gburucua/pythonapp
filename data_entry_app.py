from flask import Flask, render_template, request, jsonify
import time
import mysql.connector

app = Flask(__name__, template_folder='.', static_url_path='', static_folder='static')  # Specify the template folder


def create_table():
    conn = mysql.connector.connect(
        host="db",
        database="your_database",
        user="gburucua",
        password="q1w2e3r4"
    )
    cursor = conn.cursor()
    cursor.execute("CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), surname VARCHAR(255), age INT, gender VARCHAR(255), comments VARCHAR(255))")
    conn.commit()
    conn.close()

def insert_data(name, surname, age, gender, comments):
    conn = mysql.connector.connect(
        host="db",
        database="your_database",
        user="gburucua",
        password="q1w2e3r4"
    )
    cursor = conn.cursor()
    query = "INSERT INTO users (name, surname, age, gender, comments) VALUES (%s, %s, %s, %s, %s)"
    values = (name, surname, age, gender, comments)
    cursor.execute(query, values)
    conn.commit()
    conn.close()

def fetch_data_from_database():
    connection = mysql.connector.connect(
        host="db",
        database="your_database",
        user="gburucua",
        password="q1w2e3r4"
    )
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM your_table")
    data = cursor.fetchall()
    cursor.close()
    connection.close()
    return data

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        name = request.form["name"]
        surname = request.form["surname"]
        age = int(request.form["age"])
        gender = request.form["gender"]
        comments = request.form["comments"]
        try:
            create_table()
            insert_data(name, surname, age, gender, comments)
            return render_template("index.html", data_saved=True)
        except mysql.connector.Error as error:
            error_message = f"An error occurred while connecting to the database: {error}"
            return render_template("index.html", error_message=error_message, data_saved=False)
    return render_template("index.html", data_saved=False)

@app.route("/api/data", methods=["GET"])
def get_data():
    # Retrieve data from the database and return as JSON
    data = fetch_data_from_database()
    return jsonify(data)

@app.route("/api/data", methods=["POST"])
def save_data():
    try:
        name = request.form["name"]
        surname = request.form["surname"]
        age = int(request.form["age"])
        gender = request.form["gender"]
        comments = request.form["comments"]
        create_table()
        insert_data(name, surname, age, gender, comments)
        return jsonify({"message": "Data saved successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)