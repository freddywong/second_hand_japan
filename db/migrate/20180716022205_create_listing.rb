class CreateListing < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.integer :listing_id
      t.string :type
      t.string :url
      t.string :title
      t.text :description
      t.string :date_posted
      t.string :image_url
      t.string :tags
    end
    add_index :listings, :listing_id
    add_index :listings, :type
    add_index :listings, :url
  end
end
