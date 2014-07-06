;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

(require 'cl)

(defun tnoda/find-brew-cask-prefix
  ()
  (with-current-buffer (get-buffer-create "*brew-cask-prefix")
    (erase-buffer)
    (if (zerop (call-process "brew" nil t nil "--prefix" "cask"))
        (buffer-substring (point-min) (1- (point-max))))))

(defconst tnoda/cask-el-path
  (let ((prefix (tnoda/find-brew-cask-prefix)))
    (if prefix
        (expand-file-name "cask.el" prefix))))


(require 'cask tnoda/cask-el-path)
(cask-initialize)

(add-to-list 'Info-directory-list (cask-resource-path "org-plus-contrib"))

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(defconst tnoda/dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(require 'org)
(require 'ob-tangle)

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files tnoda/dotfiles-dir t "\\.org$"))

;;; init.el ends here

;;; Originally retrieved from http://orgmode.org/worg/org-contrib/babel/intro.html on 2012-01-10
