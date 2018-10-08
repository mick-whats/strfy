# STRFY

## use it

```js
var strfy = require('strfy')
var sample = {
  str: 'hello world!!',
  num: 999,
  arr: [1, 2, 3, 4, 5],
  bool: true,
  fn: (function() {
    return false;
  }).toString(),
  module: strfy,
  obj: {
    a: 1,
    b: 'box',
    c: ['x', 'y', 'z']
  },
  un: void 0,
  nil: null
};

strfy.open(sample)

// or

strfy.open(sample)
.then()
.catch()
```

`strfy.open`はobjectをbrowserで開く関数です。
内部的にはhtmlに変換し、TMPDIR(osごとに異なるtemporary directory)に保存します。それをosごとに異なるopenコマンドで開きます。

strfy.open(sample)で動作しますが、これはpromiseオブジェクトを返します。なので一部のtest環境などでは適切に`then``catch`を配置する必要があります。  
また、promiseなので`await`も使用できます。


## install

```sh
npm i strfy --save-dev

# or

yarn add strfy --dev
```

## api

---
### open
---

引数に渡したobjectをBrowserで表示します。  
returnしたPromiseはhtmlファイルのpathを返します。
#### Arguments
Object (Object | Array)

#### Returns
Promise Object

#### Example

```js
strfy.open(obj)
.then(function(html_path) {
  console.info(html_path);
})
.catch(function(e) {
  throw e;
});
```
---
### save
---

引数に渡したobjectをhtmlで保存します。  
openは実行ごとに新しくBrowserを開きます。この処理が不要な場合にsaveを使うと便利です。


htmlはTMPDIRに作成されます。  
Promiseはhtmlファイルのpathを返します。
#### Arguments
Object (Object | Array)

#### Returns
Promise Object

#### Example

```js
strfy.save(obj)
.then(function(html_path) {
  console.info(html_path);
})
.catch(function(e) {
  throw e;
});
```
---
### path
---

htmlのpathを取得します。
#### Arguments
none

#### Returns
path (string)

#### Example

```js
strfy.path()
```

## with browsersync

```sh
> browser-sync start --server "{strfy.path}" --files "*.html"

> open "http://localhost:3000/strfy.html"
```