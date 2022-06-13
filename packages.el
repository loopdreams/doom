;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))
;; (package! another-package
;; :recipe (:host github :repo "sachac/artbollocks-mode"))


;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
;; (when (featurep! :lang org +roam2)
;;   (package! org-roam
;;     :recipe (:host github :repo "org-roam/org-roam"
;;              :files (:defaults "extensions/*")
;;              :build (:not compile))))
(package! org-roam)
;; (package! org :pin "73875939a8b5545ac53a86ec467239f510d14de8")
(package! org-superstar)
(package! org-appear)
(package! super-save)
(package! elfeed)
(package! elfeed-org)
(package! elpher)
(package! pandoc-mode)
(package! ox-reveal)
(package! olivetti)
(package! eww)
(package! dashboard)
(package! org-drill)
(package! simple-mpc)
(package! websocket)
(package! org-roam-ui
  :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
;; (package! gemini-mode)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
; this is recommended on the org-roam-bibtex github, not sure why
(unpin! org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)
(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table"))
(package! elfeed-goodies)
(package! helm-bibtex) ;this is the general name for both helm/ivy bibtex completion
(package! org-ref)
(package! ox-gemini)
(package! ox-rss)
(package! pass)
(package! ivy-posframe)
(package! org-modern
  :recipe (:host github :repo "minad/org-modern"))
(package! svg-lib)
(package! svg-tag-mode)
(package! mermaid-mode) ; for graphs
(package! gnuplot)
(package! gemini-mode
  :recipe (:host nil :repo "http://git.carcosa.net/jmcbray/gemini.el.git"))
(package! org-transclusion)
(package! ox-hugo)
(package! mw-thesaurus)
(package! org-wc)
