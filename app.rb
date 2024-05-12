# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'rack'

require_relative 'db'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

class MemoApp < Sinatra::Application
  include DB

  configure do
    set :db, './memos.json'
  end

  get '/' do
    @memos = DB.read(settings.db)[:memos]
    erb :index, layout: :top_layout
  end

  get '/memos' do
    erb :memos
  end

  post '/memos' do
    @id = DB.read(settings.db)[:nextID].to_i
    @title = params[:title]
    @content = params[:content]
    memo = { id: @id, title: @title, content: @content }
    DB.create(settings.db, memo)
    redirect '/'
  end

  get '/memos/:id' do
    @memo = DB.read(settings.db)[:memos].find { |m| m[:id] == params[:id].to_i }
    pass if @memo.nil?
    erb :memo
  end

  delete '/memos/:id' do
    DB.delete(settings.db, params[:id].to_i)
    redirect '/'
  end

  get '/memos/:id/content' do
    @memo = DB.read(settings.db)[:memos].find { |m| m[:id] == params[:id].to_i }
    erb :patch_memo
  end

  patch '/memos/:id/content' do
    @id = params[:id].to_i
    @title = params[:title]
    @content = params[:content]
    memo = { id: @id, title: @title, content: @content }
    DB.update(settings.db, memo)
    redirect '/'
  end

  not_found do
    erb :not_found
  end
end
