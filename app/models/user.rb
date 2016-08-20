class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :nullify
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true
  has_secure_password

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true,
                  uniqueness: {case_sensitive: false},
                  format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".squeeze(' ').titleize
  end
end
