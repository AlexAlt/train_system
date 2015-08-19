require('spec_helper')

describe(Train) do
  describe('#==') do
    it('is equal when name is the same') do
      test_train = Train.new({:name => "Green"})
      test_train.save()
      test_train2 = Train.new({:name => "Green"})
      test_train2.save()
      expect(test_train).to(eq(test_train2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a train to the database') do
      test_train = Train.new({:name => "Green", :id => nil})
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end

  describe('#update') do
    it('lets you update a train in the database') do
      test_train = Train.new({:name => "Green", :id => nil})
      test_train.save()
      test_train.update({:name => "Red"})
      expect(test_train.name()).to(eq("Red"))
    end
  end

  describe('#delete') do
    it('lets you delete a train in the database') do
      test_train = Train.new({:name => "Green", :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => "Red", :id => nil})
      test_train2.save()
      test_train.delete()
      expect(Train.all()).to(eq([test_train2]))
    end
  end

  describe('.find') do
    it('finds a train using its id') do
      test_train = Train.new({:name => "Green", :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => "Red", :id => nil})
      test_train2.save()
      expect(Train.find(test_train.id())).to(eq(test_train))
    end
  end
end
