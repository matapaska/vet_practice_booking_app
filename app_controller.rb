require('sinatra')
require('sinatra/contrib/all')

require_relative('controllers/animals_controller.rb')
require_relative('controllers/owners_controller.rb')
require_relative('controllers/vets_controller.rb')

also_reload('./style.css')
get '/index' do
  erb(:index)
end
