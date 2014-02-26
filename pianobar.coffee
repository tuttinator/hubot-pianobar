# Description:
#  Control pianobar 
#
# Commands:
#  pianobar <command>
#  See the full list of commands here: http://manpages.ubuntu.com/manpages/maverick/man1/pianobar.1.html
#

fs = require('fs')
Tail = require('tail').Tail
log = new Tail('/var/log/pianobar')
command = fs.createWriteStream('~/.config/pianobar/ctl', {'flags': 'a'})

module.exports = (robot) ->
  robot.respond /pianobar\s*(.*)?$/i, (msg) ->
    command.write msg.match[1] + '\n'
 
  log.on "line", (data) ->
    robot.send HUBOT_PIANOBAR_TARGET_JABBER_ID, data
