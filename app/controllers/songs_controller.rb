class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def create
    @user = User.find(session[:user_id])
    @song = Song.new(artist:params[:artist], title:params[:title])
    if @song.save
      redirect_to "/songs"
    else
      flash[:errors] = @song.errors.full_messages 
      redirect_to "/songs"
    end
  end

  def show
    @song = Song.find(params[:id])
    
  end

  def add
    @song = Song.find(params[:id])
    @playlist = Playlist.create(user_id: current_user.id, song_id: @song.id)
    p "***********************************************"
    p @playlist
    redirect_to "/songs"
  end
end
