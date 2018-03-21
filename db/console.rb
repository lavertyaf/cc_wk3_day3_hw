require('pg')
require('pry')
require_relative('../models/artist')
require_relative('../models/album')

# Artist.delete_all()
# Album.delete_all()

artist1 = Artist.new({ 'name' => 'Scott Hutchison' })
artist2 = Artist.new({ 'name' => 'Sam McTrusty' })
artist3 = Artist.new({ 'name' => 'Simon Neil' })

artist1.save()
artist2.save()
artist3.save()

album1 = Album.new({ 'name' => 'Pedestrian Verse', 'genre' => 'Folk Rock', 'artist_id' => artist1.id })
album2 = Album.new({ 'name' => 'Vivarium', 'genre' => 'Guitar Rock', 'artist_id' => artist2.id })
album3 = Album.new({ 'name' => 'Ellipsis', 'genre' => 'Rock', 'artist_id' => artist3.id })

album1.save()
album2.save()
album3.save()

p Album.all()
p Artist.all()
