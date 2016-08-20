class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :category

  validates :title, presence: true, uniqueness: {message: "must be unique"}
  validates :description, presence: true, length: {minimum: 10}
  validates :price, presence: true
  validates_numericality_of :price, :greater_than => 0
  validates :category_id, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 6}
  validates :category_id, presence: true



  def self.search(keyword)
    #where(["title ILIKE ? OR description ILIKE ?", "%#{keyword}%", "%#{keyword}%"]).order(title: :desc, description: :desc)
    where(["title ILIKE ? ", "%#{keyword}%"]) | where(["description ILIKE ?", "%#{keyword}%"])
  end

  after_initialize :set_price_to_1
  before_validation :capitalize_title
  private

  def set_price_to_1
    self.price ||=1
  end
  def capitalize_title
    self.title.capitalize! if title
  end
end
