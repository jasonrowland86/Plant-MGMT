class SessionsController < ApplicationController
  def index
    if current_user
      redirect_to plants_dashboard_path
    end
  end

  def new
    @user = User.new
  end

  def create
    username = user_params[:username]
    password = user_params[:password]

    user = User.find_by_credentials(username, password)

    if user
      sign_in(user)
      flash[:notice] = 'Signed in'
      redirect_to plants_dashboard_path
    else
      flash[:error] = 'Username or password incorrect'
      @user = User.new(username: username)
      render :new
    end
  end

  def destroy
    sign_out
    flash[:notice] = 'You are signed out'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
