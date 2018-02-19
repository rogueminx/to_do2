require('rspec')
require('pg')
require('tasks')

DB = PG.connect({:dbname => 'todo_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM tasks *;')
  end
end

describe(Tasks) do
  describe('#==') do
    it('is the same task if descriptions are the same') do
      one = Tasks.new({:description => 'learn SQL', :list_id => 1})
      two = Tasks.new({:description => 'learn SQL', :list_id => 1})
      expect(one).to(eq(two))
    end
  end # ==

  describe('.all') do
    it('empty at first') do
      expect(Tasks.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds todo items to array of todos') do
      first_task = Tasks.new({:description => 'go to doctor', :list_id => 1})
      first_task.save
      expect(Tasks.all()).to(eq([first_task]))
    end
  end # .all

  describe("#description") do
    it("lets you read out the description.") do
      test_task = Tasks.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe("#list_id") do
    it("lets you read out the list_id") do
      test_task = Tasks.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.list_id()).to(eq(1))
    end
  end
end # Tasks
