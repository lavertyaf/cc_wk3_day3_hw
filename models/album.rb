require('pg')
require('pry')
require_relative('artist')
require_relative('../db/sql_runner')

class Album
  attr_reader :id
  attr_accessor :name, :genre, :artist_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def save()
    sql = "INSERT INTO albums ( name,
    genre,
    artist_id)
    VALUES
    ( $1, $2, $3 )
    RETURNING id"
    values = [@name, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums"
    collection = SqlRunner.run(sql)
    return collection.map { |album| Album.new(album) }
  end

end
