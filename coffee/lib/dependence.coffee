_ = require('lodash')
util = require('util')
fs = require('fs')
path = require('path')
readFile = util.promisify(fs.readFile)
module.exports =
  htmlTemplate: ->
    new Promise (resolve, reject)->
      readFile path.join(__dirname,'..','template/basic.html'),'utf-8'
      .then(resolve)
      .catch(reject)
  vue: ->
    new Promise (resolve, reject)->
      readFile path.join(__dirname,'..','dependence/vue.min.js'),'utf-8'
      .then(resolve)
      .catch(reject)
  vue_json_pretty: ->
    new Promise (resolve, reject)->
      readFile path.join(__dirname,'..','dependence/vue-json-pretty.js'),'utf-8'
      .then(resolve)
      .catch(reject)
  logo: ->
    new Promise (resolve, reject)->
      readFile path.join(__dirname,'..','image/strfy_logo3.svg'),'utf-8'
      .then(resolve)
      .catch(reject)