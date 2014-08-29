require 'spec_helper'

describe Backman::API do
  describe 'GET /ping' do
    before do
      get '/ping'
    end
    it 'exists' do
      expect(last_response).to be_ok
    end

    it 'pongs' do
      expect(last_response.body).to eq 'pong'
    end
  end

  describe 'POST /article/create' do
    before do
      post '/article/create', title: 'Some title', content: 'Some content'
    end

    it 'redirects' do
      expect(last_response).to be_redirect
    end

    it 'redirects to GitHub' do
      expect(last_response.header['Location'])
        .to eq 'https://github.com/login/oauth/authorize?client_id=abcd&state=abcd&redirect_uri=http://backman.io/authorized&scope=public_repo'
    end
  end

  describe 'GET /authorized' do
    before do
      get '/authorized', code: 'abcd'
    end
  end
end
