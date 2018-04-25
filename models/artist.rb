require('pg')
require_relative('../db/sql_runner')


class Artist
attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

##INSTANCE CLASS

  def save()
    sql = 'INSERT INTO artists(name) VALUES($1) RETURNING id'
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def albums()
    sql = 'SELECT * FROM albums WHERE artist_id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values)
    catalogue = result.map{ |album| Album.new(album)}
    return catalogue
  end

  ##CLASS METHODS

  def self.all()
    sql = 'SELECT * FROM artists'
    artists = SqlRunner.run(sql)
    artists_array = artists.map{ |artist| Artist.new(artist)}
    return artists_array
  end

end
