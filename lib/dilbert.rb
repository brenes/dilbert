require 'nokogiri'
require 'open-uri'
require 'net/http'

module Dilbert

  def self.fetch date
    Dir.mkdir("#{File.dirname(__FILE__)}/../strips") unless File.exists?("#{File.dirname(__FILE__)}/../strips")
    FileUtils.mv open(strip_url(date)).path, "#{File.dirname(__FILE__)}/../strips/#{date}.jpg"
    "#{File.dirname(__FILE__)}/../strips/#{date}"
  end

  def self.strip_url date
    strip_url = "http://www.dilbert.com/strips/comic/#{date}"
    puts "Looking at #{strip_url}"

    strip = Nokogiri::HTML(open(strip_url))
    strip_img = strip.css('.STR_Image img').first
    "http://www.dilbert.com/#{strip_img.attr('src')}"
  end

end