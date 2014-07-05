;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

(require 'cask "~/.emacs.d/.cask/cask.el")
(cask-initialize)

(require 'cl)

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(defconst tnoda/dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(let* ((org-dir (expand-file-name
                 "lisp" (expand-file-name
                         "org" (expand-file-name
                                "src" tnoda/dotfiles-dir))))
       (org-contrib-dir (expand-file-name
                         "lisp" (expand-file-name
                                 "contrib" (expand-file-name
                                            ".." org-dir)))))
  (setq load-path (append (list org-dir org-contrib-dir)
                          (or load-path nil))))

;; load up Org-mode and Org-babel
(require 'org)
(require 'ob-tangle)

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files tnoda/dotfiles-dir t "\\.org$"))

;;; init.el ends here

;;; Originally retrieved from http://orgmode.org/worg/org-contrib/babel/intro.html on 2012-01-10
