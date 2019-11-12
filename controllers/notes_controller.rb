require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal.rb')
require_relative('../models/vet.rb')
require_relative('../models/owner.rb')
require_relative('../models/note.rb')
also_reload('../models/*')


get '/index/notes/:id' do
  @note = Note.find_by_id(params['id'].to_i)
  erb(:"notes/show")
end

get '/index/notes/:id/edit' do
  @note = Note.find_by_id(params['id'])
  # @animal = Animal.find_by_id(params['id'])
  erb(:"notes/edit")
end

post '/index/notes/:id' do
  note = Note.new(params)
  note.update
  redirect to "/index/notes/#{params['id']}"
end
