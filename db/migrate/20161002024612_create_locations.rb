class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.text :name
      t.text :introduction
      t.float :rating, default: 0
      t.references :category, index: true, foreign_key: true
      t.string :picture
      t.string :address
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end
