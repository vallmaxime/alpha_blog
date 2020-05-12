class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :updates, :show]
  before_action :require_save_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "New user #{@user.username} created!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User mis à jour avec success !"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(:page => params[:page], :per_page => 5)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_save_user
    if current_user != @user
      flash[:danger] = "Hop hop hop !! non non non mon con =)"
      redirect_to root_path
    end
  end

end
