(setq user-full-name "Eoin Carney"
      user-mail-address "eoincarney0@gmail.com")

(setq doom-font
    (font-spec :family "FuraMono Nerd Font" :size 16)
    ;; (font-spec :family "FuraMono Nerd Font" :size 16)
    mixed-pitch-set-height 20
    doom-variable-pitch-font (font-spec :family "ETBembo" :size 20))
;; (set-default line-spacing 0.3)

(setq doom-theme 'doom-one)
(add-to-list 'load-path "/home/eoin/.emacs.d/themes/ef-themes")
(require 'ef-themes)

(defun doom-dashboard-draw-ascii-emacs-banner-fn ()
    (let* ((banner
    '(" Y88b      /     "
    "  Y88b    /      "
    "   Y88b  /       "
    "    Y888/        "
    "     Y8/         "
    "      Y          "))

    (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
    (point)
    (dolist (line banner (point))
    (insert (+doom-dashboard--center
    +doom-dashboard--width
    (concat
    line (make-string (max 0 (- longest-line (length line)))
    32)))
    "\n"))
    'face 'doom-dashboard-banner)))

;; (unless (display-graphic-p) ; for some reason this messes up the graphical splash screen atm
    (setq +doom-dashboard-ascii-banner-fn #'doom-dashboard-draw-ascii-emacs-banner-fn)

(custom-set-faces!
    '(doom-dashboard-banner :foreground "slategray"))

;; (setq doom-modeline-enable-word-count t)
(display-time-mode 1)
(add-to-list 'default-frame-alist '(alpha . 90))
(setq display-line-numbers-type 'relative
    scroll-margin 5)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;; (add-to-list 'auto-mode-alist '("\\.gmi\\'" . markdown-mode))
(add-hook! markdown-mode 'mixed-pitch-mode)
(map! :n "SPC o t" 'eshell)
(super-save-mode 1)
(setq super-save-when-idle t)
(setq display-line-numbers-type nil)

(require 'epa-file)
(epa-file-enable)
(setq epa-pinentry-mode 'loopback)
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)

(setq evil-vsplit-window-right t
    evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
    :after '(evil-window-split evil-window-vsplit)
    (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(setq browse-url-generic-program "/usr/bin/qutebrowser")
(setq browse-url-browser-function 'browse-url-generic)
(setq elpher-start-page-url "gemini://warmedal.se/~antenna/")

(setq org-directory "~/Dropbox/sci/"
    org-roam-directory (concat org-directory "notes/")
    bibtex-completion-bibliography (concat org-directory "lib.bib"))
(after! org
  (setq org-agenda-files (append (directory-files-recursively (concat org-directory "act/") "\\.org$")
                                 (directory-files-recursively (concat org-directory "notes/rafts/") "\\notes.org$"))))

(append '(1 2 3) '(4 5 6))
(add-to-list 'org-modules 'org-id)
(require 'ox-gemini)
(require 'ox-hugo)

(map!
    :n "<f5>" 'org-agenda
    :n "<f6>" (lambda() (interactive)(find-file (concat org-directory "act/inbox.org")))
    :n "<f7>" (lambda() (interactive)(find-file (concat org-directory "act/projects.org")))
    :n "<f8>" (lambda() (interactive)(find-file (concat org-directory "act/actions.org")))
    :n "<f9>" (lambda() (interactive)(find-file (concat org-directory "act/archive.org"))))

(after! org
    (setq org-todo-keywords
    '((sequence
    "TODO(o)"
    "TT(t)"
    "PROJ(p)"
    "NEXT(n)"
    "PROG(i!/!)"
    "WAIT(w)"
    "SOMEDAY(s)"
    "RLX(r)"
    "STUCK(x)"
    "BUY(b)"
    "|"
    "DONE(d!/!)"
    "CANCELLED(c!/!)"))))

(setq gtd/next-action-head "Next actions"
    gtd/waiting-head "Waiting on"
    gtd/project-head "Projects"
    gtd/shop-head "Shopping"
    gtd/someday-head "Someday/maybe")

(setq org-agenda-custom-commands
    '(
    ("g" "GTD view"
    (
    (todo "TT" ((org-agenda-overriding-header gtd/next-action-head)))
    (agenda "" ((org-agenda-span 'day)
    (org-agenda-start-day 'nil))) ;; this is needed because doom starts agenda with day set to -3d
    (todo "PROJ" ((org-agenda-overriding-header gtd/project-head)))
    (todo "WAIT" ((org-agenda-overriding-header gtd/waiting-head)))
    (todo "BUY"  ((org-agenda-overriding-header gtd/shop-head)))
    (todo "SOMEDAY" ((org-agenda-overriding-header gtd/someday-head)))))))

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode #'org-superstar-mode #'org-pretty-table-mode #'org-appear-mode)

;; (add-hook! org-mode
;;     (setq org-hidden-keywords '(title))
;;     (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
;;     (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
;;     (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
;;     (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
;;     (set-face-attribute 'org-level-4 nil :inherit 'org-level-8 :height 1.02)
;;     (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.08)
;;     (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.12)
;;     (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.2)
;;     (set-face-attribute 'org-document-title nil :inherit 'org-level-8 :height 1.6 :foreground 'unspecified)
;;     (setq org-n-level-faces 4)
;;     (setq org-cycle-level-faces nil))
(add-hook! org-mode
           (setq org-hidden-keywords '(title))
           (custom-set-faces
            '(org-document-title ((t (:height 2.0))))
            '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
            '(org-level-2 ((t (:inherit outline-2 :height 1.12))))
            '(org-level-3 ((t (:inherit outline-3 :height 1.08))))
            '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
            '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
            ))

(after! org
    (setq org-superstar-headline-bullets-list '("◉" "○" "✹" "◦"))
    ;; Other bullets I liked: "❁" "❃" "✹" "✦" "❁" "◉" "○" "◦" "♠" "♥" "♦" "♣"
    (setq org-superstar-special-todo-items t)
    (setq org-superstar-todo-bullet-alist '(
    ("TODO" . 9744)
    ("TT"   . 9744)
    ("NEXT" . 9744)
    ("CONFIG" . 9744)
    ("DONE" . 9747)))
    (setq org-ellipsis " ▼")
    (setq org-list-demote-modify-bullet
    '(("+" . "*")("*" . "-")("-" . "+")))
    (setq org-todo-keyword-faces '(
    ("TODO" . "#b16286")
    ("TT"   . "#b16286")
    ("PROJ" . "#83a598")
    ("WAIT" . "#a89984")
    ("SOMEDAY" . "#8ec07c"))))

(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(customize-set-variable 'org-capture-templates '(
    ("t" "Task")
    ("tt" "TT" entry (id "cd9ffc7d-d197-4521-b74d-4b1f93b301ca")
    "* TT %?\n%i\n%a" :prepend t)
    ("ti" "Inbox (Store Link)" entry (id "84c646ea-11de-4593-99a5-39f3f8ead4ef")
    "* TODO %?\n%i\n%a" :prepend t)
    ("to" "Inbox (No Link)" entry (id "84c646ea-11de-4593-99a5-39f3f8ead4ef")
    "* TODO %?\n%i" :prepend t)
    ("p" "Project")
    ("pp" "Project" entry (id "a359813e-8bde-463d-8406-0d5fa76357dd")
    "* PROJ %?\n%i- [ ] Next Action:\n%a" :prepend t)
    ("pb" "Project (Blog)" entry (id "a359813e-8bde-463d-8406-0d5fa76357dd")
    "* PROJ %? :blog:\n%i- [ ] Next Action:\n%a" :prepend t)
    ("pf" "Project (Fiction)" entry (id "a359813e-8bde-463d-8406-0d5fa76357dd")
    "* PROJ %? :fiction:\n%i- [ ] Next Action:\n%a" :prepend t)
    ("pc" "Project (Config)" entry (id "a359813e-8bde-463d-8406-0d5fa76357dd")
    "* PROJ %? :config:\n%i- [ ] Next Action:\n%a" :prepend t)))

(after! org-roam
    (setq org-roam-capture-templates
    '(("d" "default" plain "#+created: %u\n#+filetags: %^G\n\n* ${title}\n%?"
    :target (file+head "rafts/%<%Y%m%d>-${slug}.org"
    "#+title: ${title}\n")
    :unnarrowed t
    :jump-to-captured t)
    ("e" "encrypted" plain "#+created: %u\n#+filetags: %^G\n\n* ${title}\n%?"
    :target (file+head "rafts/%<%Y%m%d>-${slug}.org.gpg"
    "#+title: ${title}\n")
    :unnarrowed t
    :jump-to-captured t)
    ("r" "reference" plain "#+created: %u\n#+filetags: ref: %^G\n\n* ${title}\n%?"
    :target (file+head "rafts/%<%Y%m%d>-${slug}.org"
    "#+title: ${title}\n")
    :unnarrowed t
    :jump-to-captured t)
    ("b" "box3" plain "#+created: %u\n#+filetags: :box3: %^G\n#+hugo_custom_front_matter: :layout note\n\n%?"
    :target (file+head "ref/org/%<%Y%m%d>-${slug}.org"
    "#+title: ${title}\n")
    :unnarrowed t )
    ("q" "quick" plain "#+created: %u\n#+filetags: %^G\n\n%?"
    :target (file+head "rafts/%<%Y%m%d>-${slug}.org"
    "#+title: ${title}\n")
    :unnarrowed t)))
    (setq org-roam-dailies-capture-templates
    '(("d" "default" entry "* %<%H:%M> -  [[id:477e986a-2fba-4982-8158-b309baf0b14b][%?]]"
    :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")))))

(defun my/org-roam-insert-no-capture ()
  (interactive)
  (let ((org-roam-capture-templates
         (mapcar
          #'(lambda (tmpl) (append tmpl '(:immediate-finish t)))
          org-roam-capture-templates)))
    (funcall-interactively 'org-roam-node-insert)))

;; (use-package! org-transclusion
;;               :after org
;;               :init
;;               (map!
;;                :map global-map "<f12>" #'org-transclusion-add
;;                :leader
;;                :prefix "n"
;;                :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ledger . t)))

;; New link type for Org-Hugo internal links
(defun md-hugo-insert-link ()
    "Create link with Hugo ref shortcode"
    (interactive)
    (insert (concat "[" (read-string "Text for link: ") "]" "\({{< ref \"" (file-relative-name (read-file-name "File: ")) "\" >}}\)")))

(map! :map markdown-mode-map
    :leader
    :desc "Insert Hugo Link"         "m l"     'md-hugo-insert-link)

(use-package! org-roam
    :defer t
    :init
    (setq org-roam-v2-ack t)
    (setq org-roam-graph-viewer "/usr/bin/qutebrowser")
    :config
    (org-roam-setup))
(setq org-roam-completion-everywhere t)

(setq org-roam-mode-sections
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            #'org-roam-unlinked-references-section
            ))
;; (add-hook! 'org-roam-mode-hook (add-to-list 'display-buffer-alist
;;              '("\\*org-roam\\*"
;;                (display-buffer-in-direction)
;;                (direction . right)
;;                (window-width . 0.33)
;;                (window-height . fit-window-to-buffer))))
(add-hook! 'org-roam-mode-hook (add-to-list 'display-buffer-alist
    '("\\*org-roam\\*"
    (display-buffer-in-side-window)
    (side . right)
    (slot . 0)
    (window-width . 0.25)
    (window-parameters . ((no-other-window . t)
    (no-delete-other-windows . t))))))

(map! :map org-roam-mode-map
    :leader
    :prefix "r"
    :desc "Find Note"         "r"     'org-roam-node-find
    :desc "Insert Note"       "i"     'org-roam-node-insert
    :desc "Insert immediate"  "m"     'my/org-roam-insert-no-capture
    :desc "Toggle Buffer"     "b"     'org-roam-buffer-toggle
    :desc "Add Tag"           "t"     'org-roam-tag-add
    :desc "Bibtex Link"       "c"     'orb-insert-link)
(map! :map org-roam-mode-map
    :leader
    :prefix "r d"
    :desc "Daily Capture"     "c"     'org-roam-dailies-capture-today
    :desc "Daily Find"        "f"     'org-roam-dailies-find-directory
    :desc "Daily Today"       "t"     'org-roam-dailies-find-today
    :desc "Daily Date"        "d"     'org-roam-dailies-goto-date)

(setq org-roam-node-display-template "${title:*} ${tags:30}") ;the format here is $(field-name:length). Including the 'length' integer causes the alignment of the tags to the right, ommitting it leaves them on the left.

(use-package! org-roam-bibtex
    :after org-roam
    :hook (org-roam-mode . org-roam-bibtex-mode)
    :config
    (require 'org-ref))

(use-package! websocket
    :after org-roam)
(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
    org-roam-ui-follow t
    org-roam-ui-update-on-save t))

(setq-default elfeed-search-filter "@1-week-ago +unread ")
(use-package! elfeed-org
    :after elfeed
    :init
    (setq rmh-elfeed-org-files (list "~/.config/doom/elfeed.org")))
(require 'elfeed-goodies)
    (elfeed-goodies/setup)
    (setq elfeed-goodies/entry-pane-size 0.7)

(setq +org-capture-emails-file (concat org-directory "act/inbox.org"))
(after! mu4e
  (setq mu4e-get-mail-command "offlineimap")
  (setq mu4e-update-interval 300)
  (setq mail-user-agent 'mu4e-user-agent)

  (setq mu4e-sent-folder "/[Gmail].Sent Mail")
  (setq mu4e-drafts-folder "/[Gmail].Drafts")
  (setq mu4e-trash-folder "/[Gmail].Bin")
  (setq mu4e-maildir-shortcuts
        '((:maildir "/INBOX" :key ?i)))
  (setq user-mail-address "eoincarney0@gmail.com"
        user-full-name "Eoin Carney")
  (setq sendmail-program "/usr/bin/msmtp"
        send-mail-function 'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function 'message-send-mail-with-sendmail))

(defun tildechat ()
    (interactive)
    (erc-tls :server "irc.tilde.chat"
    :port 6697
    :nick "eoin"
    :full-name "eoin carney"
    :client-certificate
    '("/home/eoin/.local/share/certs/erc.key"
    "/home/eoin/.local/share/certs/erc.crt")))
(defun liberachat ()
    (interactive)
    (erc-tls :server "irc.libera.chat"
    :port 6697
    :nick "loopdreams"
    :full-name "loopdreams"
    :client-certificate
    '("/home/eoin/.local/share/certs/erc.key"
    "/home/eoin/.local/share/certs/erc.crt")))

(defun ledger-clean-and-save ()
  (interactive)
  (ledger-mode-clean-buffer)
  (save-buffer))
(map! :localleader
      (:map ledger-mode-map
      "c" #'ledger-clean-and-save))
(add-to-list 'auto-mode-alist '("\\.dat\\'" . ledger-mode))

(set-file-template! "\\.html$" :trigger "__spoolfive.html" :mode 'web-mode)

(defcustom centered-point-position 0.45
    "Percentage of screen where `centered-point-mode' keeps point."
    :type 'float)

(setq centered-point--preserve-pos nil)

(define-minor-mode centered-point-mode
    "Keep the cursor at `centered-point-position' in the window"
    :lighter " centerpoint"
    (cond (centered-point-mode (add-hook 'post-command-hook 'center-point nil t)
    (setq centered-point--preserve-pos
    scroll-preserve-screen-position)
    (setq-local scroll-preserve-screen-position 'all))
    (t (remove-hook 'post-command-hook 'center-point t)
    (setq-local scroll-preserve-screen-position
    centered-point--preserve-pos))))

(defun center-point ()
    "Move point to the line at `centered-point-position'."
    (interactive)
    (when (eq (current-buffer) (window-buffer))
    (let ((recenter-positions (list centered-point-position)))
    (recenter-top-bottom))))

(defun centered-point-mode-on ()
    (centered-point-mode 1))

(define-globalized-minor-mode global-centered-point-mode centered-point-mode
    centered-point-mode-on)

(map! :leader
    "Z" 'display-fill-column-indicator-mode
    "z" 'display-line-numbers-mode
    "t o" 'olivetti-mode)

;; (add-hook! (writeroom-mode olivetti-mode) 'centered-point-mode-on)
;; (add-hook! 'writeroom-mode-enable-hook '(lambda () (display-line-numbers-mode -1)))
(remove-hook! (writeroom-mode) #'+zen-enable-mixed-pitch-mode-h) ;; added this since mixed-pitch is defaul on most 'writing' files (org, md). Otherwise, when exiting writeroom mode, font switched back to fixed-pitch

(flycheck-define-checker vale
    "A checker for prose"
    :command ("vale" "--output" "line"
    source)
    :standard-input nil
    :error-patterns
    ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
    :modes (markdown-mode)
    )
(add-to-list 'flycheck-checkers 'vale 'append)
(setq flycheck-checker-error-threshold 2000)
(global-flycheck-mode -1)

(add-hook! (gemini-mode) #'mixed-pitch-mode)

(defun my/writing ()
  (interactive)
  (setq org-hidden-keywords '(title))
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8 :height 1.02)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.08)
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.12)
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.2)
  (set-face-attribute 'org-document-title nil :inherit 'org-level-8 :height 1.6 :foreground 'unspecified)
  (setq org-n-level-faces 4)
  (setq org-cycle-level-faces nil))

(defun my/edit ()
  (interactive)
  (call-interactively #'org-wc-display)
;; set up flycheck vale to only start here
                )

(add-hook! conf-xdefaults-mode
  (setq comment-start "/* "
        comment-end "*/"))
