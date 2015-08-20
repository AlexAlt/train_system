require('spec_helper')
require('capybara/rspec')
require('./app')
require('launchy')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('to home path', {:type => :feature}) do
  it('allows you to add a train') do
    visit('/')
    fill_in('train_name', :with => "Green")
    click_button('Add Train')
    expect(page).to have_content("Success!")
  end
end

describe('to train details page', {:type => :feature}) do
  it('shows you the details for an individual train') do
    test_train = Train.new({:name => 'Green', :id => nil})
    test_train.save()
    test_city = City.new({:name => 'Portland', :id => nil})
    test_city.save()
    visit('/')
    click_link('Green')
    expect(page).to have_content('Portland')
  end
end

describe('to city details page', {:type => :feature}) do
  it('shows you the details for an individual city') do
    test_city = City.new({:name => 'Portland', :id => nil})
    test_city.save()
    visit('/')
    click_link('Portland')
    expect(page).to have_content('Portland')
  end
end

describe('adding a city to the train', {:type => :feature}) do
  it('allows a user to add a city to the specific train') do
    test_train = Train.new({:name => "Green", :id => nil})
    test_train.save()
    visit("/trains/#{test_train.id()}")
    fill_in('name', :with => "Portland")
    click_button("Add")
    expect(page).to have_content("Portland")
  end
end

describe('viewing edit form for a train', {:type => :feature}) do
  it('displays the form to edit a train') do
    test_train = Train.new({:name => "Green", :id => nil})
    test_train.save()
    visit("/trains/#{test_train.id()}")
    click_link("Edit")
    expect(page).to have_content("Green")
  end
end

describe('updating  a train', {:type => :feature}) do
  it('allows a user to update a specific train') do
    test_train = Train.new({:name => "Green", :id => nil})
    test_train.save()
    visit("/trains/#{test_train.id()}/edit")
    fill_in('name', :with => "Red")
    click_button("Update")
    expect(page).to have_content("Red")
  end
end

describe('deleting a train', {:type => :feature}) do
  it('allows a user to delete a train') do
    test_train = Train.new({:name => "Green", :id => nil})
    test_train.save()
    visit("/trains/#{test_train.id()}/edit")
    click_button("Delete Train")
    expect(page).to have_content("Success!")
  end
end
