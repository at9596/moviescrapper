require 'selenium-webdriver'
require 'nokogiri'
require_relative 'movie'
require_relative 'exporter'

class MovieScraper

  URL = "https://www.imdb.com/chart/top/"

  def fetch_page
    driver = Selenium::WebDriver.for :chrome
    driver.get(URL)

    html = driver.page_source
    driver.quit

    Nokogiri::HTML(html)
  end

  def scrape
    doc = fetch_page
    movies = doc.css('.cli-children')

    movies_list = []

    movies.each do |movie|
      title = movie.css('.ipc-title__text').text.strip
      year = movie.css('.cli-title-metadata-item').first&.text
      rating = movie.css('.ipc-rating-star--rating').text
      url = "https://www.imdb.com" + movie.css('.ipc-title-link-wrapper').attr('href').value

      movies_list << Movie.new(title, year, rating, url)
    end

    movies_list
  end
end


scraper = MovieScraper.new
movies = scraper.scrape

Exporter.to_csv(movies)

puts "Scraping completed. CSV saved in output/movies.csv"