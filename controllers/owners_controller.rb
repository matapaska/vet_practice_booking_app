require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal.rb')
require_relative('../models/vet.rb')
require_relative('../models/owner.rb')

also_reload('../models/*')

get '/index/owners' do
  @owners = Owner.find_all
  erb(:"owners/index")
end

get '/index/owners/new' do
  erb(:"owners/new")
end

post '/index/owners' do
  Owner.new(params).save
  redirect to '/index/animals/new'
end

get '/index/owners/no_go' do
  erb(:"owners/no_go")
end

get '/index/owners/:id' do
  @owner = Owner.find_by_id(params['id'].to_i)
  erb(:"owners/show")
end

get '/index/owners/:id/edit' do
  @owner = Owner.find_by_id(params['id'])
  erb(:"owners/edit")
end

post '/index/owners/:id/delete' do
  @owner = Owner.find_by_id(params['id'].to_i)
  if @owner.animals.length > 0
    redirect to '/index/owners/no_go'
  else
    Owner.delete_by_id(params['id'])
    redirect to '/index/owners'
  end
end

post '/index/owners/:id' do
  owner = Owner.new(params)
  owner.update
  redirect to "/index/owners/#{params['id']}"
end
