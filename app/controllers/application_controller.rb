class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def sign_in(user)
    token = SecureRandom.urlsafe_base64
    session[:token] = token
    user.update_attribute(:session_token, token)
  end

  def sign_out
    current_user.update_attribute(:session_token, nil)
    session.delete(:token)
  end

  def current_user
    token = session[:token]
    return nil if token.nil?
    User.find_by(session_token: token)
  end

  def ensure_logged_in
    return if current_user
    flash[:error] = 'You must be logged in'
    redirect_to new_session_path
  end
end
