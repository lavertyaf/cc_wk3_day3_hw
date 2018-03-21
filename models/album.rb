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

  def self.find_artist(id)
    values = [id]
    sql = "SELECT * FROM albums WHERE id = $1"
    results = SqlRunner.run(sql, values)
    album_hash = results.first
    album = Album.new(album_hash)
    return album
  end

  def self.all()
    sql = "SELECT * FROM albums"
    all_albums = SqlRunner.run(sql)
    return all_albums.map { |album| Album.new(album) }
  end

  def tell_artist()
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [@artist_id]
    collection = SqlRunner.run(sql, values)
    return collection.map { |album| Album.new(album) }
  end

end
