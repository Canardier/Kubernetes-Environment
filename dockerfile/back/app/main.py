import pymysql
from app import app
from config import mysql
from flask import jsonify
from flask import flash, request

@app.route('/cruise')
def cruise():
    try:
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT id, name FROM cruise")
        cruiseRows = cursor.fetchall()
        respone = jsonify(cruiseRows)
        respone.status_code = 200
        return respone
    except Exception as e:
        print(e)
    finally:
        cursor.close() 
        conn.close()  

@app.route('/cruise/')
def cruise_details(cruise_id):
    try:
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT id, name FROM cruise WHERE id =%s", cruise_id)
        cruiseRow = cursor.fetchone()
        respone = jsonify(cruiseRow)
        respone.status_code = 200
        return respone
    except Exception as e:
        print(e)
    finally:
        cursor.close() 
        conn.close() 

if __name__ == "__main__":
    app.run("0.0.0.0", 5000)
