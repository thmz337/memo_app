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
  configure do
    set :db, DB.new('memos.json')
  end

  get '/' do
    @memos = settings.db.read[:memos]
    erb :index, layout: :top_layout
  end

  get '/memos' do
    erb :memos
  end

  post '/memos' do
    @id = settings.db.read[:nextID].to_i
    @title = params[:title]
    @content = params[:content]
    memo = { id: @id, title: @title, content: @content }
    settings.db.create(memo)
    redirect '/'
  end

  get '/memos/:id' do
    @memo = settings.db.read[:memos].find { |m| m[:id] == params[:id].to_i }
    pass if @memo.nil?
    erb :memo
  end

  delete '/memos/:id' do
    settings.db.delete(params[:id].to_i)
    redirect '/'
  end

  get '/memos/:id/edit' do
    @memo = settings.db.read[:memos].find { |m| m[:id] == params[:id].to_i }
    erb :edit_memo
  end

  patch '/memos/:id' do
    @id = params[:id].to_i
    @title = params[:title]
    @content = params[:content]
    memo = { id: @id, title: @title, content: @content }
    settings.db.update(memo)
    redirect "/memos/#{params[:id]}"
  end

  not_found do
    erb :not_found
  end
end
