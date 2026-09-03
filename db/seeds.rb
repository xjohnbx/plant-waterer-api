# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

if Rails.env.development? || Rails.env.test?
  puts "--- Clearing existing local plant records ---"
  Plant.destroy_all
end

csv_file_path = Rails.root.join('plants2.csv')
unless File.exist?(csv_file_path)
  puts "plants2.csv not found at #{csv_file_path}. Skipping plant seeding."
  return
end
puts "--- Reading #{csv_file_path} ---"

CSV.foreach(csv_file_path, headers: true) do |row|
  plant_name = row['Name']&.strip
  next if row['Name'].blank?

  Plant.create!(
    name: plant_name,
    location: row['Location']&.strip,
    pot_diameter_mm: row['Pot Diameter (mm) (Inner Pot)'].presence&.to_f,
    pot_height_mm: row['Pot Height (mm) (Inner Pot)'].presence&.to_f,
    ro_water: row['RO Water?']&.strip&.downcase == 'yes',
    light_requirements: row['Light Requirements']&.strip,
    dry_before_watering: row['How dry before watering?']&.strip,
    humidity: row['Humidity']&.strip
  )
  
  puts "Found Plant: #{plant_name}" if plant_name.present?
end

puts "---------------------------"
