contextPackageFinder = require '../../context-package-finder'
git = require '../../git'
notifier = require '../../notifier'

module.exports = (repo) ->
  if path = contextPackageFinder.get()?.selectedPath
    file = repo.relativize(path)
    file = '.' if file is ''
    git.cmd(['reset', 'HEAD', '--', file], cwd: repo.getWorkingDirectory())
    .then(notifier.addSuccess)
    .catch(notifier.addError)
  else
    notifier.addInfo "No file selected to unstage"
