require 'rubygems'
require 'sinatra'
require 'active_record'

configure :production, :development do
  enable :sessions

  db = URI.parse("mysql2://#{ENV['DB_USERNAME']}:#{ENV['DB_PASSWORD']}@#{ENV['DB_HOSTNAME']}/talle_db" || 'mysql2://root:password@localhost/talle_db')
  pool = ENV['DB_POOL'] || ENV['MAX_THREADS'] || 5
  ActiveRecord::Base.establish_connection(
        adapter:   db.scheme,
        host:      db.host,
        username:  db.user,
        password:  db.password,
        database:  db.path[1..-1],
        encoding:  'utf8',
        pool:      pool
  )
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end

get '/' do
  erb 'Can you handle a <a href="/secure/place">secret</a>?'
end

get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/secure/place' do
  erb 'This is a secret place that only <%=session[:identity]%> has access to!'
end


class User < ActiveRecord::Base
#
end




