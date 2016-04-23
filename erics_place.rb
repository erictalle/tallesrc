require 'rubygems'
require 'sinatra/base'
require 'json'
require 'yaml'
require 'date'
require 'net/http'
require 'uri'
require 'haml'


class EricsPlace < Sinatra::Base
  get "/" do
    haml :index
  end
end