class Dealership < ApplicationRecord
  has_many :cars
  validates_presence_of :name, :inventory

  def self.by_name
    order(:name)
  end

  def car_count
    "#{name} - #{inventory} Cars Available"
  end

end
