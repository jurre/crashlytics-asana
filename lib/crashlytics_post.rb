#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'asana'

class CrashlyticsPost
  attr_accessor :event, :payload_type, :display_id, :title, :method, :impact_level, :crashes_count, :impacted_devices_count, :url

  def initialize(event, payload_type, display_id, title, method, impact_level, crashes_count, impacted_devices_count, url)
    @event = event
    @payload_type = payload_type
    @display_id = display_id
    @title = title
    @method = method
    @impact_level = impact_level
    @crashes_count = crashes_count
    @impacted_devices_count = impacted_devices_count
    @url = url
  end

  # the json received from crashlytics looks like this:
  # {
  #    "event": "issue_impact_change",
  #    "payload_type": "issue",
  #    "payload": {
  #      "display_id": 123 ,
  #      "title": "Issue Title" ,
  #      "method": "methodName of issue"
  #      "impact_level": 2,
  #      "crashes_count": 54,
  #      "impacted_devices_count": 16,
  #      "url": "http://crashlytics.com/full/url/to/issue"
  #    }
  # }
  def self.from_json(string)
    data = JSON.parse(string)
    payload = data['payload']
    self.new(data['event'],
             data['payload_type'],
             payload['display_id'],
             payload['title'],
             payload['method'],
             payload['impact_level'],
             payload['crashes_count'],
             payload['impacted_devices_count'],
             payload['url'])
  end
  
  def notes
    "#{url} \n\nCrashes in: #{method} \nNumber of crashes: #{crashes_count} \nImpacted devices: #{impacted_devices_count}"
  end
  
  def create_asana_task!
    Asana.configure do |client|
      client.api_key = ENV['ASANA_CLIENT_KEY']
    end
    workspace = Asana::Workspace.find(ENV['ASANA_WORKSPACE_ID'])
    project_id = ENV['ASANA_PROJECT_ID']
    workspace.create_task(:name => @title, :notes => self.notes, :projects => [project_id])
  end
end
