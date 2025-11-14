require 'open-uri'
puts "Cleaning the DB...."
List.destroy_all
Movie.destroy_all

# the Le Wagon copy of the API
puts "Creating movies.... \n"
(1..5).to_a.each do |num|
  url = "http://tmdb.lewagon.com/movie/top_rated?page=#{num}"
  response = JSON.parse(URI.open(url).read)

  response['results'].each do |movie_hash|
    puts "...creating the movie #{movie_hash['title']}..."
    puts
    # create an instance with the hash
    Movie.create!(
      poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash['poster_path'],
      rating: movie_hash['vote_average'],
      title: movie_hash['title'],
      overview: movie_hash['overview']
    )
  end
end
puts "... created #{Movie.count} movies."

list = List.create(name: 'Comedy')
photo = URI.parse("https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQaUiPLJpaxXAL-CGwnV-UUKic7arMB-yY4SY7enUbFgSksNG0BClmStlVX4vJO7EIkOODAr7zgP5aO0sPt3iG3XKNVEfbyLY-xQ4bMpzVHHRkSziQ5MnueXkDn4VXT2RfN7C4QEgg-2OvnrRVTfNluW7.jpg?r=936").open
list.photo.attach(io: photo, filename: "photo.png", content_type: "image/png")
list.save

list = List.create(name: 'Action')
photo = URI.parse("https://deadline.com/wp-content/uploads/2025/05/Rambo-First-Blood.webp?w=681&h=383&crop=1").open
list.photo.attach(io: photo, filename: "photo.png", content_type: "image/png")
list.save

puts "......Lists seeded"
