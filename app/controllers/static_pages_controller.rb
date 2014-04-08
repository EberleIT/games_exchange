class StaticPagesController < ApplicationController
  def home
  if signed_in?
   @game = current_user.games.build
   @feed_items = current_user.feed.paginate(page: params[:page])
   
   
  end
	@games = Game.all
  end

  def help
  end
   def about
  end
  
  def contact
  end
  
end
