require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/tasks")
require("pg")

DB = PG.connect({:dbname => "todo"}) # connects to PSQL database

get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:task_success)
end
