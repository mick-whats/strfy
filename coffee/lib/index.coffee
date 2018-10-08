_ = require 'lodash'
path = require 'path'
os = require 'os'
util = require('util')
fs = require('fs')
writeFile = util.promisify(fs.writeFile)
opn = require('opn')
safeJsonStringify = require('safe-json-stringify')
dependence = require './dependence'
objelity = require 'objelity'

BASE_FILE_NAME = 'strfy.html'
class Strfy
  getTmpFilePath = ->
    tmpDir = os.tmpdir()
    return path.join(tmpDir,BASE_FILE_NAME)
  stringConvertingByType = (obj)->
    switch typeof obj
      when 'undefined'
        'undefined'
      when 'boolean','number','string'
        safeJsonStringify obj
      when 'function'
        obj.toString()
      else
        if _.isNull(obj)
          safeJsonStringify(obj)
        else if _.isArray(obj)
          safeJsonStringify(obj)
        else
          safeJsonStringify(objelity.toStringOfDeepKeys(obj))
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
    @body = stringConvertingByType(obj)
  
  save: ()->
    filePath = @filePath
    new Promise (resolve, reject)=>
      makeHtml(@body)
      .then (_html)->
        writeFile(filePath, _html)
        .then ()->
          resolve(filePath)
      .catch(reject)
  open: ()->
    new Promise (resolve, reject)=>
      @save()
      .then (filePath)->
        opn(filePath,{wait: false})
        .then ()-> resolve(filePath)
      .catch(reject)
  @save: (obj)->
    new Strfy(obj).save()
  @open: (obj)->
    new Strfy(obj).open()
  @path: -> getTmpFilePath()
module.exports = Strfy
