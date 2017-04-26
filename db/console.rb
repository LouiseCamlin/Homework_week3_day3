require('pry-byebug')
require_relative('../models/artist.rb')
require_relative('../models/album.rb')

artist1 = Artist.new({ 'name' => 'Pixies' })
artist2 = Artist.new({ 'name' => 'And So I Watch You From Afar' })
artist1.save()
artist2.save()

album1 = Album.new({
  'title' => 'Surfer Rosa',
  'genre' => 'Proto-Grunge',
  'artist_id' => artist1.id
  })
album1.save()

album2 = Album.new({
  'title' => 'Gangs',
  'genre' => 'Post Rock',
  'artist_id' => artist2.id
})
album2.save()

album3 = Album.new({
  'title' => 'Doolittle',
  'genre' => 'Proto-Grunge',
  'artist_id' => artist1.id
  })
album3.save()





binding.pry
nil