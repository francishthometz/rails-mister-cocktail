# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

puts 'Destroy Cocktails'
Cocktail.destroy_all

puts 'Destroy ingredients'
Ingredient.destroy_all

puts 'Create ingredients'
url1 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients = JSON.parse(open(url1).read)
ingredients['drinks'].each do |ingredient|
  i = Ingredient.create(name: ingredient['strIngredient1'])
  puts "create #{i.name}"
end

puts 'Create cocktails'
url2 = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
cocktails = JSON.parse(open(url2).read)
cocktails['drinks'].each do |cocktail|
  c = Cocktail.new(name: cocktail['strDrink'])
  url3 = cocktail['strDrinkThumb']
  c.remote_photo_url = url3
  c.save
end
