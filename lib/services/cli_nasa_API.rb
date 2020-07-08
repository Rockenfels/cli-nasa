# .basic_search for keyword search q={terms}
# .media_search for media_type (type, terms)

require 'httparty'
require_relative '../models/content.rb'
# ^^^^REMOVE ME AFTER YOU TEST YOUR METHODS!!!!!!!!!!!!!!^^^^^^^^^^

class CliNasaAPI
  @baseline = "https://images-api.nasa.gov"

  def basic_search(terms)
    formatted_terms = terms.split(" ").join("%")
    results = HTTParty.get(@baseline + "/search?q=#{formatted_terms}")
    results
  end

  def media_search(type, terms)
    formatted_terms = terms.split(" ").join("%")
    case type
    when "image"
      results = HTTParty.get(@baseline + "/search?q=#{formatted_terms}&media_type=image")
      results
    when "audio"
      results = HTTParty.get(@baseline + "/search?q=#{formatted_terms}&media_type=audio")
      results
    when "video"
      results = HTTParty.get(@baseline + "/search?q=#{formatted_terms}&media_type=video")
      results
  end
end
