# frozen_string_literal: true 

require 'sequel'
require 'faker'

# Connect to a sql3 database
DB = Sequel.connect('sqlite://intro.db')

# Create table if not exists
DB.create_table? :songs do
  primary_key :id

  String :name
  String :artist
  String :duration
  Integer :reproductions
  Boolean :restricted
end

# DB.from(:songs) = DB[:songs]
if DB[:songs]
  songs = DB.from(:songs)

  10.times do
    songs.insert(
      name: Faker::Music::RockBand.song,
      artist: Faker::Music::RockBand.name,
      duration: rand(0...5.0),
      reproductions: rand(1..1000),
      restricted: false
    )
  end

  # * -> Queries
  p '|-' * 10 + ' Queries'
  puts

end
