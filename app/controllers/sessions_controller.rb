class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = ActiveSupport::JSON.encode({
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        code: params['code'],
        redirect_uri: CGI.escape(oauth_redirect_url)
      })
    end
    access_token = ActiveSupport::JSON.decode(resp)["access_token"]
    session[:token] = access_token
    redirect root_path
  end

end
