;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)
(package! org-roam-server)

(package! org)

(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))

;; When using org-roam via the `+roam` flag
(unpin! org-roam company-org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)

(package! org-journal)
(package! org-kanban
  :recipe (:host github :repo "gizmomogwai/org-kanban"))
(package! org-pdftools
  :recipe (:host github :repo "fuxialexander/org-pdftools"))
(package! org-ref
  :recipe (:host github :repo "jkitchin/org-ref"))
(package! org-noter
  :recipe (:host github :repo "weirdNox/org-noter"))
(package! org-noter-pdftools
  :recipe (:host github :repo "fuxialexander/org-pdftools"))
(package! emacs-application-framework
  :recipe (:host github :repo "manateelazycat/emacs-application-framework"
           :files ("eaf.el" "src/lisp/*.el")))
(when (package! eaf :recipe (:host github
                             :repo "manateelazycat/emacs-application-framework"
                             :files ("*.el" "*.py" "app" "core")
                             :build (:not compile)))

  (package! ctable :recipe (:host github :repo "kiwanami/emacs-ctable"))
  (package! deferred :recipe (:host github :repo "kiwanami/emacs-deferred"))
  (package! epc :recipe (:host github :repo "kiwanami/emacs-epc")))


(package! org-bullets)
(package! codeium :recipe (:host github :repo "Exafunction/codeium.el"))
(package! helm)
;; (package! company-tabnine)
(package! ggtags)
(package! helm-gtags)
(package! org-auto-tangle)
(package! emojify)
;; (package! codeium :recipe (:host github :repo "Exafunction/codeium.el"))
(package! beacon)
(package! flycheck-aspell)
(package! flycheck-languagetool)
(package! ivy-posframe)
(package! fzf)
(package! forge)
(package! magit)
;; (package! forge :pin "ce212f8")
;; (package! magit :pin "30b0deb")
(package! sqlite3)
;; (package! tabnine)
(package! dired-preview)
(package! peep-dired)
;; (package! flycheck-languagetool)
(package! languagetool)
(package! impatient-mode)
(package! org-superstar)
(package! org-super-agenda)
(package! plantuml-mode)
(package! org-fancy-priorities)
(package! org-dashboard)
(package! org-appear)
(package! org-pretty-tags)
;; (package! cfw)
;; (package! emacs-dashboard)
(package! ivy-emoji)
(package! chatgpt-shell)
(package! dall-e-shell)
(package! org-ai)
