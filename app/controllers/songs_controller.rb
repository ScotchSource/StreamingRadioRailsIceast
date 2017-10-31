class SongsController < ApplicationController
  layout 'admin'

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new song_params
    if @song.save
      redirect_to songs_path
    else
      render :new
    end
  end

  private

  def song_params
    params.require(:song).permit(:title, :singer, :track)
  end
end