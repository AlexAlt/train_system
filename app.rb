require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require('pg')
require('pry')

DB = PG.connect({:dbname => "train_system_test"})

get('/') do
  @trains = Train.all()
  @cities= City.all()
  erb(:index)
end

post('/trains') do
  name = params.fetch("train_name")
  new_train = Train.new({:name => name, :id => nil})
  new_train.save()
  @trains = Train.all()
  erb(:success)
end

get('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  erb(:trains)
end

post('/new_cities') do
  name = params.fetch("city_name")
  new_city = City.new({:name => name, :id => nil, :train_id => nil})
  new_city.save()
  @cities = City.all()
  erb(:success)
end

get('/cities/:id') do
  @city = City.find(params.fetch("id").to_i())
  erb(:cities)
end

post('/cities') do
  name = params.fetch('name')
  train_id = params.fetch("train_id").to_i()
  @train = Train.find(train_id)
  new_city = City.new({:name => name, :train_id => train_id})
  new_city.save()
  @cities = City.all()
  redirect("trains/#{train_id}")
end

get('/trains/:id/edit') do
  @train = Train.find(params.fetch("id").to_i)
  erb(:train_edit)
end

patch('/trains/:id') do
  name = params.fetch("name")
  @train = Train.find(params.fetch("id").to_i())
  @train.update({:name => name})
  erb(:trains)
end

delete('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  @train.delete()
  @trains = Train.all()
  erb(:success)
end
