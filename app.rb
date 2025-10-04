require 'sinatra'
java_import 'java.time.LocalDateTime'
java_import 'java.time.format.DateTimeFormatter'

get '/' do
  "Hello World from Sinatra running on JRuby with Jetty!"
end

get '/time' do
  now = LocalDateTime.now
  format = DateTimeFormatter.of_pattern("yyyy-MM-dd HH:mm:ss")
  "Current time: #{now.format(format)}"
end
