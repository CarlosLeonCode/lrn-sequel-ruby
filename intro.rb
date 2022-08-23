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
  end if songs.all.count == 0

# * -> Queries
  p '--' * 10 + ' Queries'
  puts

  p songs.count
  p '<>' * 5
  p songs.all
  p '<>' * 5
  puts

  # Songs names
  songs.each { |row| p row[:name] }
  puts

  # Sequel.lit, allows to use literal SQL
  reproductions = 350
  p songs.where(Sequel.lit('reproductions >=?', reproductions)).count.to_s + " songs with #{reproductions} or more reproductions!"
  puts

  some_artists = ['Nirvana', 'The Eagles']
  p songs.where(artist: some_artists).count.to_s + " songs with artist as #{some_artists.first} or #{some_artists.last}"
  puts

  # longer songs
  p songs.where(Sequel.like(:duration, '4%')).count.to_s + ' songs with more than 4 minutes'
  puts

  short_duration = songs.min(:duration)
  short_song = songs.where(duration: short_duration).first

  p short_song
  p "'#{short_song[:name]}' is the song shorter with #{short_song[:duration]} minutes"
  puts

  p songs.sum(:reproductions).to_s + ' reproductions with all the songs'
  puts

  # Select just one attr
  p songs.select(:name, :artist).first
end
