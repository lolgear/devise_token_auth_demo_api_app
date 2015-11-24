class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  respond_to :json

  rescue_from Exceptions::AccessDenied do |exception|
    render status: :forbidden, json: { errors: ['Access denied'] }
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render status: :not_found, json: { errors: ['Record not found'] }
  end
  
  def page_not_found
  	render json: {errors: [error: "page not found", code: 400]}, status: :not_found
  end

  # http://stackoverflow.com/questions/23773730/rails-4-skipping-protect-from-forgery-for-api-actions
  skip_before_action :verify_authenticity_token, if: :json_request?

  protected

  def json_request?
    request.format.json?
  end
end
