assert = require 'assert'
{test} = require 'ava'
path = require 'path'
os = require('os')
strfy = require '../'

sample =
  str: 'hello world!!'
  num: 999
  arr: [1,2,3,4,5,6,7]
  bool: true
  fn: (-> false).toString()
  obj:
    a:1
    b: 'box'
    c: ['x','y','z']
  un: undefined
  nil: null

sample2 =
  a:
    b:
      c:
        d:
          e:
            f: 'g'

test.skip 'constructor', (t) ->
  s = new strfy(sample2)
  t.log await s.open().catch (e)-> throw e
  t.pass()


test 'path', (t) ->
  t.true path.isAbsolute strfy.path()

test.skip 'readme',(t)->
  strfy.open(sample)
  .then (html_path)->
    t.log html_path
    t.pass()
  .catch (e)-> throw e
  
test 'tmpdir is absolute path', (t) ->
  t.true path.isAbsolute os.tmpdir()