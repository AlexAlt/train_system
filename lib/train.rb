class Train
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_method(:==) do |another_train|
    (self.name()).==(another_train.name())
  end

  define_singleton_method(:all) do
    trains = []
    returned_trains = DB.exec("SELECT * FROM trains;")
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i()
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end


  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO trains_cities (train_id, city_id) VALUES (#{self.id()}, #{city_id});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end

  define_method(:cities) do
    train_cities = []
    results = DB.exec("SELECT city_id FROM trains_cities WHERE train_id = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first().fetch("name")
      train_cities.push(City.new({:name => name, :id => city_id}))
    end
    train_cities
  end

  define_singleton_method(:find) do |id|
    found_trains = nil
    Train.all().each() do |train|
      if train.id() == id
        found_trains = train
      end
    end
    found_trains
  end
end
