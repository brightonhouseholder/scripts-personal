#!/bin/bash
#
# This Script adds a Get Started button to the Find a Business Bot
#
# There are environment variables that will need to be set
# Change the access token on the last line to be the access token for the 
# page you are trying to add the Get started button to
#
#
curl -X POST -H "Content-Type: application/json" -d '{
  "setting_type":"call_to_actions",
  "thread_state":"new_thread",
  "call_to_actions":[
    {
      "payload":"GET_START"
    }
  ]
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=PAGE_ACCESS_TOKEN_HERE"
