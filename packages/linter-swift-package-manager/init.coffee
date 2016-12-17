{CompositeDisposable} = require 'atom'
path = require 'path'
child_process = require 'child_process'

regex = ///
    (\S+):  #The file with issue.
    (\d+):  #The line number with issue.
    (\d+):  #The column where the issue begins.
    \s+     #A space.
    (\w+):  #The type of issue being reported.
    \s+     #A space.
    (.*)    #A message explaining the issue at hand.
  ///

module.exports =
  config:
    executablePath:
      type: 'string'
      title: 'Configure Swift Executable (Swift Package Manager requires Swift 2.2-dev)'
      description:'full path:'
      default: '/usr/bin/swift'
  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-swift-package-manager.executablePath',
      (executablePath) =>
        @executablePath = executablePath
  deactivate: ->
    @subscriptions.dispose()
  provideLinter: ->
    helpers = require('atom-linter')
    provider =
      name: 'linter-swift-package-manager'
      grammarScopes: ['source.swift']
      scope: 'file' # or 'project'
      lintOnFly: false # must be false for scope: 'project'
      lint: (textEditor) =>
        new Promise (Resolve) ->
          data = []
          filePath = textEditor.getPath()
          rootFolder = atom.project.relativizePath(filePath)[0]
          swiftPath = "#{atom.config.get 'linter-swift-package-manager.executablePath'}" + " build"
          process = child_process.exec swiftPath , {cwd: rootFolder}
          process.stderr.on 'data', (d) -> data = data.concat(d.toString().split("\n"))
          process.on 'close', ->
            toReturn = []
            for line in data
              if line.match regex
                [file, line, column, type, message] = line.match(regex)[1..5]
                toReturn.push(
                  type: type,
                  text: message,
                  filePath: file
                  range: [[line - 1, column - 1], [line - 1, column - 1]]
                )
            Resolve toReturn
