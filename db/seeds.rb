require_relative( "../models/animal.rb" )
require_relative( "../models/vet.rb" )
require("pry-byebug")

Animal.delete
Vet.delete


vet1 = Vet.new({
  "name" => "Suzy"
})

vet2 = Vet.new({
  "name" => "Lucy"
})
vet1.save
vet2.save

# vets = Vet.find_all


animal1 = Animal.new({
"name" => "Sissy",
"type" => "sausage dog",
"DOB" => "13 December 2011",
"owner" => "Dougie Dog",
"vet_id" => vet1.id,
"notes" => "Check up due"
})
animal2 = Animal.new({
"name" => "Woolfy",
"type" => "shepard dog",
"DOB" => "11 December 2013",
"owner" => "Vicky Woolf",
"vet_id" => vet1.id,
"notes" => "Check up completed"
})

animal1.save
animal2.save

# animals = Animal.find_all
# without_animal2 = Animal.delete_by_id(animal2.id)

binding.pry
nil
