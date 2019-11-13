require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal.rb')
require_relative('../models/vet.rb')
require_relative('../models/owner.rb')
also_reload('../models/*')


get '/index/animals' do
  @animals = Animal.find_all
  erb(:"/animals/index")
end

get '/index/animals/new' do
  @vets = Vet.find_all
  @owners = Owner.find_all
  erb(:"animals/new")
end

post '/index/animals' do
  Animal.new(params).save
  redirect to '/index/animals'
end

get '/index/animals/:id' do
  @animal =Animal.find_by_id(params['id'].to_i)
  erb(:'/animals/show')
end

get '/index/animals/:id/edit' do
  @vets = Vet.find_all
  @owners = Owner.find_all
  @animal = Animal.find_by_id(params['id'])
  erb(:"animals/edit")
end

post '/index/animals/:id' do
  animal = Animal.new(params)
  animal.update
  redirect to "/index/animals/#{params['id']}"
end

post '/index/animals/:id/delete' do
  Animal.delete_by_id(params['id'])
  redirect to '/index/animals'
end
