require 'rubygems'
require 'sinatra'
require_relative 'lib/crashlytics_post'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['test', 'test']
end

post '/' do
  json_string = request.body.read.to_s
  
  puts JSON.parse(json_string)['event']
  # respond with a 200 to the Crashlytics verification request
  return 'ok' if JSON.parse(json_string)['event']  == 'verification'
  
  post = CrashlyticsPost.from_json(json_string)
  post.create_asana_task!
end
