require 'sequel'

# Conexão com o banco de dados
password = ENV['DATABASE_PASSWORD'] 
connection_string = "postgres://postgres:#{password}@localhost:5433/career_app_rails"

DB = Sequel.connect(connection_string)
