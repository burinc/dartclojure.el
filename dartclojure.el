;;; dartclojure.el --- Convert Dart/Flutter widget code to ClojureDart syntax -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Burin Choomnuan
;;
;; Author: Burin Choomnuan <burin@duck.com>
;; Maintainer: Burin Choomnuan <burin@duck.com>
;; Created: September 27, 2023
;; Modified: September 27, 2023
;; Version: 0.1.0
;; Keywords: languages convenience local processes tools files
;; Homepage: https://github.com/burinc/dartclojure.el
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;  Convert Dart/Flutter widget code to ClojureDart syntax using `dartclojure' tools.
;;
;;  Wrappter around https://github.com/D00mch/DartClojure library.
;;; Code:

(defgroup dartclojure nil
  "Wrapper for `DartClojure' tool."
  :group 'dartclojure)

(defcustom dartclojure-bin "dartclojure"
  "The DartClojure binary path."
  :type 'string
  :group 'dartclojure
  :package-version '(dartclojure . "0.1.0"))

(defcustom dartclojure-opts "-m \"m\" -f \"f\""
  "Options argument to use with `dartclojure' tool.

`-m' material require alias
`-f' flutter-macro require alias"
  :type 'string
  :group 'dartclojure
  :package-version '(dartclojure . "0.1.0"))

(defun dartclojure-convert ()
  "Convert Dart/Flutter widget code to ClojureDart code."
  (interactive)
  (let ((region (buffer-substring-no-properties (region-beginning) (region-end))))
    (shell-command-on-region
     (region-beginning)
     (region-end)
     (concat dartclojure-bin
             " "
             (shell-quote-argument region)
             " "
             dartclojure-opts)
     (current-buffer)
     t
     "*dartclojure error buffer*"
     t)))

(provide 'dartclojure)
;;; dartclojure.el ends here
