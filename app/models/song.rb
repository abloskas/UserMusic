class Song < ActiveRecord::Base
  belongs_to :user
  has_many :playlists
  has_many :song_list, through: :playlists, source: :user
  validates :title, :artist, presence: true
  validates :title, length: {minimum: 2}
  validates :artist, length: {minimum: 2}
end