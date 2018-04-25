require('pg')
require_relative('../db/sql_runner')
require_relative('../models/artist')


class Album
attr_reader :id, :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
    @title = options['title']
    @genre = options['genre']
  end

  def save()
    sql = 'INSERT INTO albums(artist_id, title, genre) VALUES($1, $2, $3) RETURNING id'
    values = [@artist_id, @title, @genre]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def artist()
    sql = 'SELECT * FROM artists WHERE id = $1'
    values = [@artist_id]
    artist = SqlRunner.run(sql, values)[0]
    return Artist.new(artist)
  end

  # def albums()
  #   sql = 'SELECT * FROM albums WHERE artist_id = $1'
  #   values = [@id]
  #   result = SqlRunner.run(sql, values)
  #   catalogue = result.map{ |album| Album.new(album)}
  #   return catalogue
  # end

  def self.all()
    sql = 'SELECT * FROM albums'
    albums = SqlRunner.run(sql)
    albums_array = albums.map{ |album| Album.new(album)}
    return albums_array
  end


end
