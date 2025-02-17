class SongsController < ApplicationController
  def index
    #get songs by artist if params[artist_id] is given
    if params[:artist_id]
      #check if artist is found
      @artist = Artist.find_by(id: params[:artist_id])
      #binding.pry
      if @artist 
        @songs = @artist.songs 
      else 
        flash[:alert] = "Artist not found."
        redirect_to artists_path
      end 
        
    #get all songs 
    else
      @songs = Song.all
    end
    
    
    
  end

  def show
    if Song.find_by(id: params[:id])
      @song = Song.find(params[:id])
    else
      flash[:alert] = "Song not found"
      redirect_to artist_songs_path(params[:artist_id])
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

