class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers = ActiveSupport::JSON.encode({
        Authorization: session[:token]
      })
    end

    @username = ActiveSupport::JSON.decode(resp.body)["login"]
  end

  def create
    
  end
end
