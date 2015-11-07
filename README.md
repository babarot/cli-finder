cli-finder
===

[![](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)][license]

cli-finder is a simple CLI tool that provides the finder like Mac on the command-line.

## Description

***DEMO:***

![DEMO](https://raw.githubusercontent.com/b4b4r07/screenshots/master/cli-finder/demo.gif)

## Features

- Interactive
- Tree style (or list style)
- Many kinds of keybinds

## Usage

```console
$ finder [path]
```

### Keymap

These are extended keybinds below.

| Keys | Actions |
|------|-------|
| Enter  | Outputs the path undert the cursor to your terminal |
| Ctrl-R | Toggle cli-finder mode (default to `$CLI_FINDER_MODE`) |
| Ctrl-L | Quick view with `$PAGER` (using `pygmentize` if available) |
| Ctrl-V | Edit with `$EDITOR` |

And about more keybinds see `man fzf`.

## Installation

### Using [Antigen](https://github.com/zsh-users/antigen)

```console
$ antigen bundle b4b4r07/cli-finder
```

### Antigen-free install

To install this tool without Antigen:

```console
$ sudo sh -c "curl https://raw.githubusercontent.com/b4b4r07/cli-finder/master/bin/finder -o /usr/local/bin/finder && chmod +x /usr/local/bin/finder"
```

cli-finder is a shell script, so put it somewhere and make sure it's added to your `$PATH`.

## Prerequisite

- [fzf](https://github.com/junegunn/fzf)

## License

[MIT][license] © BABAROT (a.k.a. [b4b4r07](http://tellme.tokyo))

[license]: http://b4b4r07.mit-license.org
