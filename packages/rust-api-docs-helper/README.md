# rust-api-docs-helper package
![demo](https://github.com/plafue/rust-api-docs-helper/raw/master/demo/demo.ogv.gif)

## What this package can do
* Opening (via key binding) the docs for a module, crate, trait, function or struct from the official crates listed under [The Rust Standard Library](http://doc.rust-lang.org/std/) (the cursor must be positioned in the corresponding ``use xxx::xxx`` line).
* Scans .rs files for imports and adds a clickable icon in the gutter in the lines docs are available for.
* Can display the docs within atom if an internal browser (e.g. [mark-hahn/web-browser](https://atom.io/packages/web-browser)) is installed.

## Future plans
* Make cache persistent between sessions (won't work until atom/atom#3695 is fixed).
