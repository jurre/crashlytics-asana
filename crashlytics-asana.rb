require 'rubygems'
require 'sinatra'
require_relative 'lib/crashlytics_post'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == [ENV['username'], ENV['password']]
end

post '/' do
  post = CrashlyticsPost.from_json(request.body.read.to_s)
  # respond with a 200 to the Crashlytics verification request
  return if post.event == 'verification'

  post.create_asana_task!
end
