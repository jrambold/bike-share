class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :cart
  helper_method :current_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def cart
    session[:cart] ||= Hash.new(0)
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
