### Emacs Interface to [DartClojure][1]

### Installation

1. Install [DartClojure][1] binary for your OS.
2. Install this Emacs package via your Emacs distribution.

e.g. for [DoomEmacs][2] add the following snippets to your `packages.el` config.

```emacs-lisp
;; in your `packages.el`
(package! dartclj :recipe (:host github :repo "burinc/dartclj.el"))
```

### Usage

To convert a given region in any buffer into ClojureDart syntax just `M-x dartclj-convert`

### Links

[1]: https://github.com/D00mch/DartClojure
[2]: https://github.com/doomemacs/doomemacs
