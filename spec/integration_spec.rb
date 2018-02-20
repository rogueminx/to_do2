require ('capybara/rspec')
require ('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('see details for a list', {:type => :feature}) do
  it('allows a user to click a list to see the tasks and details for it') do
    test_list = List.new({:name => 'School stuff', :id => nil})
    test_list.save()
    test_task = Tasks.new({:description => "learn SQL", :list_id => test_list.id()})
    test_task.save()
    visit('/lists')
    click_link(test_list.name())
    expect(page).to have_content(test_task.description())
  end
end

describe('adding tasks to a list', {:type => :feature}) do
  it('allows a user to add a task to a list') do
    test_list = List.new({:name => 'School stuff'})
    test_list.save()
    visit("/lists/#{test_list.id()}")
    fill_in("Description", {:with => "Learn SQL"})
    click_button("Add task")
    expect(page).to have_content("Success")
  end
end
