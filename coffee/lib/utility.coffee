fs = require('fs')
opn = require('opn')
module.exports =
  writeFile: (filePath, data)->
    new Promise (resolve, reject)->
      fs.writeFile filePath, data, (err)->
        reject(err) if err
        resolve()
  readFile: (filePath, opt)->
    new Promise (resolve, reject)->
      fs.readFile filePath, opt, (err, data)->
        reject(err) if err
        resolve(data)
  opn: opn