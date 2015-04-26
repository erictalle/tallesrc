class MyTalleApp < Sinatra::Base
  configure :development do
  	register Sinatra::Reloader
  end

	get '/' do
  	haml :index
	end
end

