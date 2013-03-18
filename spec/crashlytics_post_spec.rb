require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/crashlytics_post'

$json_string = '{
   "event":"issue_impact_change",
   "payload_type":"issue",
   "payload":{
      "display_id":123,
      "title":"Issue Title",
      "method":"methodName of issue",
      "impact_level":2,
      "crashes_count":54,
      "impacted_devices_count":16,
      "url":"http://crashlytics.com/full/url/to/issue"
   }
}'

describe CrashlyticsPost do
  it 'can create a new CrashlyticsPost object from a json string' do

    crashlytics_post = CrashlyticsPost.from_json($json_string)
    crashlytics_post.event.must_equal "issue_impact_change"
    crashlytics_post.payload_type.must_equal "issue"
    crashlytics_post.display_id.must_equal 123
    crashlytics_post.title.must_equal "Issue Title"
    crashlytics_post.method.must_equal "methodName of issue"
    crashlytics_post.impact_level.must_equal 2
    crashlytics_post.crashes_count.must_equal 54
    crashlytics_post.impacted_devices_count.must_equal 16
    crashlytics_post.url.must_equal "http://crashlytics.com/full/url/to/issue"
  end

  it "can create well formatted notes for asana" do
    crashlytics_post = CrashlyticsPost.from_json($json_string)
    crashlytics_post.notes.must_equal "http://crashlytics.com/full/url/to/issue \n\nCrashes in: methodName of issue \nNumber of crashes: 54 \nImpacted devices: 16"
  end
  
  it "can create an asana task" do
    # TODO: figure out how to properly create an automated test for this
  end
end
