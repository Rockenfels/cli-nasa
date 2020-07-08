require 'pry'
require_relative '../models/content.rb'
require_relative './cli_nasa_API.rb'
#^^^^^REMOVE ME AFTER TESTING!!!!!!!!^^^^^^^

class Cli
  attr_accessor :content

  def initialize
  end

  def greeting
    puts "Welcome to the NASA-CLI, here are your available commands: "
    puts "k - a keyword search of the Nasa Image and Video Library"
    puts "i - a search of the library focused for only images"
    puts "a - a search of the library focused for only audio clips"
    puts "v - a search of the library focused for only videos"
    puts "exit - exit NASA-CLI"
  end

  def self.run
    self.greeting
    return if search_menu_command() == nil

  end

  def get_input
    puts "Please make a selection."
    input = gets.chomp!
    input
  end

  def search_menu_command
      command = get_input()

      case command
      when "k"
        keyword_search()
        Content.all[0]
      when "i"
        image_search()
        Content.all[0]
      when "a"
        audio_search()
        Content.all[0]
      when "v"
        video_searh()
        Content.all[0] 
      when "exit"
        return
      end
  end

  def keyword_search()
    Content.all.clear
    puts "Please enter your search terms."
    terms = gets.chomp!
    search_results = CliNasaAPI.basic_search(terms)
    search_results.each do |result|
      title = result["collection"]["items"]["data"]["title"]
      description = result["collection"]["items"]["data"]["description"]
      keywords = result["collection"]["items"]["data"]["keywords"]
      link = result["collection"]["items"]["data"]["links"]["href"]
      Content.add_content(title, description, keywords, link)
   end
  end

  def image_search
    Content.all.clear
    puts "Please enter your image search terms."
    terms = gets.chomp!
    search_results = CliNasaAPI.media_search("image", terms)
    search_results.each do |result|
      title = result["collection"]["items"]["data"]["title"]
      description = result["collection"]["items"]["data"]["description"]
      keywords = result["collection"]["items"]["data"]["keywords"]
      link = result["collection"]["items"]["data"]["links"]["href"]
      Content.add_content(title, description, keywords, link)
    end
  end

  def audio_search
    puts "Please enter your audio search terms."
    terms = gets.chomp!
    Content.all.clear
    search_results = CliNasaAPI.media_search("audio", terms)
    search_results.each do |result|
      title = result["collection"]["items"]["data"]["title"]
      description = result["collection"]["items"]["data"]["description"]
      keywords = result["collection"]["items"]["data"]["keywords"]
      link = result["collection"]["items"]["data"]["links"]["href"]
      Content.add_content(title, description, keywords, link)
    end
  end

  def video_search
    Content.all.clear
    puts "Please enter your video search terms."
    terms = gets.chomp!
    search_results = CliNasaAPI.media_search("video", terms)
    search_results.each do |result|
      title = result["collection"]["items"]["data"]["title"]
      description = result["collection"]["items"]["data"]["description"]
      keywords = result["collection"]["items"]["data"]["keywords"]
      link = result["collection"]["items"]["data"]["links"]["href"]
      add_content(title, description, keywords, link)
    end
  end

end
cli = Cli.new
binding.pry
