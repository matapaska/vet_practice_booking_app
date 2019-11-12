require_relative('../db/sql_runner.rb')


class Note
attr_accessor :details
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @details = options['details']
  end

  def save()
    sql = "INSERT INTO notes
    (details)
    VALUES ($1)
    RETURNING *"
    values = [@details]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE notes
    SET(details)
    = ($1)
    WHERE id = $2"
    values = [@details, @id]
    SqlRunner.run(sql, values)
  end

  def animals()
    sql = "SELECT animals.* FROM animals
    INNER JOIN notes
    ON notes.id = animals.notes_id
    WHERE notes.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    note = result.map{|note| Animal.new(note)}
    return note
  end


  def self.find_all()
    sql = "SELECT * FROM notes"
    result = SqlRunner.run(sql)
    note = result.map{|note| Note.new(note)}
    return note
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM notes
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    note = Note.new(result)
    return note
  end

  def self.delete()
    sql ="DELETE FROM notes"
    SqlRunner.run(sql)
  end

end
