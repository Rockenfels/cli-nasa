class CliNasaAPI
  @baseline = "https://images-api.nasa.gov"

  def self.basic_search(terms)
    results = HTTParty.get(@baseline + "/search?q=#{terms}")
    results
  end

  def self.media_search(type, terms)
    case type
    when "image"
      results = HTTParty.get(@baseline + "/search?q=#{terms}&media_type=image")
      results
    when "audio"
      results = HTTParty.get(@baseline + "/search?q=#{terms}&media_type=audio")
      results
    when "video"
      results = HTTParty.get(@baseline + "/search?q=#{terms}&media_type=video")
      results
    end
  end
end
