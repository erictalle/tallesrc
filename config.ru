require './app/erics_place'
run Sinatra::Application
map "/vendor" do
	run Rack::Directory.new("./public/vendor")
end
