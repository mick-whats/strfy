// Generated by CoffeeScript 2.3.1
(function() {
  var assert, path, sample, sample2, strfy, test;

  assert = require('assert');

  ({test} = require('ava'));

  path = require('path');

  strfy = require('../');

  sample = {
    str: 'hello world!!',
    num: 999,
    arr: [1, 2, 3, 4, 5, 6, 7],
    bool: true,
    fn: (function() {
      return false;
    }).toString(),
    obj: {
      a: 1,
      b: 'box',
      c: ['x', 'y', 'z']
    },
    un: void 0,
    nil: null
  };

  sample2 = {
    a: {
      b: {
        c: {
          d: {
            e: {
              f: 'g'
            }
          }
        }
      }
    }
  };

  test.skip('constructor', async function(t) {
    var s;
    s = new strfy(sample);
    t.log((await s.open().catch(function(e) {
      throw e;
    })));
    return t.pass();
  });

  test('open', async function(t) {
    var _path;
    _path = (await strfy.open(sample));
    _path = (await strfy.open([
      1,
      '2',
      true,
      null,
      {
        a: 'b'
      }
    ]));
    return t.true(path.isAbsolute(_path));
  });

  test.only('save', async function(t) {
    var _path;
    _path = (await strfy.save(sample));
    return t.true(path.isAbsolute(_path));
  });

  test('path', function(t) {
    return t.true(path.isAbsolute(strfy.path()));
  });

  test.skip('readme', function(t) {
    return strfy.open(sample).then(function(html_path) {
      t.log(html_path);
      return t.pass();
    }).catch(function(e) {
      throw e;
    });
  });

}).call(this);
