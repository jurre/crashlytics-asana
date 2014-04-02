crashlytics-asana
=================

Small Sinatra app that listens to Crashlytics webhooks and posts a task to Asana to a specified Workspace and Project.

This is now deprecated in favor of the native integration in Crashlytics (which I contributed).

Set it up on heroku!
---------------------

To set it up on Heroku just create a new Heroku app and add these environment variables:

`heroku config:add ASANA_CLIENT_KEY=your_client_key`

`heroku config:add ASANA_WORKSPACE_ID=your_workspace_id`

`heroku config:add ASANA_PROJECT_ID=your_project_id`

Push this repo to your new Heroku app and add the URL that you set up on Heroku to your Crashlytics web hook.
