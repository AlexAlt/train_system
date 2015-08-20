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

post('/cities') do
  name = params.fetch("city_name")
  new_city = City.new({:name => name, :id => nil})
  new_city.save()
  @cities = City.all()
  redirect('/')
end

post('/trains') do
  name = params.fetch("train_name")
  new_train = Train.new({:name => name, :id => nil})
  new_train.save()
  @trains = Train.all()
  redirect('/')
end

get('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  erb(:trains)
end

get('/trains/:id/edit') do
  @train = Train.find(params.fetch("id").to_i)
  @cities = City.all()
  erb(:train_edit)
end

patch('/trains/:id') do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  city_ids = params.fetch("city_id")
  @train.update({:city_ids  => [city_ids]})
  @cities = City.all()
  erb(:trains)
end

delete('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  @train.delete()
  @trains = Train.all()
  erb(:success)
end

get('/cities/:id') do
  @city = City.find(params.fetch("id").to_i())
  erb(:cities)
end

get('/cities/:id/edit') do
  @city = City.find(params.fetch("id").to_i)
  @trains = Train.all()
  erb(:city_edit)
end
patch('/cities/:id') do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  train_ids = params.fetch("train_id")
  @city.update({:train_ids  => [train_ids]})
  @trains = Train.all()
  erb(:cities)
end
