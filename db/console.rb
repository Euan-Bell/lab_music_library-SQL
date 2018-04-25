require('pry')
require_relative('../db/sql_runner')
require_relative('../models/artist')
require_relative('../models/album')

artist1 = Artist.new({'name' => 'Artic Monkeys'})
artist1.save

album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'AM',
  'genre' => 'indie'
  })
album1.save




binding.pry
nil
