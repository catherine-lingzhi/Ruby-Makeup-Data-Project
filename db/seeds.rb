require "net/http"
require "json"

ProductTag.delete_all
Product.delete_all
Brand.delete_all
Category.delete_all
Tag.delete_all

# Fetch API to populate data to datbase
url = "http://makeup-api.herokuapp.com/api/v1/products.json"
uri = URI(url)
response = Net::HTTP.get(uri)
data = JSON.parse(response)

data.each do |product_data|
  category = Category.find_or_create_by(name: product_data["product_type"])
  brand = Brand.find_or_create_by(name: product_data["brand"])

  if category && category.valid?
    product = category.products.create(
      name:        product_data["name"],
      price:       Faker::Commerce.price,
      image_link:  product_data["image_link"],
      description: product_data["description"],
      brand_id:    brand.id
    )

    product_data["tag_list"].each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      if product
        ProductTag.create(product_id: product.id, tag_id: tag.id)
      else
        puts "Product not found for tag: #{tag_name}"
      end
    end

  else
    puts "Invalid category #{product_data['product_type']}"
  end
end

puts "Created #{Category.count} categories"
puts "Created #{Brand.count} brands"
puts "Created #{Product.count} products"
puts "Created #{Tag.count} tags"
puts "Created #{ProductTag.count} product tags"
