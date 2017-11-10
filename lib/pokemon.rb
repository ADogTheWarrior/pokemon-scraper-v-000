class Pokemon
  @@all = []
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @hp = 60
    @@all << self
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
  end

  def self.find(id, db)
    pokemon_array = db.execute("SELECT * FROM pokemon WHERE id = #{id}")
    attributes = {}
    attributes[:id] = pokemon_array[0][0]
    attributes[:name] = pokemon_array[0][1]
    attributes[:type] = pokemon_array[0][2]
    if pokemon_array[0][3] != nil
      attributes[:hp] = pokemon_array[0][3]
      # binding.pry
    end
    attributes[:db] = db
    binding.pry
    Pokemon.new(attributes)
  end

  def self.all
    all
  end

  def alter_hp(new_health, db)
    db.execute("UPDATE pokemon SET hp = #{new_health} WHERE id = #{@id}")
      # db.execute("UPDATE pokemon SET hp = 5 WHERE id = 1")
    @hp = new_health
    binding.pry
  end
end
