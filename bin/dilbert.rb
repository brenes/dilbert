#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require 'nokogiri'
require 'open-uri'

program :version, "1"
program :description, 'Fetch Dilbert strips and just enjoy'

default_command :fetch

command :fetch do |c|
  c.syntax = 'dilbert fetch [options]'
  c.summary = 'It just fetches dilbert strips!'
  c.description = 'Say a date and I give you Dilbert'
  c.example 'Fetching Dilbert strip from today', "dilbert fetch"
  c.example 'Fetching Dilbert strip from yesterday', "dilbert fetch #{Date.today-1}"

  c.action do |args, options|

    date = Date.parse(args.first) rescue Date.today
    strip_url = "http://www.dilbert.com/strips/comic/#{date}"
    puts "Looking at #{strip_url}"

    strip = Nokogiri::HTML(open(strip_url))
    strip_img = strip.css('.STR_Image img').first
    strip_img_url = "http://www.dilbert.com/#{strip_img.attr('src')}"

    puts "Hoorray!! The strip is at #{strip_img_url}"
  end
end

