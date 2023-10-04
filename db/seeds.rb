require "net/http"
require "json"

Category.delete_all
Brand.delete_all
Tag.delete_all
Product.delete_all
ProductTag.delete_all

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
      price:       product_data["price"],
      image_link:  product_data["image_link"],
      description: product_data["description"],
      brand_id:    brand.id
    )
  else
    puts "Invalid category #{product_data['product_type']}"
  end
end
