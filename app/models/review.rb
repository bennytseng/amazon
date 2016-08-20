class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :stars, presence: true
  validates :stars, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
end
