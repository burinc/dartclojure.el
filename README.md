### Emacs Interface to [DartClojure][0]
### Example Usage

- Convert region of code (in-place editing)
![](https://github.com/burinc/dartclojure.el/raw/main/media/dartclojure-convert.gif)

- Convert a region into clipboard for pasting into main code 
![](https://github.com/burinc/dartclojure.el/raw/main/media/dartclojure-to-clipboard.gif)

- Convert a region into a scratch buffer that can be quickly reviewed
![](https://github.com/burinc/dartclojure.el/raw/main/media/dartclojure-paste-buffer.gif)

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
  (setq dartclojure-opts "-m \"m\" -f \"f\""))
```

You can also select a region in a file and run `M-x dartclojure-to-clipboard` to save the result to clipboard.

Remap some of your Emacs keys to make it easier to use.
e.g. for Doom Emacs, I use the following:

``` emacs-lisp
;; config.el
(map! :leader
      (:prefix ("d" . "dartclojure")
       :desc "dartclojure to buffer"
       "b" #'dartclojure-paste-buffer
       :desc "dartclojure to clipboard"
       "c" #'dartclojure-to-clipboard
       :desc "dartclojure converter"
       "x" #'dartclojure-convert))
```

So you can type `SPC d b`, `SPC d c`, or `SPC d x`.

### Usage

To convert a given region in any buffer into ClojureDart syntax just `M-x dartclojure-convert`

### Links


[0]: https://github.com/D00mch/DartClojure
[1]: https://github.com/D00mch/DartClojure/releases
[2]: https://github.com/doomemacs/doomemacs
