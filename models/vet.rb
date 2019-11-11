require_relative('../db/sql_runner.rb')


class Vet
attr_accessor :name
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO vets
    (name)
    VALUES ($1)
    RETURNING *"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE vets
    SET(name)
    = ($1)
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def animals()
    sql = "SELECT animals.* FROM animals
    INNER JOIN vets
    ON vets.id = animals.vet_id
    WHERE vets.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    animal = result.map{|animal| Animal.new(animal)}
    return animal
  end

  def self.find_all()
    sql = "SELECT * FROM vets"
    result = SqlRunner.run(sql)
    vet = result.map{|vet| Vet.new(vet)}
    return vet
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM vets
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    vet = Vet.new(result)
    return vet
  end

  def self.delete()
    sql ="DELETE FROM vets"
    SqlRunner.run(sql)
  end

end
