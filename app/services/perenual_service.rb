require 'net/http'
require 'json'

class PerenualService
  BASE_URL='https://perenual.com/api'

  def initialize
    @api_key = ENV['PERENUAL_API_KEY']
  end

  def get_species_list(query)
    return { error: 'Perenual API key not configured' } if @api_key.blank?

    page = 2
    uri = URI("#{BASE_URL}/v2/species-list?key=#{@api_key}&page=#{page}")

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      { error: "Perenual API Error: #{response.code}"}
    end

  rescue StandardError => e
   { error: "Failed to connect to Perenual: #{e.message}" }
  end

end
