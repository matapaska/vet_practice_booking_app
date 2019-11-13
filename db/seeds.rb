require_relative( "../models/animal.rb" )
require_relative( "../models/vet.rb" )
require_relative( "../models/owner.rb" )

require("pry-byebug")

Animal.delete
Vet.delete
Owner.delete



vet1 = Vet.new({
  "name" => "Suzy"
})

vet2 = Vet.new({
  "name" => "Lucy"
})
vet1.save
vet2.save

# vets = Vet.find_all

owner1 = Owner.new({
"name" => "Dougie Dogger",
"address" => "39 Castle Terrace, Edinburgh",
"phone" => "07776665554"
  })

owner2 = Owner.new({
  "name" => "Vicky Woolf",
  "address" => "39 Castle Terrace, Edinburgh",
  "phone" => "07774445556"
  })

  owner1.save
  owner2.save

  owners = Owner.find_all



animal1 = Animal.new({
"name" => "Sissy",
"type" => "sausage dog",
"date_of_birth" => "13 December 2011",
"owner_id" => owner1.id,
"vet_id" => vet1.id,
"notes" => "Results awaiting"
})
animal2 = Animal.new({
"name" => "Woolfy",
"type" => "shepard dog",
"date_of_birth" => "11 December 2013",
"owner_id" => owner2.id,
"vet_id" => vet1.id,
"notes" => "Call back"
})

animal1.save
animal2.save


# animals = Animal.find_all
# without_animal2 = Animal.delete_by_id(animal2.id)


binding.pry
nil
