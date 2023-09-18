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
    cursor.execute("CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), age INT)")
    conn.commit()
    conn.close()

def insert_data(name, age):
    conn = mysql.connector.connect(
        host="db",
        database="your_database",
        user="gburucua",
        password="q1w2e3r4"
    )
    cursor = conn.cursor()
    query = "INSERT INTO users (name, age) VALUES (%s, %s)"
    values = (name, age)
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
        age = int(request.form["age"])
        try:
            create_table()
            insert_data(name, age)
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
        name = request.json["name"]
        age = int(request.json["age"])
        create_table()
        insert_data(name, age)
        return jsonify({"message": "Data saved successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)