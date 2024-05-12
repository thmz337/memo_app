# frozen_string_literal: true

require 'sinatra'

require_relative './app'

configure :development do
  require 'rack/unreloader'
  unreloader = Rack::Unreloader.new(subclasses: ['Sinatra::Application']) { MemoApp }
  unreloader.require './app.rb'
  run unreloader
end

configure :production do
  run MemoApp
end
