class City
  attr_reader(:name, :id, :train_id)
  attr_writer(:train_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
    @train_id = attributes[:train_id]
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
      train_id = city.fetch('train_id').to_i()
      cities.push(City.new({:name => name, :train_id => train_id, :id => id}))
    end
    cities
  end

  define_method(:save) do
    if ! @train_id
      @train_id = "NULL"
    end
    result = DB.exec("INSERT INTO cities (name, train_id) VALUES ('#{@name}', #{@train_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM cities WHERE id = #{self.id()}")
  end
end
