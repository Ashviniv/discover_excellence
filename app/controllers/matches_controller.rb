class MatchesController < ApplicationController
def index
  @matches = Match.all
end
def update
    if @match = get_match

      if @match.update_attributes(allow_params)
        flash[:notice] = "Match updated successfully"
        redirect_to matches_path
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
    if @match
     render :edit
    end 

end
def destroy
    if @match = get_match
      @match.destroy
      redirect_to matches_path
    end
  end
end
