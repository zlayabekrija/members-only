class ApplicationController < ActionController::Base
  helper_method :logged_in
  before_action :current_u
  def signed_up(user,password)
    @user = user
    @password = password
    login
  end

  def login
    if !@user.nil?
      user = User.find(@user[:id])
    else
      user = User.find_by_email(params[:session][:email])
    end
      if user && (user.authenticate(@password) || user.authenticate(params[:session][:password]))
        if cookies[:remember_token].nil? 
          user.update_attribute(:remember_token, user.generate_token)
          cookies.permanent[:remember_token] = user[:remember_token]
          current(user)
          redirect_to root_path
        end
      else
        flash.now[:danger] = 'Invalid email or password'
        render 'new'
      end
  end

  def current(user)
    @current_user = user
  end
  
  def current_u
      @current_user ||= User.find_by(remember_token: cookies.permanent[:remember_token])
  end

  
  def logged_in
   !current_u.nil?
  end

  def logout
   cookies.delete :remember_token
    @current_user = nil
   
  end
  def hello
   @current_user.name
  end
  
 
end
