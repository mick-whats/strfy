_ = require 'lodash'
path = require 'path'
os = require 'os'
utility = require './utility'
dependence = require './dependence'
objelity = require 'objelity'

BASE_FILE_NAME = 'strfy.html'
class Strfy
  getTmpFilePath = ->
    tmpDir = os.tmpdir()
    return path.join(tmpDir,BASE_FILE_NAME)
  makeHtml = (body)->
    new Promise (resolve, reject)->
      Promise.all [
        dependence.htmlTemplate()
        dependence.vue()
        dependence.vue_json_pretty()
        dependence.logo()
      ]
      .then (arr)->
        compiled = _.template(arr[0])
        _html = compiled {
          logo: arr[3]
          vue_js: arr[1]
          vue_json_pretty_js: arr[2]
          json_body: body
          tmpPath: os.tmpdir()
        }
        resolve(_html)
      .catch(reject)
  constructor: (obj) ->
    @filePath = getTmpFilePath()
    @body = objelity.stringify(obj)

  save: ()->
    filePath = @filePath
    new Promise (resolve, reject)=>
      makeHtml(@body)
      .then (_html)->
        utility.writeFile(filePath, _html)
        .then ()->
          resolve(filePath)
      .catch(reject)
  open: ()->
    new Promise (resolve, reject)=>
      @save()
      .then (filePath)->
        utility.opn(filePath,{wait: false})
        .then ()-> resolve(filePath)
      .catch(reject)
  @save: (obj)->
    new Strfy(obj).save()
  @open: (obj)->
    new Strfy(obj).open()
  @path: -> getTmpFilePath()
module.exports = Strfy
