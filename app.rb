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
  erb(:index)
end
