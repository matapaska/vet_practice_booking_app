require('sinatra')
require('sinatra/contrib/all')
require_relative('models/animal.rb')
require_relative('models/vet.rb')
also_reload('./models/*')

get '/index' do
  erb(:index)
end

get '/index/animals' do
  @animals = Animal.find_all
  erb(:"/animals/index")
end

get '/index/animals/:id' do
  @animal =Animal.find_by_id(params['id'])
  erb(:'/animals/show')

end

get '/index/vets' do
  @vets = Vet.find_all
  erb(:"/vets/index")
end




# get '/students' do
#   @students = Student.all
#   erb(:index)
# end
#
# get '/students/new' do
#   @houses = House.all
#   erb(:new)
# end
#
# post '/students' do
#   Student.new(params).save
#   redirect to '/students'
# end
#
# get '/students/:id' do
#   @student = Student.find(params['id'])
#   erb(:show)
# end
#
# get '/students/:id/edit' do
#   @houses = House.all
#   @student = Student.find(params['id'])
#   erb(:edit)
# end
#
# post '/students/:id' do
#   student = Student.new(params)
#   student.update
#   redirect to "/students/#{params['id']}"
# end
#
# post '/students/:id/delete' do
#   student = Student.find(params['id'])
#   student.delete
#   redirect to '/students'
# end
