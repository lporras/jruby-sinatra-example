require 'sinatra'

get '/' do
  "Hello World from Sinatra running on JRuby with Jetty!"
end

get '/time' do
  "Current time: #{Time.now}"
end
