require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    url = 'https://www.receptix.uk/br/developer?as=2'
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    jobs = Array.new
    job_listings = parsed_page.css('div.job-item')
    job_listings.each do |job_listing|
        job =  {
            title: job_listing.css('h2.itemHeader').text,
            link:  job_listing.css('a.jobItemUi').attr("href")
        }
        jobs << job
        puts "Job: #{job[:title]}"
        puts ""
        puts "#------------------#"
        puts ""
    end
end 

scraper
