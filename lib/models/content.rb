class Nasa::Content
  attr_reader :title, :description, :keywords, :link

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

  # Class method definition using `self.method_name`
  def self.clear_search
    @@all.clear
  end

  def self.all
    @@all
  end

  def self.add_content(title, description, keywords, link)
    new(title, description, keywords, link)
  end

end
