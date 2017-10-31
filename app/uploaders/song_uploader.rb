class SongUploader < Shrine
  add_metadata do |io, context|
    song = FFMPEG::Movie.new(io.path)

    {
        bitrate: song.bitrate ? song.bitrate / 1000 : 0
    }
  end
end