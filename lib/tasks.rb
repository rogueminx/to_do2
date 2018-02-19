class Tasks
  attr_accessor :description
  attr_accessor :list_id

  def initialize(attributes)
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
  end

  def ==(another_task)
    self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
  end

  def self.all()
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |item|
      description = item.fetch("description")
      list_id = item.fetch("list_id").to_i() # The information comes out of the database as a string.
      tasks.push(Tasks.new({:description => description, :list_id => list_id}))
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});")
  end

  def description
    @description
  end

  def list_id
    @list_id
  end

end #Tasks
