class SessionsController < ApplicationController
  before_action :ensure_signed_out, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    username = user_params[:username]
    password = user_params[:password]
    user = User.find_from_credentials(username, password)
    if user
      sign_in(user)
      # flash[:notice] = "Welcome, #{username}"
      redirect_to user_statistics_path(user)
    else
      flash[:error] = "User does not exist"
      @user = User.new(username: username)
      render :new
    end
  end

  def destroy
    sign_out
    # flash[:notice] = 'Signed out'
    redirect_to new_session_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end #END OF CLASS
