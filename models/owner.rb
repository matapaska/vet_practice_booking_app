require_relative('../db/sql_runner.rb')


class Owner
attr_accessor :name, :phone, :address
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @phone = options['phone']
    @address = options['address']
  end

  def save()
    sql = "INSERT INTO owners
    (name, phone, address)
    VALUES ($1, $2, $3)
    RETURNING *"
    values = [@name, @phone, @address]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE owners
    SET(name, phone, address)
    = ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @phone, @address, @id]
    SqlRunner.run(sql, values)
  end

  def animals()
    sql = "SELECT animals.* FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    WHERE owners.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    animal = result.map{|animal| Animal.new(animal)}
    return animal
  end

  def self.find_all()
    sql = "SELECT * FROM owners"
    result = SqlRunner.run(sql)
    owner = result.map{|owner| Owner.new(owner)}
    return owner
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM owners
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    owner = Owner.new(result)
    return owner
  end

  def self.delete()
    sql ="DELETE FROM owners"
    SqlRunner.run(sql)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM owners
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

end
