class Task
  attr_reader :id
  # def id
  #   @id
  # end

  attr_accessor :title, :done

  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    # @done = attributes[:done] == 0 ? false : true
    @done = attributes[:done] == 1
  end

  # CLASS METHOD
  # def Task.find
  def self.find(id)
    # we have an id

    # find the record with the given id
    sql_query = "
      SELECT * FROM tasks WHERE id = #{id}
    "
    query_result = DB.execute(sql_query)
    attributes = query_result.first
    if attributes
      create_task(attributes)
      # we want an instance of the class Task
      # we want a new Task
    else
      nil
    end
  end

  # CLASS METHOD
  def Task.all
    # take all tasks_data from the db
    tasks_data = DB.execute('SELECT * FROM tasks')
    # return the new array with the Tasks instances
    tasks_data.map { |attributes| create_task(attributes) }
  end

  def self.last
    find(DB.last_insert_row_id)
  end

  # the above is the same as the below
  # def Task.all
  #   # take all tasks_data from the db
  #   tasks_data = DB.execute('SELECT * FROM tasks')
  #   tasks = []
  #   tasks_data.each do |attributes|
  #     # for each task data, we will create a Task.new
  #     tasks << create_task(attributes)
  #   end
  #   return tasks
  # end

  def self.create_task(attributes)
    attributes = attributes.transform_keys { |key| key.to_sym }
    # we will create a new task with that DATA
    Task.new(attributes)
  end

  private_class_method :create_task

  def save
    # if it has an id
    @id ? update : create
    # if self.id
    #   update
    # else
    #   create
    # end
  end

  def destroy
    DB.execute('DELETE FROM tasks WHERE id = ?', @id)
  end

  private

  def create
    # save it in the DB
    DB.execute('INSERT INTO tasks (title, description) VALUES (?, ?)', @title, @description)
    # get the last id from the Database
    last_id = DB.last_insert_row_id
    # update the current instance's id with the one from the DB
    @id = last_id
  end

  def update
    # save it in the DB (updating)
    sql_query = '
      UPDATE tasks
      SET title = ?, description = ?, done = ?
      WHERE id = ?
    '

    DB.execute(
      sql_query,
      @title,
      @description,
      @done ? 1 : 0,
      @id
    )
  end

end
