class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = JSON.encode({
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        code: params['code'],
        redirect_uri: CGI.escape(root_path)
      })
    end
  end
end
