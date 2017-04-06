#!/bin/bash
#
# This script creates the persistent menu structure for Find A Business Bot
#
# There are environment variables that need to be set before running. 
# At the bottom of the script you will need to change the access token to the one 
# for the page you are trying to add the menu structure to.
#

curl -X POST -H "Content-Type: application/json" -d '{
  "persistent_menu": [
    {
      "locale": "default",
      "composer_input_disabled": true,
      "call_to_actions": [
        {
          "type": "postback",
          "title": "Send BBB A Message",
          "payload": "CHAT_AGENT"
        },
        {
          "type": "postback",
          "title": "Find Business",
          "payload": "FIND_BUSINESS"
        },
        {
          "type": "nested",
          "title": "More Options",
          "call_to_actions": [
            {
              "type": "web_url",
              "title": "File a complaint",
              "url": "https://www.bbb.org/consumer-complaints/file-a-complaint/get-started"
            },
            {
              "type": "web_url",
              "title": "Report a Scam",
              "url": "https://www.bbb.org/scamtracker/us"
            }
          ]
        }
      ]
    },
    {
      "locale": "zh_CN",
      "composer_input_disabled": false
    }
  ]
  }' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=PAGE_ACCESS_TOKEN_HERE"
