### Emacs Interface to [DartClojure][0]

### Installation

1. Install [DartClojure][1] pre-built binary for your OS (Mac/Linux).
2. Install this Emacs package via your Emacs distribution.

Load it using your preferred Emacs package manager, e.g., for [DoomEmacs][2]:

```emacs-lisp
;; packages.el`
(package! dartclojure :recipe (:host github :repo "burinc/dartclojure.el"))

;; config.el
(use-package! dartclojure
  :config 
  (setq dartclojure-bin "dartclojure"
        dartclojure-opts "-m \"m\" -f \"f\""))
```

### Usage

To convert a given region in any buffer into ClojureDart syntax just `M-x dartclojure-convert`

### Links


[0]: https://github.com/D00mch/DartClojure
[1]: https://github.com/D00mch/DartClojure/releases
[2]: https://github.com/doomemacs/doomemacs
