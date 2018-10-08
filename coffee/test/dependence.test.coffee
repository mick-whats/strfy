assert = require 'assert'
{test} = require 'ava'
dependence = require '../lib/dependence'

test 'vue', (t) ->
  vuejs = await dependence.vue()
  t.true vuejs.includes('Vue.js v2.5.17-beta.0')
test 'vue_json_pretty', (t) ->
  _vue_json_pretty = await dependence.vue_json_pretty()
  t.true _vue_json_pretty.includes('name:"vue-json-pretty"')
test 'htmlTemplate', (t) ->
  _htmlTemplate = await dependence.htmlTemplate()
  t.true _htmlTemplate.includes('<!DOCTYPE html>')
  t.true _htmlTemplate.includes('VueJsonPretty: VueJsonPretty.default')
