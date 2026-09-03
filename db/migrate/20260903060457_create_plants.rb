class CreatePlants < ActiveRecord::Migration[8.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :location
      t.float :pot_diameter_mm
      t.float :pot_height_mm
      t.boolean :ro_water
      t.string :light_requirements
      t.string :dry_before_watering
      t.string :humidity

      t.timestamps
    end
  end
end
