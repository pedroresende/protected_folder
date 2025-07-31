class ProtectedFolderController < ApplicationController
    USERNAME = "admin"
  PASSWORD = "password"

  before_action :authenticate
  protect_from_forgery except: :show

  def show
    requested_file = params[:path]

    # If no file extension is present, assume it's index.html file
    requested_file += "/index.html" unless requested_file.include?(".")

    file_path = Rails.root.join("storage", "protected_folder", requested_file)

    if File.exist?(file_path) && !File.directory?(file_path)
      send_file file_path, disposition: "inline"
    else
      render plain: "File not found", status: :not_found
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
  # def authenticate
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == USERNAME && password == PASSWORD
  #   end
  # end
end
