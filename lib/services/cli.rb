class Nasa::Cli
  attr_accessor :content


  # Method called at startup that brings up main menu
  def self.run
    self.main_menu
  end

  # Brings up .greeting, begins the search process, and then displays the provided results
  def self.main_menu
    self.greeting
    results = self.search_menu_command()
    self.display_content(results)
  end

  # Welcomes users and provides the list of available commands
  def self.greeting
    puts "\n\nWelcome to the NASA-CLI, here are your available commands: "
    puts ">> s - a keyword search of the Nasa Image and Video Library"
    puts ">> i - a search of the library focused for only images"
    puts ">> a - a search of the library focused for only audio clips"
    puts ">> v - a search of the library focused for only videos"
    puts ">> exit - exit NASA-CLI\n"
  end

  # Prompts the user for input
  def self.get_input
    puts "\n\nPlease make a selection.\n\n"
    input = gets.chomp!
    input
  end

  # Runs the specific search requested by the user and returns results as
  # an array ofNasa::Content objects, asks the user to submit a valid command,
  # or exits the program
  def self.search_menu_command
      command = self.get_input()

      case command
      when "s"
        self.keyword_search()
       Nasa::Content.all
      when "i"
        self.image_search()
       Nasa::Content.all
      when "a"
        self.audio_search()
       Nasa::Content.all
      when "v"
        self.video_search()
       Nasa::Content.all
      when "exit"
        puts "\n\nThank you, please come again!"
        exit
      else
        puts "\n\nCommand not recognized, please try again."
        self.main_menu
      end
  end

  # Gets search terms and createsNasa::Content objects based on the provided results
  def self.keyword_search
   Nasa::Content.clear_search
    puts "\n\nPlease enter your search terms.\n\n"
    terms = gets.chomp!
    terms = terms.split(" ").join("%20")

    search_results = Nasa::CliNasaAPI.basic_search(terms)
    search_results = search_results["collection"]["items"]

    search_results.each do |result|
      attributes = result["data"][0]
      links = result["links"][0] if result["links"] != nil

      title = attributes["title"]
      description = attributes["description"]
      keywords = attributes["keywords"]
      link = links["href"] if links != nil

     Nasa::Content.add_content(title, description, keywords, link)
    end
  end

  # Gets search terms and createsNasa::Content objects based on the provided results
  def self.image_search
   Nasa::Content.clear_search
    puts "\n\nPlease enter your image search terms.\n\n"
    terms = gets.chomp!
    terms = terms.split(" ").join("%20")

    search_results =Nasa::CliNasaAPI.media_search("image", terms)
    search_results = search_results["collection"]["items"]

    search_results.each do |result|
      attributes = result["data"][0]
      links = result["links"][0]

      title = attributes["title"]
      description = attributes["description"]
      keywords = attributes["keywords"]
      link = links["href"]

     Nasa::Content.add_content(title, description, keywords, link)
    end
  end

  # Gets search terms and createsNasa::Content objects based on the provided results
  def self.audio_search
   Nasa::Content.clear_search
    puts "\n\nPlease enter your audio search terms.\n\n"
    terms = gets.chomp!
    terms = terms.split(" ").join("%20")

    search_results =Nasa::CliNasaAPI.media_search("audio", terms)
    search_results = search_results["collection"]["items"]

    search_results.each do |result|
      attributes = result["data"][0]
      links = result["links"][0] if result["links"] != nil

      title = attributes["title"]
      description = attributes["description"]
      keywords = attributes["keywords"]
      link = links["href"] if links != nil

     Nasa::Content.add_content(title, description, keywords, link)
    end
  end

  # Gets search terms and createsNasa::Content objects based on the provided results
  def self.video_search
   Nasa::Content.clear_search
    puts "\n\nPlease enter your video search terms.\n\n"
    terms = gets.chomp!
    terms = terms.split(" ").join("%20")

    search_results =Nasa::CliNasaAPI.media_search("video", terms)
    search_results = search_results["collection"]["items"]

    search_results.each do |result|
      attributes = result["data"][0]
      links = result["links"][0] if result["links"] != nil

      title = attributes["title"]
      description = attributes["description"]
      keywords = attributes["keywords"]
      link = links["href"] if links != nil

     Nasa::Content.add_content(title, description, keywords, link)
    end
  end

  # Method for displaying a piece of content, navigating thorugh its data,
  # and prompting the user for their next valid command
  def self.display_content(results)
    input = ""
    page = 1

    while input != "s"

      current = results[page-1]
      puts "\n\nPage #{page}: #{current.title}"
      if current.link == nil
        puts "Link: link not available"
      else
        puts "Link: #{current.link}"
      end
      puts "\n\nHere are your available commands:"
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
