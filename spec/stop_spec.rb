# require('spec_helper')
#
# describe(Stop) do
#   describe('#save') do
#     it("lets you save a new stop") do
#     test_train = Train.new({:name => "Green", :id => nil})
#     test_train.save()
#     test_city = City.new({:name => "Portland", :id => nil})
#     test_city.save()
#     test_stop = Stop.new(:train => test_train, :city => test_city, :time => "07:00:00" )
#     test_stop.save()
#     expect(Stop.all()).to(eq([test_stop]))
#     end
#   end
#
#   describe(".all") do
#     it("initially returns empty") do
#       expect(Stop.all()).to(eq([]))
#     end
#   end
# end
