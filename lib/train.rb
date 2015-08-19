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
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
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

  define_method(:cities) do
    returned_cities = DB.exec("SELECT * FROM cities WHERE train_id = #{@id};")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch('name')
      id = city.fetch('id').to_i()
      train_id = city.fetch('train_id').to_i()
      cities.push(City.new({:id => id, :name => name, :train_id => train_id}))
    end
    cities
  end

  define_method(:add_cities) do |city|
    city.train_id = @id
    DB.exec("UPDATE cities SET train_id = #{@id} WHERE id = #{city.id()};")
  end
end
