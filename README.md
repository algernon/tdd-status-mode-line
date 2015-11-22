TDD status mode-line widget
===========================

[![Build Status](https://travis-ci.org/algernon/tdd-status-mode-line.png?branch=master)](https://travis-ci.org/algernon/tdd-status-mode-line)

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
simply require it and enable one of the two minor modes it provides.

The package is also available from [Marmalade](http://marmalade-repo.org/)
and [MELPA](https://melpa.org/):

```lisp
(require 'package)
;; Use one or both of the following two lines
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-install 'tdd-status-mode-line)

(require 'tdd-status-mode-line)
```

Usage
-----

The package defines two minor modes, only one of which should be
enabled at a time, and switching between them is not supported. Both
of them provide the same key bindings:

 * `C-x t n` advances the state (from none to *FAIL*, then to *PASS*
   and onto *REFACTOR*, and finally back to *FAIL*).
 * `C-x t p` steps the state back (from *PASS* to *FAIL*, etc).
 * `C-x t c` clears the state and hides the widget.

The two minor modes are `tdd-status-minor-mode` and
`tdd-status-global-mode`, where the first enables the mode for the
current buffer only and will track the TDD state on a per-buffer basis
from that point on; the second enables the mode globally, with global
tracking.

To use the buffer-local mode of operation, place something like this
in your init file:

```lisp
(require 'tdd-status-mode-line)
(add-hook 'prog-mode-hook 'tdd-status-minor-mode)
```

To enable it globally, use something like the following:

```lisp
(require 'tdd-status-mode-line)
(tdd-status-global-mode)
```
