require 'rails_helper'

RSpec.describe Dealership, type: :model do
  let(:dealership) {FactoryGirl.create(:dealership)}

    describe 'validations' do
     it { should validate_presence_of(:name) }
     it { should validate_presence_of(:inventory) }
  end

    describe 'associations' do
     it { should have_many :cars}
  end

  describe 'instance methods' do
    describe '#car_count' do # instance methods are called by #
      it 'returns the dealership name and the inventory of cars' do
        d = Dealership.create(name: 'Larry H Miller', inventory: '200')
        expect(d.car_count).to eq("Larry H Miller - 200 Cars Available")
      end
    end
  end

  describe 'class methods' do
    describe '.by_name' do
      it 'returns the dealerships ordered by name' do
      # setup code
      d1 = Dealership.create(name: 'Dave Honda', inventory: '300')
      d2 = Dealership.create(name: 'Larry H Miller', inventory: '250')
      d3 = Dealership.create(name: 'Mike Hale', inventory: '400')

      # assertion / expectation code
      by_name = Dealership.all.by_name
      expect(by_name[0].name).to eq(d1.name)
      expect(by_name[1].name).to eq(d2.name)
      expect(by_name[2].name).to eq(d3.name)
      end
    end
  end
end
