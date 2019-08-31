class Playlist < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.string :create
      
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
