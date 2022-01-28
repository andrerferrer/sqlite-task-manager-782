# Initializing the DB
require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
# DB initialized

# Require the Task class
require_relative "task"

# TODO: CRUD some tasks
