TDD status mode-line widget
===========================

This little package implements a mode-line widget to track one's
current test-driven development state (*FAIL*, *PASS*, or *REFACTOR*).
Fully customisable faces and states and all that. The idea is based on
a [similar solution for Vim][athos-tdd-vim].

 [athos-tdd-vim]: https://github.com/attilammagyar/dotfiles/commit/3f0df4d86356ea33ca6054924834216ea41f20a5

![Screenshot](https://raw.github.com/algernon/tdd-status-mode-line/master/data/screenshot.png)

Installation
------------

Once the package is downloaded, either via a git checkout or simply
saving the `tdd-status-mode-line.el` file somewhere on your load path,
simply requiring it is all you need. The package adds the TDD status
to `mode-line-misc-info`, you need to have that in your mode-line for
the package to work.

Usage
-----

The package defines three global key bindings:

 * `C-x t n` advances the state (from none to *FAIL*, then to *PASS*
   and onto *REFACTOR*, and finally back to *FAIL*).
 * `C-x t p` steps the state back (from *PASS* to *FAIL*, etc).
 * `C-x t c` clears the state and hides the widget.

Apart from this, the package provides a `tdd-status/make-local`
interactive command, with which one can make the TDD state buffer
local. By default, this is not bound to any key. If one wants this to
be the default, use it like this in the appropriate emacs init file:

```lisp
(require 'tdd-status-mode-line)
(tdd-status/make-local)
```
