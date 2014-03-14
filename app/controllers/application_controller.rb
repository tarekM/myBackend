class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_auth
  def check_auth
	authenticate_or_request_with_http_basic do |username,password|
		resource = User.find_by_email(username)
		if resource.valid_password?(password)
			sign_in :user, resource
		else
			render json: [{error: "Unmatched Username or Password!"}]
		end
	end
  end
end
