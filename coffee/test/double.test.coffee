{test} = require 'ava'
strfy = require('../')
td = require('testdouble')
os = require('os')
path = require('path')
HTMLHint  = require("htmlhint").HTMLHint
isTmpPath = (p)->
  flag =false
  if path.isAbsolute(p)
    flag = true
  else
    throw new Error "TMPDIR is not absolute path"
  flag
isHtml = (str)->
  rules =
    "tagname-lowercase": false,
    "attr-lowercase": false,
    "attr-value-double-quotes": true,
    "doctype-first": true,
    "tag-pair": true,
    "spec-char-escape": false,
    "id-unique": true,
    "src-not-empty": true,
    "attr-no-duplication": true,
    "title-require": true
  v = HTMLHint.verify(str,rules)
  if v.length
    throw new Error v[0].message
  else
    true

test.serial.beforeEach (t)->
  t.context.utility = td.replace('../lib/utility')
  t.context.strfy = require('../')
  return
test.afterEach ->
  td.reset()
  return


test.serial 'save', (t) ->
  td.when(t.context.utility.writeFile(
    td.matchers.argThat(isTmpPath),
    td.matchers.argThat(isHtml)
    ))
  .thenResolve()
  t.context.strfy.save({a:100})
  .then (result)->
    # 代替のutility.writeFileが呼ばれていることの確認
    ex = td.explain(t.context.utility.writeFile)
    t.is ex.callCount, 1
    return
  .catch (e)->
    t.fail()
    return

test.serial 'open', (t) ->
  td.when(t.context.utility.writeFile(
    td.matchers.argThat(isTmpPath),
    td.matchers.argThat(isHtml)
    ))
  .thenResolve()
  td.when(t.context.utility.opn(
    td.matchers.argThat(isTmpPath)
    {wait: false}
    ))
  .thenResolve()
  t.context.strfy.open({a:100})
  .then (result)->
    # 代替のutilityが呼ばれていることの確認
    t.is td.explain(t.context.utility.writeFile).callCount, 1
    t.is td.explain(t.context.utility.opn).callCount, 1
    return
  .catch (e)->
    t.fail()
    return

test.serial 'isTmpPath', (t) ->
  t.true isTmpPath(os.tmpdir())
  return