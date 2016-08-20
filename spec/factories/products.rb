FactoryGirl.define do
  factory :product do
    title       {|n| Faker::Company.bs + n.to_s   }
    description {Faker::ChuckNorris.fact          }
    price       {10+rand(100000)                  }
  end
end
