class PlayersController < ApplicationController
  def index
    @players = Player.all

  end
  
  def new
    @player = Player.new
  end
  
  def create
    @player = Player.new(allow_params)

    if @player.save
      redirect_to players_path
    else
      render :new
    end
  end
  
  def update
    if @player = get_player

      if @player.update_attributes(allow_params)
        flash[:notice] = "player updated successfully"
        redirect_to players_path
      else
        render :edit
      end
    end

  end

  def allow_params
    params.require(:player).permit!()
  end

  def get_player
    @player = Player.find(params[:id])
  end

  def edit
    @player = get_player
    if @player
      render :edit
    end 
  end

  def destroy
    if @player = get_player
      @player.destroy
      redirect_to players_path
    end
  end

end
