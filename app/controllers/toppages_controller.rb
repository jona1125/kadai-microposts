class ToppagesController < ApplicationController
  def index
    if logged_in?
      @micropost = current_user.microposts.build
      @pagy,@microposts = pagy(current_user.feed_microposts.order(id: :desc))
    end
  end
end
