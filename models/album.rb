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


end