class MatchesController < ApplicationController
  def index
    @matches = Match.where(tournament_id: params[:tournament_id], game_id: params[:game_id]).paginate(:page => params[:page], :per_page => 5) if params[:tournament_id] 
    @matches = Match.where(game_id: params[:game_id]).paginate(:page => params[:page], :per_page => 5) unless params[:tournament_id]
    
  end
 def index_params
    params.require(:match).permit!()
  end
  
 def redirect_path
     redirect_to game_matches_path(params[:game_id]) unless params[:tournament_id]
     redirect_to game_tournament_matches_path(params[:game_id], params[:tournament_id]) if params[:tournament_id]
 end

  def new
    @game = Game.find(params[:game_id])
    @match = @game.matches.build
    @count = 0
  end
 def show 
  @match = get_match 
end
  def create
    allow_params[:game_id] = params[:game_id]
    allow_params[:tournament_id] = params[:tournament_id]
    if @match = Match.new(allow_params)
      @match.players.build
      if @match.save
        redirect_to game_matches_path(params[:game_id]) unless params[:tournament_id]
        redirect_to game_tournament_matches_path(params[:game_id], params[:tournament_id], params[:match_id]) if params[:tournament_id]
      else
        render :new
      end
    end
  end

  def update
     allow_params[:game_id] = params[:game_id]
    if @match = get_match

      if @match.update_attributes(allow_params)
        flash[:notice] = "Match updated successfully"
        redirect_to game_matches_path(params[:game_id]) unless params[:tournament_id]
        redirect_to game_tournament_matches_path(params[:game_id], params[:tournament_id]) if params[:tournament_id]
      else
        render :edit
      end
    end


  end
  def allow_params
    params.require(:match).permit!()
  end
  def get_match
    @match = Match.find(params[:id])
  end
  def edit
    @match = get_match
    # @match.players.build
    #@match.players.build
    

  end
  def destroy
    if @match = get_match
      @match.destroy
      redirect_to game_matches_path(params[:game_id]) unless params[:tournament_id]
      redirect_to game_tournament_matches_path(params[:game_id], params[:tournament_id]) if params[:tournament_id]

    end
  end
end
