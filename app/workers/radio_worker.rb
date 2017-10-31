require 'shout'
require 'open-uri'
class RadioWorker
  include Sidekiq::Worker
  def perform(*_args)
    prev_song = nil
    s = Shout.new
    s.mount = "/stream"
    s.charset = "UTF-8"
    s.port = 35689
    s.host = 'localhost'
    s.user = ENV['ICECAST_USER']
    s.pass = ENV['ICECAST_PASSWORD']
    s.format = Shout::MP3
    s.description = 'Geek Radio'
    s.connect

    loop do
      Song.where(current: true).each do |song|
        song.toggle! :current
      end
      Song.order('created_at DESC').each do |song|
        prev_song.toggle!(:current) if prev_song
        song.toggle! :current

        open(song.track.url(public: true)) do |file|
          m = ShoutMetadata.new
          m.add 'filename', song.track.original_filename
          m.add 'title', song.title
          m.add 'artist', song.singer
          m.add 'bitrate', song.track.metadata['bitrate'].to_s
          s.metadata = m

          while data = file.read(16384)
            s.send data
            s.sync
          end
        end
        prev_song = song
      end
    end

    s.disconnect
  end
end
