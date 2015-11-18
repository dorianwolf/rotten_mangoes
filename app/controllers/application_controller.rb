class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def switch_to(user_id)
    if @current_user.admin
      session[:prev_id] = current_user.id
      session[:user_id] = user_id.to_i
    end
  end

  def switch_back_to_admin
      session[:user_id] = session[:prev_id]
      session[:prev_id] = nil
  end

  helper_method :current_user
  helper_method :switch_to_user
  helper_method :switch_back_to_admin

end
