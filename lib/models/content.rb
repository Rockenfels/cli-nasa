require 'pry'
#^^^^^REMOVE ME AFTER TESTING!!!!!!!!^^^^^^^
class Content
  attr_reader :title, :description, :keywords, :link

  @@all = []

  def initialize(title, description, keywords, link)
    @title = title
    @description = description
    @keywords = keywords
    @link = link
    @@all << self
  end

  def self.clear_search
    @@all.clear
  end

  def self.all
    @@all
  end

  def add_content(title, description, keywords, link)
    Content.new(title, description, keywords, link)
  end
end
