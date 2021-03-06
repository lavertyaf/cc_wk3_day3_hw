require('pg')
require('pry')
require_relative('album')
require_relative('../db/sql_runner')

class Artist
  attr_reader :id, :name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists ( name )
    VALUES
    ( $1 )
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM artists"
    all_artists = SqlRunner.run(sql)
    return all_artists.map { |artist| Artist.new(artist) }
  end

  def discography()
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values =[@id]
    results_hashes = SqlRunner.run(sql, values)
    array_of_objects = results_hashes.map { |album_hash| Album.new(album_hash) }
    return array_of_objects
  end

end
