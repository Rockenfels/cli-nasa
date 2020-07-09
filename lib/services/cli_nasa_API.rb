# require 'httparty'
class CliNasaAPI
  @baseline = "https://images-api.nasa.gov"

  def self.basic_search(terms)
    results = HTTParty.get(@baseline + "/search?q=#{terms}")

  end

  def self.media_search(type, terms)
    case type
    when "image"
      results = HTTParty.get(@baseline + "/search?q=#{terms}&media_type=image", format: :plain)
      parsed_results = JSON.parse(results.body)
      parsed_results
    when "audio"
      results = HTTParty.get(@baseline + "/search?q=#{terms}&media_type=audio", format: :plain)
      parsed_results = JSON.parse(results.body)
      parsed_results
    when "video"
      results = HTTParty.get(@baseline + "/search?q=#{terms}&media_type=video")
      parsed_results = JSON.parse(results.body)
      parsed_results
    end
  end
end
