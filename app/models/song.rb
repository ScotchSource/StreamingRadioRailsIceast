class Song < ApplicationRecord
  include SongUploader[:track]

  validates :title, presence: true
  validates :singer, presence: true
  validates :track, presence: true
end
