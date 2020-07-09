class Cli
  attr_accessor :content

  def self.greeting
    puts "Welcome to the NASA-CLI, here are your available commands: "
    puts ">> s - a keyword search of the Nasa Image and Video Library"
    puts ">> i - a search of the library focused for only images"
    puts ">> a - a search of the library focused for only audio clips"
    puts ">> v - a search of the library focused for only videos"
    puts ">> exit - exit NASA-CLI"
  end

  def self.run
    greeting
    results = []

    results = self.search_menu_command()
    until result == "Thank you, please come again!"
      self.display_content(results)
      results = self.search_menu_command()
    end

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
        "Thank you, please come again!"
        return
      else
        "Command not recognized, please try again."
      end
  end

  def self.keyword_search()
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

  def self.image_search
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

  def self.audio_search
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

  def self.video_search
    Content.all.clear
    puts "Please enter your video search terms."
    terms = gets.chomp!
    search_results = CliNasaAPI.media_search("video", terms)
    search_results.each do |result|
      title = result["collection"]["items"]["data"]["title"]
      description = result["collection"]["items"]["data"]["description"]
      keywords = result["collection"]["items"]["data"]["keywords"]
      link = result["collection"]["items"]["data"]["links"]["href"]
      Content.add_content(title, description, keywords, link)
    end
  end

  def self.display_content(result)
    input = ""
    page = 1
    while input != "s"
      puts "Page #{page}: #{result[page-1].title} \n #{result[page-1].link}"
      puts "Here are your available commands:"
      puts ">> k - Displays the content's keywords"
      puts ">> d - Displays the content's description."
      puts ">> n - Shows the next result"
      puts ">> p - Shows the previous result"
      puts ">> s - Start a new search."

      input = self.get_input()
      case input
      when "k"
        puts "Keywords : #{result[page-1].keywords}"
      when "d"
        puts "Description : #{result.description}"
      when "n"
        page < result.length ? page += 1 : "There are no further results."
      when "p"
        page > 1 ? page -= 1 : "You're at the top of your results."
      else
        "Command not recognized, please try again."
      end
    end
  end

end
