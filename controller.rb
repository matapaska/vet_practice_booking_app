require('sinatra')
require('sinatra/contrib/all')
require_relative('models/animal.rb')
require_relative('models/vet.rb')
require_relative('models/owner.rb')
require_relative('models/note.rb')
also_reload('./models/*')

get '/index' do
  erb(:index)
end

get '/index/animals' do
  @animals = Animal.find_all
  erb(:"/animals/index")
end

get '/index/animals/new' do
  @vets = Vet.find_all
  @owners = Owner.find_all
  erb(:"animals/new")
end

get '/index/animals/:id' do
  @animal =Animal.find_by_id(params['id'].to_i)
  erb(:'/animals/show')
end

get '/index/vets' do
  @vets = Vet.find_all
  erb(:"/vets/index")
end

get '/index/owners' do
  @owners = Owner.find_all
  erb(:"owners/index")
end

get '/index/owners/new' do
  erb(:"owners/new")
end

get '/index/owners/:id' do
  @owner = Owner.find_by_id(params['id'].to_i)
  erb(:"owners/show")
end
get '/index/notes/:id' do
  @note = Note.find_by_id(params['id'].to_i)
  erb(:"notes/show")
end

get '/index/animals/:id/edit' do
  @vets = Vet.find_all
  @owners = Owner.find_all
  @animal = Animal.find_by_id(params['id'])
  erb(:"animals/edit")
end

get '/index/owners/:id/edit' do
  @owner = Owner.find_by_id(params['id'])
  # @animal = Animal.find_by_id(params['id'])
  erb(:"owners/edit")
end

post '/index/animals/:id/delete' do
  Animal.delete_by_id(params['id'])
  redirect to '/index/animals'
end

# post '/index/owners/:id/delete' do
#   Owner.delete_by_id(params['id'])
#   redirect to '/index/owners'
# end

post '/index/animals' do
  Animal.new(params).save
  redirect to '/index/animals'
end

post '/index/owners' do
  Owner.new(params).save
  redirect to '/index/animals/new'
end

post '/index/animals/:id' do
  animal = Animal.new(params)
  animal.update
  redirect to "/index/animals/#{params['id']}"
end

post '/index/owners/:id' do
  owner = Owner.new(params)
  owner.update
  redirect to "/index/owners/#{params['id']}"
end
