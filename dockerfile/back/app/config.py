from app import app
from flaskext.mysql import MySQL

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'cruise_db'
app.config['MYSQL_DATABASE_HOST'] = 'db_cruise'
app.config['MYSQL_DATABASE_PORT'] = 3366
mysql.init_app(app)
