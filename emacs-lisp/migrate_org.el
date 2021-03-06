#!/bin/sh
":"; exec emacs --quick --script "$0" -- "$@" # -*- mode: emacs-lisp -*-
(pop argv)
(setq debug-on-error t)

(defvar this-dir (concat (expand-file-name default-directory)))
(defvar org-proj-name "org")

(require 'ox-publish)
(setq org-publish-project-alist
      (list
       (org-proj-name
        :base-directory (concat this-dir "org")
        :base-extension "org"
        :publishing-directory (concat this-dir "_posts")
        :recursive t
        :publishing-function org-html-publish-to-html)))

(org-publish-project org-proj-name t)

(message "%s" "Done. Goodbye!")
(kill-emacs 0)
