require 'rubygems'
require 'sinatra'
require_relative 'lib/crashlytics_post'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == [ENV['USERNAME'], ENV['PASSWORD']]
end

post '/' do
  post = CrashlyticsPost.from_json(request.body.read.to_s)
  # respond with a 200 to the Crashlytics verification request
  return if JSON.parse(request.body.read.to_s)[:event]  == 'verification'

  post.create_asana_task!
end
