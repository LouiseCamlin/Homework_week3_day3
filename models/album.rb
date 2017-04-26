require_relative('../db/sql_runner.rb')
require_relative('./artist.rb')

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @artist_id = params['artist_id'].to_i if params['artist_id']
    @title = params['title']
    @genre = params['genre']
  end

  def save
    sql = "
    INSERT INTO albums (
      artist_id,
      title,
      genre
    ) VALUES (
    #{ @artist_id },
    '#{ @title }',
    '#{ @genre }'
    )
    RETURNING id;"

    result = SqlRunner.run(sql)
    result_hash = result.first()
    new_id = result_hash['id']
    @id = new_id.to_i()
  end

  def Album.all()
    sql = "SELECT * FROM albums;"
    album_hashes = SqlRunner.run(sql)
    album_objects = album_hashes.map do |album_hash|
      Album.new(album_hash)
    end
    return album_objects
  end

  def delete()
    sql = "DELETE FROM album WHERE id = #{id};"
    SqlRunner.run(sql)
  end

  def Album.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE albums SET (
      title,
      genre
    ) = (
    '#{ title },
    #{ genre }
    )
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def artist()
    sql = "SELECT * FROM artists
    WHERE id = #{@artist_id};"

    results = SqlRunner.run(sql)
    artist_hash = results.first()
    artist_object = Artist.new(artist_hash)

    return artist_object
  end

  def Album.find(id)
    sql = " SELECT FROM albums WHERE id = #{id}"
    results = SqlRunner.run(sql)
    album_hash = results.first
    album = Album.new(album_hash)
    return album

  end

end