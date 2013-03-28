require 'rubygems'
require 'sinatra'
require_relative 'lib/crashlytics_post'

set :protection, :except => [:http_origin]

use Rack::Auth::Basic do |username, password|
  [username, password] == [ENV['USERNAME'], ENV['PASSWORD']]
end

post '/' do
  json_string = request.body.read.to_s
  
  # respond with a 200 to the Crashlytics verification request
  return 'ok' if JSON.parse(json_string)['event']  == 'verification'
  
  # post to asana
  post = CrashlyticsPost.from_json(json_string)
  post.create_asana_task!
end
