require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:car) { FactoryGirl.create(:car) }

  describe 'validations' do
   it { should validate_presence_of(:make) }
   it { should validate_presence_of(:design) }
   it { should validate_presence_of(:year) }
  end

  describe 'instance methods' do
    describe '#info' do
      it 'returns the car year and make and design' do
        car = Car.create(make: 'Honda', design: 'Civic', year: '1995')
        expect(car.info).to eq("1995 - Honda Civic")
      end
    end
  end

  describe 'class methods' do
    describe '.by_car_make' do
      it 'returns the cars ordered by make' do
      # setup code
      d = Dealership.create(name: 'Mike Hale', inventory: '2000')
      c0 = Car.create(make: 'Datsun', design: 'A4', year: '2005', dealership_id: d.id)
      c1 = Car.create(make: 'Honda', design: 'Civic', year: '1995', dealership_id: d.id)
      c2 = Car.create(make: 'Subaru', design: 'Impreza', year: '2012', dealership_id: d.id)

      # assertion / expectation code
      by_car_make = Car.all.by_car_make
      expect(by_car_make[0].make).to eq(c0.make)
      expect(by_car_make[1].make).to eq(c1.make)
      expect(by_car_make[2].make).to eq(c2.make)
      end
    end
  end
end
