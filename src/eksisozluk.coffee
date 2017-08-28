# Description
#   A hubot script that retrieves random entries from Turkish collaborative hypertext dictionary eksisozluk.com
#
# Configuration:
#
# Commands:
#   hubot <topic> nedir
#   hubot <topic> neresidir
#   hubot <topic> nasıldır
#   hubot <topic> kimdir
#   hubot <topic> yeşillendir
#
# Notes:
#
# Author:
#   Mehmet Ali Aydın <maaydin@gmail.com>

osmosis = require('osmosis')

nedir = (msg) ->
   query = msg.match[1]
   contents = []
   osmosis.get('https://eksisozluk.com/?q=' + query)
      .find('.content')
      .set('content')
      .data((content) ->
         contents.push content
      ).done ->
         content = contents[Math.floor(Math.random() * contents.length)]
         if content?
            msg.send "@" + msg.message.user.name + " " + content.content
         else
            msg.send "@" + msg.message.user.name + " böyle bir şey yok."

module.exports = (robot) ->
    robot.respond /(.+).(nedir|neresidir|nas.ld.r|kimdir|ye.illendir).*/i, (msg) ->
        nedir msg
