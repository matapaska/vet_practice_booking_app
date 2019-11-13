require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal.rb')
require_relative('../models/vet.rb')
require_relative('../models/owner.rb')

also_reload('../models/*')



get '/index/vets' do
  @vets = Vet.find_all
  erb(:"/vets/index")
end
