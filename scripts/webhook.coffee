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

module.exports = (robot) ->
  robot.router.post '/webhook/:room', (req, res) ->
    room = "#"+"#{req.params.room}"
    data = null
    robot.messageRoom room, req.body.payload
    # try
    #   data = JSON.parse req.body.payload
    # catch err
    #   robot.emit 'error', err

    token = data.token

    message = data.message

    if token == WEBHOOK_TOKEN
      robot.messageRoom room, message
      res.send 'OK'
    else
      res.send 'AIGHT'
