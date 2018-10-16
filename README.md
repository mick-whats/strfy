# STRFY

Display the object in the browser for easy viewing

![image](https://user-images.githubusercontent.com/9634573/46605903-107b7900-cb36-11e8-95fc-e232b2862cdd.png)

## use it

```js
var strfy = require('strfy')
var sample = {
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

strfy.open(sample)

// or

strfy.open(sample)
.then()
.catch()
```

  
大きなObjectを`console.log`等で表示しても、全体像の把握が困難です。

その解決手段としてstrfyを作りました。


`strfy.open`は引数のobjectをbrowserで開きます。

内部的にはhtmlに変換し、TMPDIR(osごとに異なるtemporary directory)に保存します。それをosごとに異なるopenコマンドで開きます。

`strfy.open(object)`で動作しますが、これはpromiseオブジェクトを返します。  
なので一部のtest環境など動作しない場合は適切に`then`,`catch`を配置する必要があります。  
また、promiseなので`await`も使用できます。

`strfy.open`は実行するたびに新しいwindowを開きます。  
この挙動が不満なら、`strfy.save`が使えば保存のみを行います。

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

`strfy.open`は自動でBrowserを開きますが、この関数は保存だけを行います。  
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

browsersyncを使うと別のPCやスマートフォン等に表示することもできます。

```sh
> URI={{html_path}} &&browser-sync start --server $URI --files $U
RI/strfy.html --startPath "/strfy.html"
```

[Browsersync \- Time\-saving synchronised browser testing](https://browsersync.io/)