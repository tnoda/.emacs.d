;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; LANG environment variable
;;;
(setenv "LANG" "C")
(setq system-time-locale "C")

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
;;; Homebrew/Cask
;;; 

(defun tnoda/find-brew-cask-prefix
  ()
  (when (eq system-type 'darwin)
    (with-current-buffer (get-buffer-create "*brew-cask-prefix")
      (erase-buffer)
      (if (zerop (call-process "brew" nil t nil "--prefix" "cask"))
          (buffer-substring (point-min) (1- (point-max)))))))

(defconst tnoda/cask-el-path
  (let ((prefix (tnoda/find-brew-cask-prefix)))
    (if prefix
        (expand-file-name "cask.el" prefix))))

(defun tnoda/cask-setup
  ()
  (cask-initialize)
  (defun tnoda/add-cask-org-plus-contrib-dir-to-info-directory-list ()
    (add-to-list 'Info-directory-list
                 (cask-resource-path "org-plus-contrib")))
  (add-hook 'Info-mode-hook
            'tnoda/add-cask-org-plus-contrib-dir-to-info-directory-list))

(defun tnoda/package-el-setup
  ()
  (require 'package)
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
  (package-initialize))

(if (require 'cask tnoda/cask-el-path t)
    (tnoda/cask-setup)
  (tnoda/package-el-setup))


;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(defconst tnoda/dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(require 'org)
(require 'ob-tangle)

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files tnoda/dotfiles-dir t "\\.org$"))

;;; init.el ends here

;;; Originally retrieved from http://orgmode.org/worg/org-contrib/babel/intro.html on 2012-01-10
