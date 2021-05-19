;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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

(setq doom-font (font-spec :family "Source Code Pro" :size 20)
      doom-big-font (font-spec :family "Source Code Pro" :size 36)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 20)
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-theme 'doom-miramare)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")
(setq display-line-numbers-type 'relative)

(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; for  browsing gemini in elpher...
(setq gnutls-verify-error 'nil)

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

;; preview window split
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
; buffer preview
(setq +ivy-buffer-preview t)

(setq-default major-mode 'org-mode)


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

(require 'elfeed-org)
         (elfeed-org)
         (setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))


(require 'elfeed-goodies)
        (elfeed-goodies/setup)
        (setq elfeed-goodies/entry-pane-size 0.7)

;; Set it so that you can markup /within/ words. For example /in/human...
;; (setcar org-emphasis-regexp-components " \t('\"{[:alpha:]")
;; (setcar (nthcdr 1 org-emphasis-regexp-components) "[:alpha:]- \t.,:!?;'\")}\\")
;; (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)

;; Use Msmtp to send mail
(setq sendmail-program "/usr/bin/msmtp"
      send-mail-function 'smtpmail-send-it
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-send-mail-function 'message-send-mail-with-sendmail)

;; For crashes:
(after! evil
  (evil-add-command-properties 'org-export-dispatch :repeat nil)
  (evil-add-command-properties 'org-latex-export-to-pdf :repeat nil))

;; trying to figure out some 'writerroom' stuff...
(setq +zen-text-scale 0.8)

(use-package emacs
  :config
  (setq-default scroll-preserve-screen-position t)
  (setq-default scroll-conservatively 1) ; affects `scroll-step'
  (setq-default scroll-margin 0)

  (define-minor-mode scroll-centre-cursor-mode
    "Toggle centred cursor scrolling behaviour."
    :init-value nil
    :lighter " S="
    :global nil
    (if scroll-centre-cursor-mode
        (setq-local scroll-margin (* (frame-height) 2)
                    scroll-conservatively 0
                    maximum-scroll-margin 0.5)
      (dolist (local '(scroll-preserve-screen-position
                       scroll-conservatively
                       maximum-scroll-margin
                       scroll-margin))
        (kill-local-variable `,local))))
  ;; C-c l is used for `org-store-link'.  The mnemonic for this is to
  ;; focus the Line and also works as a variant of C-l.
  :bind ("C-c L" . scroll-centre-cursor-mode))


(add-hook 'writeroom-mode-hook 'scroll-centre-cursor-mode )
