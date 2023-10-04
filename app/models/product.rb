class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many :product_tags
  has_many :tags, through: :product_tags
end
