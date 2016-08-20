PRODUCTS_TO_CREATE = 1000


PRODUCTS_TO_CREATE.times do
  p = Product.new(title: Faker::Name.name,
                  description: Faker::Internet.email,
                  price: rand(1000),
                  category_id: 1+rand(6))
end

puts "Created #{PRODUCTS_TO_CREATE} products"
