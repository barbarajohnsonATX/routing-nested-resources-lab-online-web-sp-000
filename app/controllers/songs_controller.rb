class SongsController < ApplicationController
  def index
    #get songs by artist if params[artist_id] is given
    if params[:artist_id]
      #check if artist is found
      if Artist.find(params[:artist_id])
        @songs = Artist.find(params[:artist_id]).songs 
      else 
        flash[:alert] 
        
    #get all songs 
    else
      @songs = Songs.all
    end
    
    
    
  end

  def show
    @song = Song.find(params[:id])
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

