;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; LANG environment variable
;;;
(setenv "LANG" "en_US.UTF-8")
(setq system-time-locale "en_US.UTF-8")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Language Environment
;;;
(set-language-environment "UTF-8")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Per-host Settings
;;;
(load (expand-file-name ".local.el" (getenv "HOME")) t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; use-package
;;;
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("ELPA" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))
(package-initialize)
(unless (require 'use-package nil t)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)
    (require 'use-package)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; dash.el
;;;
(use-package dash
  :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Org mode
;;;
(use-package org-plus-contrib
  :ensure t
  :config
  (require 'ob-tangle))

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(defconst tnoda/dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(org-babel-load-file (expand-file-name "tnoda.org" tnoda/dotfiles-dir))

;;; init.el ends here

;;; Originally retrieved from http://orgmode.org/worg/org-contrib/babel/intro.html on 2012-01-10
