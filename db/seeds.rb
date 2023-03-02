# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'
require 'open-uri'

p 'Initializing seed'
p 'accessing api'
url = 'https://tmdb.lewagon.com/movie/top_rated'
data_serialized = URI.open(url).read
data = JSON.parse(data_serialized)

data['results'].each do |d|
  movie = Movie.create(title: d['title'], overview: d['overview'], poster_url: d['poster_path'], rating: d['vote_average'])
  p "Inserted Movie: #{movie.title} with id #{movie.id}"
end
p 'Finished running seed'
