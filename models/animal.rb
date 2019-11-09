require_relative('../db/sql_runner.rb')


class Animal

attr_accessor :name, :type, :date_of_birth, :owner, :vet_id, :notes
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @date_of_birth = options['date_of_birth']
    @owner = options['owner']
    @vet_id = options['vet_id'].to_i
    @notes = options['notes']

  end

  def save()
    sql ="INSERT INTO animals(
    name, type, date_of_birth, owner, vet_id, notes)
    VALUES($1, $2, $3, $4, $5, $6)
    RETURNING*"
    values = [@name, @type, @date_of_birth, @owner, @vet_id, @notes]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE animals
    SET (name, type, date_of_birth, owner, vet_id, notes)
    = ($1, $2, $3, $4, $5, $6)
    WHERE id = $7"
    values = [@name, @type, @date_of_birth, @owner, @vet_id, @notes, @id]
    SqlRunner.run(sql, values)
  end

  def vets()
    vet = Vet.find_by_id(@vet_id)
    return vet
  end

  def self.delete()
    sql = "DELETE FROM animals"
    SqlRunner.run(sql)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM animals
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find_all()
    sql = "SELECT * FROM animals"
    result = SqlRunner.run(sql)
    animal = result.map{|animal| Animal.new(animal)}
    return animal
  end


  def self.find_by_id(id)
    sql = "SELECT * FROM animals
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    animal = Animal.new(result)
    return animal

  end


end
