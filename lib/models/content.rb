class Nasa::Content
  attr_reader :title, :description, :keywords, :link, :media_type

  @@all = []

  #Ruby constructor call
  def initialize(title, description, keywords, link="Link not provided", media_type=nil)
    @title = title
    @description = description
    @keywords = keywords
    @link = link
    @media_type = media_type

    #adds instance of Content to @@all
    @@all << self
  end

  # Class method definition using "self.method_name"
  def self.clear_search
    @@all.clear
  end

  def self.all
    @@all
  end

  def self.add_content(title, description, keywords, link, media_type)
    new(title, description, keywords, link, media_type)
  end

  def to_s
    puts "Title: #{@title}"
    puts "Description: #{@description}"
    puts "Keywords: #{@keywords.to_s}"
    puts "Link: #{@link}"
    puts "Media type: #{@media_type}"
  end

end
