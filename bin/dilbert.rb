#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require_relative '../lib/dilbert'

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
    strip_file = Dilbert.fetch(date)
    system "eog #{strip_file} &"

  end
end

