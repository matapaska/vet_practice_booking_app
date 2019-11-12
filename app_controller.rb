require('sinatra')
require('sinatra/contrib/all')

require_relative('controllers/animals_controller.rb')
require_relative('controllers/notes_controller.rb')
require_relative('controllers/owners_controller.rb')
require_relative('controllers/vets_controller.rb')

get '/index' do
  erb(:index)
end
