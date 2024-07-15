require 'sinatra'
#require 'sinatra-reloader'
require 'csv'

require_relative 'gossip'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
  end

  get '/' do
    @gossips = Gossip.all 
    erb :index
  end

  post '/gossips/new/' do
    gossip = Gossip.new(params["author"], params["content"])
    gossip.save
    redirect '/'
  end

  get '/gossips/:id' do
    @gossip = Gossip.find(params[:id].to_i)
    erb :show
  end

  get '/gossips/:id/edit' do
    @gossip = Gossip.find(params[:id].to_i)
    erb :edit
  end

  post '/gossips/:id/update' do
    gossip = Gossip.find(params[:id].to_i)
    gossip.update(params["author"], params["content"])
    redirect "/gossips/#{params[:id]}"
  end

  get '/gossips/:id/delete' do
    gossip = Gossip.find(params[:id].to_i)
    gossip.delete
    redirect "/"
  end

  run! if app_file == $0

end