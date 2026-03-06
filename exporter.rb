require 'csv'

class Exporter

  def self.to_csv(movies, filename = "output/movies.csv")
    CSV.open(filename, "w") do |csv|
      csv << ["Title", "Year", "Rating", "URL"]

      movies.each do |movie|
        csv << [
          movie.title,
          movie.year,
          movie.rating,
          movie.url
        ]
      end
    end
  end

end