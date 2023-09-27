;;; dartclj.el --- Convert Dart/Flutter widget code to ClojureDart syntax -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Burin Choomnuan
;;
;; Author: Burin Choomnuan <burin@duck.com>
;; Maintainer: Burin Choomnuan <burin@duck.com>
;; Created: September 27, 2023
;; Modified: September 27, 2023
;; Version: 0.1.0
;; Keywords: languages convenience local processes tools files
;; Homepage: https://github.com/burinc/dartclj
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;  Convert Dart/Flutter widget code to ClojureDart syntax using `dartclj' tools.
;;
;;  Wrappter around https://github.com/D00mch/DartClojure library.
;;; Code:

(defgroup dartclj nil
  "Wrapper for `DartClojure' tool."
  :group 'dartclj)

(defcustom dartclj-opts "-m \"m\" -f \"f\""
  "Options argument to use with `dartclj' tool.

`-m' material require alias
`-f' flutter-macro require alias"
  :type 'string
  :group 'dartclj
  :package-version '(dartclj . "0.1.0"))

(defun dartclj-convert ()
  "Convert Dart/Flutter widget code to ClojureDart code."
  (interactive)
  (let ((region (buffer-substring-no-properties (region-beginning) (region-end))))
    (shell-command-on-region
     (region-beginning)
     (region-end)
     (concat  "dartclj"
              " "
              (shell-quote-argument region)
              " "
              dartclj-opts)
     (current-buffer)
     t
     "*dartclj error buffer*"
     t)))

(provide 'dartclj)
;;; dartclj.el ends here
