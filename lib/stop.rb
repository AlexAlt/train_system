# class Stop
#   attr_reader(:train, :city, :time)
#
#   define_method(:initialize) do |attributes|
#     @train = attributes.fetch(:train)
#     @city = attributes.fetch(:city)
#     @time = attributes.fetch(:time)
#   end
#
#   define_method(:save) do
#     DB.exec("INSERT INTO trains_cities (train_id, city_id, stop_time) VALUES (#{@train.id()}, #{@city.id()}, '#{@time}');")
#   end
#
#   define_singleton_method(:all) do
#     stops = []
#     returned_stops = DB.exec("SELECT * FROM trains_cities;")
#     returned_stops.each() do |stop|
#       train_id = stop.fetch('train_id').to_i
#       city_id = stop.fetch('city_id').to_i()
#       time = stop.fetch("stop_time")
#       stops.push(Stop.new({:train => train_id, :city => city_id, :time => time}))
#     end
#     stops
#   end
#
#   define_method(:==) do |another_stop|
#     self.train().==(another_stop.train()).&(self.city().==(another_stop.city())).&(self.time().==(another_stop.time()))
#
#   end
# end
