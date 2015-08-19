require('spec_helper')

describe(City) do
  describe('#==') do
    it('returns an equal when city name and train id is the same') do
      test_city = City.new({:name => "Portland", :train_id => 1})
      test_city2 = City.new({:name => "Portland", :train_id => 1})
      expect(test_city).to(eq(test_city2))
    end
  end

  describe('.all') do
    it('initially returns empty') do
      expect(City.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a city to the database') do
      test_city = City.new({:name => "Portland", :train_id => 1, :id => nil})
      test_city.save()
      expect(City.all()).to(eq([test_city]))
    end
  end

  describe('#update') do
    it('updates a city in the database') do
      test_city = City.new({:name => "Portland", :train_id => 1, :id => nil})
      test_city.save()
      test_city.update({:name => "Seattle"})
      expect(test_city.name()).to(eq("Seattle"))
    end
  end

  describe('#delete') do
    it('deletes a city from the database') do
      test_city = City.new({:name => "Portland", :train_id => 1, :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "Seattle", :train_id => 1, :id => nil})
      test_city2.save()
      test_city.delete()
      expect(City.all()).to(eq([test_city2]))
    end
  end
end
