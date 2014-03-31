class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_user! 
    # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  before_filter :authenticate_user!
 
  private

  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email,:password,:password_confirmation, :confirmed_at) }
  end
  
  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)
 
    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end
 #  before_action :check_auth
 #  def check_auth
	# authenticate_or_request_with_http_basic do |username,password|
	# 	resource = User.find_by_email(username)
 #    if resource != nil
 #  		if resource.valid_password?(password)
 #  			sign_in :user, resource
 #  		end
 #    end
	# end
 #  end
end
