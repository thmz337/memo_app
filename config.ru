# frozen_string_literal: true

require 'sinatra'
require 'rack/unreloader'

require_relative './app'

configure :development do
  unreloader = Rack::Unreloader.new(subclasses: ['Sinatra::Application']) { MemoApp }
  unreloader.require './app.rb'
  run unreloader
end

configure :production do
  run MemoApp
end
