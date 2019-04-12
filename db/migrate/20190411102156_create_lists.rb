class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id, foreign_key: true
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
