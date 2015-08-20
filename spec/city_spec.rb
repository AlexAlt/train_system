require('spec_helper')

describe(City) do
  describe('#==') do
    it('returns an equal when city name and train id is the same') do
      test_city = City.new({:name => "Portland"})
      test_city2 = City.new({:name => "Portland"})
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
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      expect(City.all()).to(eq([test_city]))
    end
  end

  describe('#update') do
    it('updates a city in the database') do
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      test_city.update({:name => "Seattle"})
      expect(test_city.name()).to(eq("Seattle"))
    end

    it("lets you add a train to a city") do
      test_train = Train.new({:name => "Green", :id => nil})
      test_train.save()
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      test_city.update({:train_ids => [test_train.id()]})
      expect(test_city.trains()).to(eq([test_train]))
    end
  end


  describe('#trains') do
    it('returns all of the trains that go to a city') do
      test_train = Train.new({:name => "Green", :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => "Red", :id => nil})
      test_train2.save()
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      test_city.update({:train_ids => [test_train.id()]})
      test_city.update({:train_ids => [test_train2.id()]})
      expect(test_city.trains()).to(eq([test_train, test_train2]))
    end
  end



  describe('#delete') do
    it('deletes a city from the database') do
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "Seattle", :id => nil})
      test_city2.save()
      test_city.delete()
      expect(City.all()).to(eq([test_city2]))
    end
  end
end
