# This migration creates table: :links
class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :short_link, index: { unique: true }
      t.text :long_link, index: true
      t.datetime :expiration_date

      t.timestamps null: false
    end
  end
end
