{spawn} = require('child_process')

cmd = require 'commander'
cmd.version('0.0.1')
.command('inits <dir>')
.action (dir)->
  console.log process.cwd()
  ls = spawn('ls', [
    '-lh'
  ])

  ls.stdout.on 'data', (data) ->
    console.log 'stdout: ' + data
    return
  ls.stderr.on 'data', (data) ->
    console.log 'stderr: ' + data
    return
  ls.on 'close', (code) ->
    console.log 'child process exited with code ' + code
    return
cmd.parse process.argv
