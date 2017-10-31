class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :singer
      t.text :track_data

      t.timestamps
    end
  end
end
