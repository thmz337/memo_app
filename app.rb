# frozen_string_literal: true

require 'sinatra'
require 'rack'

require_relative 'memos'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

class MemoApp < Sinatra::Application
  configure do
    set :memos, Memos.new('memo_app')
  end

  get '/' do
    @memos = settings.memos.all
    erb :index, layout: :top_layout
  end

  get '/memos' do
    erb :memos
  end

  post '/memos' do
    params in { title:, content: }
    settings.memos.create(title, content)
    redirect '/'
  end

  get '/memos/:id' do
    @memo = settings.memos.find_by_id(params[:id])
    pass if @memo.nil?
    erb :memo
  end

  get '/memos/:id/edit' do
    @memo = settings.memos.find_by_id(params[:id])
    erb :edit_memo
  end

  patch '/memos/:id' do
    params in { id:, title:, content: }
    settings.memos.update(id, title, content)
    redirect "/memos/#{id}"
  end

  delete '/memos/:id' do
    settings.memos.delete(params[:id])
    redirect '/'
  end

  not_found do
    erb :not_found
  end
end
