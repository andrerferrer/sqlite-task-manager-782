# TDD - Test Driven Development
# 1st write the tests
# 2nd write the code and make it pass
# 3rd refactor


# Initializing the DB
require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
# DB initialized

# Require the Task class
require_relative "task"

# Implement the READ logic to find a given task (by its id)
first_task = Task.find(1)
print "first_task.class == Task > "
puts first_task.class == Task ? "✔" : "❌"

print "first_task.id == 1 > "
puts first_task.id == 1 ? "✔" : "❌"

print "first_task.title == Complete Livecode > "
puts first_task.title == "Complete Livecode" ? "✔" : "❌"

# Implement the CREATE logic in a save instance method
attributes = {
  title: 'Do the dishes',
  description: 'Clean the plates, the pans, the glasses'
}

dishes = Task.new(attributes)
dishes.save

last_task = Task.last
print "last_task.class == Task > "
puts last_task.class == Task ? "✔" : "❌"

print "last_task.title == 'Do the dishes' > "
puts last_task.title == "Do the dishes" ? "✔" : "❌"

# Implement the UPDATE logic in the same method
last_task = Task.last
last_task.title = 'Do the dishes now!'
last_task.done = true
last_task.save

last_task_again = Task.last

print "last_task_again.title == 'Do the dishes now!' > "
puts last_task_again.title == 'Do the dishes now!' ? "✔" : "❌"
print 'last_task_again.done == true > '
puts last_task_again.done == true ? "✔" : "❌"

# Implement the DESTROY logic on a task
attributes = {
  title: 'Get destroyed',
  description: 'Get destroyed soon'
}

destroyed = Task.new(attributes)
destroyed.save

destroyed_task_again = Task.last
last_id = destroyed_task_again.id
destroyed_task_again.destroy

print "Task.find(last_id) == nil > "
puts Task.find(last_id) == nil ? "✔" : "❌"

# Implement the READ logic to retrieve all tasks (what type of method is it?)
tasks = Task.all

print "tasks.class == Array > "
puts tasks.class == Array ? "✔" : "❌"
print "tasks.first.class == Task > "
puts tasks.first.class == Task ? "✔" : "❌"
print "tasks.first.title == Complete Livecode > "
puts tasks.first.title == "Complete Livecode" ? "✔" : "❌"
