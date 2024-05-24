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
    set :memo, Memo.new('memo_app')
  end

  get '/' do
    @memos = settings.memo.read
    erb :index, layout: :top_layout
  end

  get '/memos' do
    erb :memos
  end

  post '/memos' do
    params in { title:, content: }
    settings.memo.create(title, content)
    redirect '/'
  end

  get '/memos/:id' do
    @memo = settings.memo.find_by_id(params[:id])[0]
    pass if @memo.nil?
    erb :memo
  end

  get '/memos/:id/edit' do
    @memo = settings.memo.find_by_id(params[:id])[0]
    erb :edit_memo
  end

  patch '/memos/:id' do
    params in { id:, title:, content: }
    settings.memo.update(id, title, content)
    redirect "/memos/#{id}"
  end

  delete '/memos/:id' do
    settings.memo.delete(params[:id])
    redirect '/'
  end

  not_found do
    erb :not_found
  end
end
