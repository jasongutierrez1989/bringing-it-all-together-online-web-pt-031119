class Dog
  attr_accessor :id, :name, :breed

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}",v) unless v.nil?
    end
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs(
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
      )
      SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE dogs"

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
    #dog = Dog.new

    #dog.id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    #dog.name = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][1]
    #dog.breed = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][2]

    #dog
  end


end
