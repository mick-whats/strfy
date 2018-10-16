util = require('util')
fs = require('fs')
opn = require('opn')
module.exports =
  writeFile: util.promisify(fs.writeFile)
  opn: opn