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
    fill_in('name', :with => "Green")
    click_button('Add Train')
    expect(page).to have_content("Green")
  end
end
