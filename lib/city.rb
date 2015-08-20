class City
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_method(:==) do |another_city|
    self.id().==(another_city.id())
  end

  define_singleton_method(:all) do
    cities = []
    returned_cities = DB.exec("SELECT * FROM cities;")
    returned_cities.each() do |city|
      name = city.fetch('name')
      id = city.fetch('id').to_i()
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    found_cities = nil
    City.all().each() do |city|
      if city.id() == id
        found_cities = city
      end
    end
    found_cities
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO trains_cities (train_id, city_id) VALUES (#{train_id}, #{self.id()});")
    end

  end

  define_method(:trains) do
    trains_cities = []
    results = DB.exec("SELECT train_id FROM trains_cities WHERE city_id = #{self.id()};")
    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM trains where id = #{train_id};")
      name = train.first().fetch("name")

      trains_cities.push(Train.new({:name => name, :id => train_id}))
      binding.pry
    end
    trains_cities
  end

  define_method(:delete) do
    DB.exec("DELETE FROM cities WHERE id = #{self.id()}")
  end
end
