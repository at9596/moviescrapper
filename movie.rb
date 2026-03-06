class Movie
  attr_reader :title, :year, :rating, :url

  def initialize(title, year, rating, url)
    @title = title
    @year = year
    @rating = rating
    @url = url
  end
end