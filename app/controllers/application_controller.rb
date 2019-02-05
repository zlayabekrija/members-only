class ApplicationController < ActionController::Base
  helper_method :logged_in
    
  def login
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      current_user(user)
      current_user
      if cookies.permanent[:remember_token]
        @current_user.update_attribute(:remember_token, user.generate_token)
        cookies.permanent[:remember_token] = @current_user.remember_token
      end
    end
  end
  
  def current_user
      @current_user ||= User.find_by(remember_token: cookies.permanent[:remember_token])
  end
  
  def current_user=(user)
      @current_user = user
  end
  
  def logged_in
    !@current_user.nil?
  end
  
  def logout
    cookies.permanent[:remember_token] = nil
    @current_user = nil
  end

end
