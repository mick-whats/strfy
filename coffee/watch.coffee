util = require('util')
fs = require 'fs'
rename = util.promisify(fs.rename)
readFile = util.promisify(fs.readFile)
writeFile = util.promisify(fs.writeFile)
chmod = util.promisify(fs.chmod)
chokidar = require('chokidar')
watcher = chokidar.watch './bin/*'

watcher.on('ready', ()-> console.log('監視開始'))
watcher.on 'add', (path)->
  console.log("追加ファイル-> #{path}")
  if /\.js$/.test(path)
    try
      data = await readFile(path,{encoding: 'utf8'})
      data = '#!/usr/bin/env node\n' + data
      await writeFile(path,data,{mode: 755})
      newPath = path.replace('.js','')
      await rename(path,newPath)
      await chmod(newPath,'755')
    catch e
      throw e

watcher.on('addDir', (path)-> console.log("追加ディレクトリ-> #{path}"))
watcher.on('unlink', (path)-> console.log("削除されました-> #{path}"))
watcher.on('unlinkDir', (path)-> console.log("削除されました-> #{path}"))
watcher.on 'change', (path)->
  console.log("修正されました-> #{path}")

watcher.on('error', (error)-> console.log("エラーです-> #{error}"))
