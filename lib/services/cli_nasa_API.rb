class Nasa::CliNasaAPI
  @baseline = "https://images-api.nasa.gov"

  # Returns results of all types based on the terms provided
  def self.basic_search(terms)
    results = HTTParty.get(@baseline + "/search?q=#{terms}")
  end

  # Returns results of the specified media type (first value passed) based on the
  # provided search terms (second value passed), parsed as a hash
  def self.media_search(type, terms)
    case type
    when "image"
      results = HTTParty.get(@baseline + "/search?q=#{terms}&media_type=image", format: :plain)
      parsed_results = JSON.parse(results.body)
      puts parsed_results.class
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
