# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

12.times do

  Note.create(
    title: Faker::Book.title,
    description: + Faker::Verb.base.capitalize + " " + Faker::Games::ElderScrolls.last_name + "\'s " + " " + Faker::Verb.past + " " + [Faker::Games::ElderScrolls.jewelry, Faker::Games::ElderScrolls.weapon].sample
  )

end
