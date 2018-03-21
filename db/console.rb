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
puts ""
p Artist.all()
puts ""
all_albums_of_artist1 = artist1.discography()
p all_albums_of_artist1
puts ""
found_artist = Album.find_artist(2)
p found_artist
puts ""
artist_of_album2 = album2.tell_artist()
p artist_of_album2
