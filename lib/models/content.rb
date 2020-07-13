class Content
  attr_reader :title, :description, :keywords, :link

  @@all = []

#
  def initialize(title, description, keywords, link="Link not provided")
    @title = title
    @description = description
    @keywords = keywords
    @link = link

    #adds instance of Content to @@all
    @@all << self
  end

  def self.clear_search
    @@all.clear
  end

  def self.all
    @@all
  end

  def self.add_content(title, description, keywords, link)
    Content.new(title, description, keywords, link)
  end

end
