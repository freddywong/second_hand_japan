# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_16_022205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.integer "listing_id"
    t.string "type"
    t.string "url"
    t.string "title"
    t.text "description"
    t.string "date_posted"
    t.string "image_url"
    t.string "tags"
    t.index ["listing_id"], name: "index_listings_on_listing_id"
    t.index ["type"], name: "index_listings_on_type"
    t.index ["url"], name: "index_listings_on_url"
  end

end
