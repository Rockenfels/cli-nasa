class Content
  att_reader :title, :description, :keywords

  @@all = []

  def initialize(title, description, keywords)
    @title = tiel
    @description = description
    @keywords = keywords
  end

  def self.clear_search
    @@all.clear
  end

end
