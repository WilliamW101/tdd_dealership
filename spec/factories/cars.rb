FactoryGirl.define do
  factory :car, class: Car do
    make "Honda"
    design "Civic"
    year "1995"
    dealership
  end
end
