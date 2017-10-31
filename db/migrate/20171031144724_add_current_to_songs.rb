class AddCurrentToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :current, :boolean, default: false
    add_index :songs, :current
  end
end
