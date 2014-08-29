require 'sinatra'

module Backman
  # Main web api application
  class API < Sinatra::Application
    enable :sessions

    get '/ping' do
      'pong'
    end

    post '/article/create' do
      if !session[:token]
        redirect "https://github.com/login/oauth/authorize?client_id=%s&state=%s&redirect_uri=%s&scope=%s" %
                  [ENV['client_id'], ENV['state'], ENV['redirect_uri'], 'public_repo']
      end

      return 200
    end
  end
end
