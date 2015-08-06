class GamesController < ApplicationController
 
  def get_game
    @game = Game.find(params[:id])
  end
  def index
    @games= Game.all
   
  end
  def new
    @game = Game.new
    @game.matches.build
  end

  def create
    if @game = Game.new(allow_params)
      if @game.save
        redirect_to games_path(@game)
      else
        render :new
      end
    end
  end
  def allow_params
    params.require(:game).permit!()
  end

  def edit
    @game = get_game
    if @game
     # @game.matches.build
      #@game.matches.build
       
       
    end 

  end

  def update
    if @game = get_game

      if @game.update_attributes(allow_params)
        flash[:notice] = "Game updated successfully"
        redirect_to games_path
      else
        render :edit
      end
    end

  end

  def destroy
    if @game = get_game
      @game.destroy
      redirect_to games_path
    end
  end

end
