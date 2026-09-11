# app/serializers/trefle_plant_serializer.rb
class TreflePlantSerializer
  # Represents the serialized plant shape sent to React Native.
  #
  # @typedef [Hash] SerializedPlant
  # @property [Integer] id
  # @property [String] commonName
  # @property [String] scientificName
  # @property [String, nil] imageUrl
  # @property [String, nil] family
  # @property [String, nil] genus
  # @property [Array<String>] synonyms

  # Transforms an array of raw Trefle response hashes into trimmed, camelCased JSON objects.
  #
  # @param raw_trefle_array [Array<Hash>, nil]
  # @return [Array<Hash>] List of SerializedPlant hashes
  def self.render_collection(raw_trefle_array)
    return [] if raw_trefle_array.blank?

    raw_trefle_array.map { |plant| render_one(plant) }
  end

  # Transforms a single Trefle hash into a trimmed, camelCased JSON object.
  #
  # @param plant [Hash]
  # @return [Hash] SerializedPlant
  def self.render_one(plant)
    {
      id: plant['id'],
      commonName: plant['common_name'] || 'Unknown Plant',
      scientificName: plant['scientific_name'],
      imageUrl: plant['image_url'],
      family: plant['family'],
      genus: plant['genus'],
      synonyms: plant['synonyms'] || []
    }
  end
end