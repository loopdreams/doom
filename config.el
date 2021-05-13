;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Eoin Carney"
      user-mail-address "eoin@spool-five.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "FiraMono Nerd Font Mono" :size 16))
(setq doom-variable-pitch-font (font-spec :family "Latin Modern Sans" :size 16))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-miramare)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
        ;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (use-package org-bullets)
;;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; (Use-package writeroom-mode)
;; (use-package pandoc-mode

(setq gnutls-verify-error 'nil)

(require 'org-superstar)
        (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(use-package dashboard
        :init      ;; tweak dashboard config before loading it
        (setq dashboard-set-heading-icons t)
        (setq dashboard-set-file-icons t)
        (setq dashboard-banner-logo-title "Box Three Spool Five")
        ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
        (setq dashboard-startup-banner "~/splashimg.png")  ;; use custom image as banner
        (setq dashboard-center-content nil) ;; set to 't' for centered content
        (setq dashboard-items '((recents . 5)
                                (agenda . 5 )
                                (bookmarks . 5)
                                (projects . 4)))
        :config
        (dashboard-setup-startup-hook)
        (dashboard-modify-heading-icons '((recents . "file-text")
                                        (bookmarks . "book"))))

;; ;; (add-hook 'elfeed-show-mode-hook 'visual-line-mode)
;; (evil-define-key 'normal elfeed-show-mode-map
;;   (kbd "J") 'elfeed-goodies/split-show-next
;;   (kbd "K") 'elfeed-goodies/split-show-prev)
;; (evil-define-key 'normal elfeed-search-mode-map
;;   (kbd "J") 'elfeed-goodies/split-show-next
;;   (kbd "K") 'elfeed-goodies/split-show-prev)
;; ;; (setq elfeed-goodies/entry-pane-size 0.5)
;; Load elfeed-org
(require 'elfeed-org)
;; Initialize elfeed-org
;; This hooks up elfeed-org to read the configuration when elfeed
;; is started with =M-x elfeed=
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))


;; (setq elfeed-feeds
;;       '("https://pluralistic.net/feed/"
;;         "https://cosmic.voyage/rss.xml"
;;         "https://www.theatlantic.com/feed/best-of/"
;;         "https://davidmenestres.com/feed/podcast/"
;;         "https://feeds.feedburner.com/therestisnoise"
;;         "https://aeon.co/feed.rss"
;;         "https://inkdroid.org/feed.xml"
;;         "https://computer.rip/rss.xml"
;;         "https://www.3ammagazine.com/3am/feed/"
;;         "https://anneboyer.substack.com/feed"
;;         "https://sfj.substack.com/feed music"
;;         "https://network23.org/ainriail/feed/"
;;         "https://www.jamesrwilliams.net/feed/"
;;         "https://videos.lukesmith.xyz/feeds/videos.xml?accountId=3"
;;         "https://efforg.libsyn.com/rss"
;;         "https://www.jamesrwilliams.net/feed/"
;;         "https://cdn.jwz.org/blog/feed/"
;;         "http://ajroach42.com/feed.xml"
;;         "https://solar.lowtechmagazine.com/feeds/all-en.atom.xml"
;;         "https://100r.co/links/rss.xml"
;;         "https://feeds.feedburner.com/arstechnica/index/"
;;         "https://spool-five.com/rss.xml"))

(require 'elfeed-goodies)
        (elfeed-goodies/setup)
        (setq elfeed-goodies/entry-pane-size 0.7)

;; Set it so that you can markup /within/ words. For example /in/human...
;; (setcar org-emphasis-regexp-components " \t('\"{[:alpha:]")
;; (setcar (nthcdr 1 org-emphasis-regexp-components) "[:alpha:]- \t.,:!?;'\")}\\")
;; (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
