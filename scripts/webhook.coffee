# https://github.com/github/hubot/blob/master/docs/scripting.md
# Description:
#   "Accepts POST data and broadcasts it"
#
# Dependencies:
#   None
#
# Configuration:
#   WEBHOOK_TOKEN
#
# Commands:
#   None
#
# URLs:
#   POST /hubot/say
#     message = <message>
#     room = <room>
#     type = <type>
#
#   curl -X POST http://localhost:8080/hubot/webhook -d message=wakkaflakka -d room='#general'
#
# Author:
#   blairanderson

WEBHOOK_TOKEN = process.env.WEBHOOK_TOKEN || "taco"
HUBOT_SLACK_TOKEN = process.env.HUBOT_SLACK_TOKEN
SLACK_SUBDOMAIN = process.env.SLACK_SUBDOMAIN
# 'payload={"text": "This is posted to <#general> and comes from *monkey-bot*.", "channel": "#general", "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' https://my-team.slack.com/services/hooks/incoming-webhook?token=XXXXXXXXXXXXXXX

module.exports = (robot) ->
  robot.router.post '/webhook/:room', (req, res) ->
    room = "#"+"#{req.params.room}"
    message = {
        "text": room,
        "channel": room,
        "username": "lita"
        "icon_emoji": ":cow:"
    }

    url = "https://#{SLACK_SUBDOMAIN}.slack.com/services/hooks/incoming-webook?token=#{HUBOT_SLACK_TOKEN}"
    data = JSON.stringify(message)
    robot.http(url).post(data) (err, res, body) ->
      if err
        res.send("some error: #{JSON.stringify(err)}")
      else
        res.send("OK")
      # your code here
