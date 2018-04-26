class UsersController < ApplicationController
  before_action :require_login, only: [ :show, :edit, :update]
  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/songs"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/main"
    end
  end

  def login
    @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to "/songs"
    else
      flash[:errors] = ["Invalid Username or Password. Make sure you have registered first!"]
      redirect_to "/main"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def logout
    session[:user_id] = nil
    redirect_to "/main"
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
