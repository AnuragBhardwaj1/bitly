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

ActiveRecord::Schema.define(version: 20180619072849) do

  create_table 'links', force: :cascade do |t|
    t.text     'short_link'
    t.text     'long_link'
    t.datetime 'expiration_date'
    t.integer  'user_id'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
  end

  add_index 'links', ['created_at'], name: 'index_links_on_created_at'
  add_index 'links', ['long_link'], name: 'index_links_on_long_link'
  add_index 'links', ['short_link'], name: 'index_links_on_short_link'
  add_index 'links', ['updated_at'], name: 'index_links_on_updated_at'
  add_index 'links', ['user_id'], name: 'index_links_on_user_id'

end