class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index,:show,:followings,:followers,:likes]
  
  def index
    @pagy,@users = pagy(User.order(id: :desc),items:25)
  end

  def show
    @user = User.find(params[:id])
    @pagy,@microposts = pagy(@user.microposts.order(id: :desc))
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success]="ユーザを登録しました"
      redirect_to users_path(@user)
    else
      flash[:danger]="ユーザの登録に失敗しました"
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy,@followings = pagy(@user.followings)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @pagy,@followers = pagy(@user.followers)
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @pagy,@likes = pagy(@user.likes)
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end  
end
