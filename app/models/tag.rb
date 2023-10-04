class Tag < ApplicationRecord
  has_many :product_tags
  has_many :products, through: :product_tags
  validates :name, presence: true, uniqueness: true
end
