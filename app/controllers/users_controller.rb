class UsersController < ApplicationController
  before_action :ensure_signed_out, only: [:new, :create]
  before_action :ensure_signed_in, only: [:show] #:index
  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      sign_in(@user)
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  # def index
  #   @users = User.all  DO WE WANT EVERYONE MOOD TO BE PUBLIC??
  # end

  def show
    @user = User.find(params[:id])
  end

  private

  def create_params
    params.require(:user).permit(:username, :password)
  end
end
