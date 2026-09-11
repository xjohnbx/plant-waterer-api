require 'net/http'
require 'json'

class TrefleService
  BASE_URL='https://trefle.io/api/v1/plants'

  def initialize
    @api_key = ENV['TREFLE_API_KEY']
  end

  def search_plant(query)
    return { error: 'API key not configured' } if @api_key.blank?

    uri = URI("#{BASE_URL}/search?token=#{@api_key}&q=#{URI.encode_www_form_component(query)}")

    response = Net::HTTP.get_response(uri)
    
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      { error: "Trefle API Error: #{response.code}"}
    end

  rescue StandardError => e
    { error: "Failed to connect to Trefle: #{e.message}"}
  end
end