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
;; Package-Requires: ((emacs "27.1") (transient "0.3.7"))
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

(require 'transient)
(require 'subr-x)

(defgroup dartclojure nil
  "Wrapper for `DartClojure' tool."
  :group 'dartclojure)

(defcustom dartclojure-command "dartclojure"
  "The DartClojure command name to run."
  :group 'dartclojure
  :type 'string)

(defcustom dartclojure-default-args '("-m" "m" "-f" "f")
  "The default args to dartclojure command, useful for quick runs."
  :group 'dartclojure
  :type '(repeat string))

(defvar dartclojure-version-string "0.1.0")

(defvar dartclojure-output-buffer-name "*dartclojure output*")

(defvar dartclojure-error-buffer-name "*dartclojure error*")

(defvar dartclojure-bin (executable-find "dartclojure")
  "Full path of dartclojure binary.")

(defcustom dartclojure-opts "-m \"m\" -f \"f\""
  "Options argument to use with `dartclojure' tool.

`-m' material require alias
`-f' flutter-macro require alias"
  :type 'string
  :group 'dartclojure
  :package-version '(dartclojure . "0.1.0"))

(defun dartclojure--assert-dartclojure-on-path ()
  "Asserts if dartclojure is on path."
  (unless (executable-find dartclojure-command)
    (error "The dartclojure command was not found on Emacs PATH")))

(defun dartclojure--run (command &rest args)
  "Run COMMAND with ARGS."
  (dartclojure--assert-dartclojure-on-path)
  (with-output-to-string
    (with-current-buffer standard-output
      (shell-command
       (string-join (append (list command) (seq-map #'shell-quote-argument args)) " ")
       t
       dartclojure-error-buffer-name))))

(defun dartclojure-menu--run (thing args)
  "Run dartclojure for THING at cursor and ARGS and return result."
  (apply #'dartclojure--run
         (format "%s \"%s\"" dartclojure-command thing) args))

(defun dartclojure--thing-at-point ()
  "Return the active region or the thing at point."
  (string-trim
   (if (use-region-p)
       (buffer-substring-no-properties
        (region-beginning)
        (region-end))
     (thing-at-point 'sexp t))))

(defun dartclojure-menu--interactive-args ()
  "Interactive args for `dartclojure-menu--run' functions."
  (list (or (and transient-current-prefix
                 (oref transient-current-prefix scope))
            (dartclojure--thing-at-point))
        (or (transient-args transient-current-command)
            dartclojure-default-args)))

;;; Public API
;;;###autoload
(defun dartclojure-to-clipboard (thing &optional args)
  "Run dartclojure for THING at cursor and ARGS copying to clipboard."
  (interactive (dartclojure-menu--interactive-args))
  (with-temp-buffer
    (insert (string-trim (dartclojure-menu--run thing args)))
    (clipboard-kill-region (point-min) (point-max)))
  (message "Copied dartclojure result to clipboard"))

;;;###autoload
(defun dartclojure-convert ()
  "Convert Dart/Flutter widget code to ClojureDart code."
  (interactive)
  (dartclojure--assert-dartclojure-on-path)
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
     dartclojure-error-buffer-name
     t)))

;;;###autoload
(defun dartclojure-paste-cursor (thing &optional args)
  "Run dartclojure for THING at cursor and ARGS pasting to current buffer."
  (interactive (dartclojure-menu--interactive-args))
  (let ((result (string-trim (dartclojure-menu--run thing args))))
    (if (use-region-p)
        (replace-region-contents (region-beginning) (region-end) (lambda () result))
      (insert result))))

;;;###autoload
(defun dartclojure-paste-buffer (thing &optional args)
  "Run dartclojure for THING at cursor and ARGS pasting to current buffer."
  (interactive (dartclojure-menu--interactive-args))
  (let* ((result (string-trim (dartclojure-menu--run thing args))))
    (with-current-buffer (get-buffer-create dartclojure-output-buffer-name)
      (erase-buffer)
      (insert result)
      (display-buffer (current-buffer)))))

;;;###autoload
(defun dartclojure-print-help()
  "Print the dartclojure version."
  (interactive)
  (message (string-trim (dartclojure--run dartclojure-command "--help"))))

(provide 'dartclojure)
;;; dartclojure.el ends here
