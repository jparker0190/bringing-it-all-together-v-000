class Dog
  attr_accessor :name, :breed
  attr_reader :id
  def initialize(id=nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS dogs (id INTEGER PRIMARY KEY, name TEXT, breed TEXT)"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE dogs"
    DB[:conn].execute(sql)
  end

  def self.new_from_db(row)
    sql = "SELECT * FROM dogs"
    DB[:conn].execute(sql)
    Dog.new(row[0], row[1], row[2])
  end

  def self.new_from_db(row)
    sql = "SELECT * from dogs"
    DB[:conn].execute(sql)
    Dog.new(row[0], row[1], row[2])
  end

  def save
    if self.id
      self.update
    else
    sql = <<-SQL
    INSERT INTO dogs (name, breed) VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() from dogs")[0][0]
    end
  end

  def update
    sql = <<-SQL
    UPDATE dogs SET name = ?, breed = ? where id =?
    SQL
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

  def self.create(name, breed)
    stud = Dog.new(name, grade)
    stud.save
    stud
  end

end
