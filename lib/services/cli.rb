# require 'pry'
# require './cli_nasa_API.rb'
# require '../models/content.rb'
class Cli
  attr_accessor :content

  def self.greeting
    puts "\n\nWelcome to the NASA-CLI, here are your available commands: "
    puts ">> s - a keyword search of the Nasa Image and Video Library"
    puts ">> i - a search of the library focused for only images"
    puts ">> a - a search of the library focused for only audio clips"
    puts ">> v - a search of the library focused for only videos"
    puts ">> exit - exit NASA-CLI\n"
  end

  def self.run
    self.main_menu

    puts "Thank you, please come again!"
    return
  end

  def self.main_menu
    self.greeting
    results = self.search_menu_command()
    self.display_content(results)

  end

  def self.get_input
    puts "Please make a selection."
    input = gets.chomp!
    input
  end

  def self.search_menu_command
      command = self.get_input()

      case command
      when "s"
        self.keyword_search()
        Content.all
      when "i"
        self.image_search()
        Content.all
      when "a"
        self.audio_search()
        Content.all
      when "v"
        self.video_search()
        Content.all
      when "exit"
        puts "Thank you, please come again!"
        exit
      else
        "Command not recognized, please try again."
      end
  end

  def self.keyword_search
    Content.all.clear
    puts "Please enter your search terms."
    terms = gets.chomp!
    terms = terms.split(" ").join("%20")

    search_results = CliNasaAPI.basic_search(terms)
    search_results = search_results["collection"]["items"]

    search_results.each do |result|
      attributes = result["data"][0]
      links = result["links"][0] if result["links"] != nil

      title = attributes["title"]
      description = attributes["description_508"]
      keywords = attributes["keywords"]
      link = links["href"] if links != nil

      Content.add_content(title, description, keywords, link)
    end
  end

  def self.image_search
    Content.all.clear
    puts "Please enter your image search terms."
    terms = gets.chomp!
    terms = terms.split(" ").join("%20")

    search_results = CliNasaAPI.media_search("image", terms)
    search_results = search_results["collection"]["items"]

    search_results.each do |result|
      attributes = result["data"][0]
      links = result["links"][0]

      title = attributes["title"]
      description = attributes["description_508"]
      keywords = attributes["keywords"]
      link = links["href"]

      Content.add_content(title, description, keywords, link)
    end
  end

  def self.audio_search
    Content.all.clear
    puts "Please enter your audio search terms."
    terms = gets.chomp!
    terms = terms.split(" ").join("%20")

    search_results = CliNasaAPI.media_search("audio", terms)
    search_results = search_results["collection"]["items"]

    search_results.each do |result|
      attributes = result["data"][0]
      links = result["links"][0] if result["links"] != nil

      title = attributes["title"]
      description = attributes["description_508"]
      keywords = attributes["keywords"]
      link = links["href"] if links != nil

      Content.add_content(title, description, keywords, link)
    end
  end

  def self.video_search
    Content.all.clear
    puts "Please enter your video search terms."
    terms = gets.chomp!
    terms = terms.split(" ").join("%20")

    search_results = CliNasaAPI.media_search("video", terms)
    search_results = search_results["collection"]["items"]

    search_results.each do |result|
      attributes = result["data"][0]
      links = result["links"][0] if result["links"] != nil

      title = attributes["title"]
      description = attributes["description_508"]
      keywords = attributes["keywords"]
      link = links["href"] if links != nil

      Content.add_content(title, description, keywords, link)
    end
  end

  def self.display_content(results)
    input = ""
    page = 1
    current = results[page-1]
    while input != "s"
      puts "\n\nPage #{page}: #{current.title}"
      if current.link == nil
        puts "Link: link not available"
      else
        puts "Link: #{current.link}"
      end
      puts "\nHere are your available commands:"
      puts ">> k - Displays the content's keywords"
      puts ">> d - Displays the content's description."
      puts ">> n - Shows the next result"
      puts ">> p - Shows the previous result"
      puts ">> s - Start a new search."

      input = self.get_input()
      case input
      when "k"
        puts "\n\nKeywords : #{current.keywords}\n"
      when "d"
        puts "\n\nDescription : #{current.description}\n"
      when "n"
        if page < results.length
          page += 1
        else
          puts "\n\nThere are no further results.\n"
        end
      when "p"
        if page > 1
           page -= 1
        else
           puts "\n\nYou're at the top of your results.\n"
         end
      when "s"
        self.main_menu
      else
        puts "\n\nCommand not recognized, please try again.\n"
      end
    end
  end

end
