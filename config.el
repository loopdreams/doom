(setq user-full-name "Eoin Carney"
      user-mail-address "eoin@spool-five.com")

(setq doom-font (font-spec :family "GoMono Nerd Font" :size 16)
      ;; (font-spec :family "FuraMono Nerd Font" :size 16)
      ;; doom-font (font-spec :family "FiraMono Nerd Font" :size 22)
      ;; doom-variable-pitch-font (font-spec :family "Source Sans Variable" :size 22)
      doom-variable-pitch-font (font-spec :family "ETBembo" :size 20)
      ;; doom-variable-pitch-font (font-spec :family "Go" :size 24)
      mixed-pitch-set-height 20
      line-spacing 0.1)

;; (setq doom-theme 'doom-miramare)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-nord-light)
(setq doom-theme 'doom-gruvbox)

;; (setq doom-modeline-enable-word-count t)
(display-time-mode 1)
;; (doom/set-frame-opacity 90)
(setq display-line-numbers-type 'relative
      scroll-margin 5)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(add-to-list 'auto-mode-alist '("\\.gmi\\'" . markdown-mode))
(add-hook! markdown-mode 'mixed-pitch-mode)
;; (unless (string-match-p "^Power N/A" (battery))
;;   (display-battery-mode 1))
(setq elpher-start-page-url "gemini://spool-five.com/feed/feed.gmi")
(map! :n "SPC o t" 'eshell)

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(setq browse-url-generic-program "/usr/bin/qutebrowser")
(setq browse-url-browser-function 'browse-url-generic)
(setq gnutls-verify-error 'nil)

 (setq org-directory "~/Dropbox/sci/"
       org-roam-directory (concat org-directory "notes/")
       bibtex-completion-bibliography (concat org-directory "lib.bib"))

(setq org-roam-completion-everywhere t)

(add-to-list 'org-modules 'org-id)
(require 'ox-gemini)

(map!
 :n "<f5>" 'org-agenda
 :n "<f6>" (lambda() (interactive)(find-file (concat org-directory "todo.org")))
 :n "<f7>" (lambda() (interactive)(find-file (concat org-directory "notes/20211019-projects.org")))
 :n "<f8>" (lambda() (interactive)(find-file (concat org-directory "notes/20211019-actions.org")))
 :n "<f9>" '+calendar/open-calendar)

(after! org
        (setq org-todo-keywords
              '((sequence "TODO(t)"
                          "PROJ(p)"
                          "NEXT(n)"
                          "WAIT(w)"
                          "SOMEDAY(s)"
                          "RLX(r)"
                          "BRIDGE"
                          "STUCK(x)"
                          "BUY(b)"
                          "|"
                          "DONE(d)"
                          "CANCELLED(c)")))
        (setq org-superstar-headline-bullets-list '("❁" "❃" "✹" "✦"))
        ;; (setq org-superstar-headline-bullets-list '("❁" "◉" "○" "◦"))
        ;; (setq org-superstar-headline-bullets-list '(" "))
        ;; (setq org-superstar-headline-bullets-list '("♠" "♥" "♦" "♣"))
        (setq org-superstar-special-todo-items t)
        ;; (setq org-superstar-cycle-headline-bullets nil)
        (setq org-superstar-todo-bullet-alist '(
                                                ("TODO" . 9744)
                                                ("NEXT" . 9744)
                                                ("CONFIG" . 9744)
                                                ("DONE" . 9747)))
        (setq org-todo-keyword-faces '(
                                       ("TODO" . "#b16286")
                                       ("PROJ" . "#83a598")
                                       ("WAIT" . "#a89984")
                                       ("SOMEDAY" . "#8ec07c"))))

(setq gtd/next-action-head "Next actions:"
      gtd/waiting-head "Waiting on:"
      gtd/project-head "Projects:"
      gtd/shop-head "Shopping:"
      gtd/someday-head "Someday/maybe:")

(setq org-agenda-custom-commands
      '(
        ("g" "GTD view"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-start-day 'nil))) ;; this is needed because doom starts agenda with day set to -3d
          (todo "NEXT" ((org-agenda-overriding-header gtd/next-action-head)))
          (todo "WAIT" ((org-agenda-overriding-header gtd/waiting-head)))
          (todo "PROJ" ((org-agenda-overriding-header gtd/project-head)))
          (todo "BUY"  ((org-agenda-overriding-header gtd/shop-head)))
          (todo "SOMEDAY" ((org-agenda-overriding-header gtd/someday-head)))
        ))))

;; (setq org-agenda-custom-commands
;;       '(("n" . "Custom Menu")
;;         ("nr" "Roam Todos" tags-todo "roam")
;;         ("nc" "Config" tags-todo "config")
;;         ("nf" "Fiction" tags-todo "fiction")
;;         ("N" "Custom Menu Block"
;;          ((tags-todo "general")
;;           (tags-todo "roam")
;;           (tags-todo "config")
;;           (tags-todo "fiction"))
;;          nil
;;           ("~/next-actions.html")) ;; exports block to this file with C-c a e
;;        ;; ..other commands here
;;         ))

(add-hook! org-mode
  (setq org-hidden-keywords '(title))
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.02)
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.07)
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.258)
  (set-face-attribute 'org-document-title nil :inherit 'org-level-8 :height 2.01 :foreground 'unspecified)
  (setq org-n-level-faces 4)
  (setq org-cycle-level-faces nil))

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode #'org-superstar-mode #'org-pretty-table-mode)

(customize-set-variable 'org-capture-templates '(
      ("i" "Inbox (Store Link)" entry (file+headline +org-capture-todo-file "Inbox")
       "* TODO %?\n%i\n%a" :prepend t)
      ("o" "Inbox (No Link)" entry (file+headline +org-capture-todo-file "Inbox")
       "* TODO %?\n%i" :prepend t)
      ("a" "Next Action" entry (id "cd9ffc7d-d197-4521-b74d-4b1f93b301ca")
       "* NEXT %?\n%i\n%a" :prepend t)
      ("p" "Project" entry (id "1e3f82bc-4ed2-4db3-b1d9-0023663d6286")
       "* PROJ %?\n%i- [ ] Next Action:\n%a" :prepend t)
      ("b" "Project (Blog)" entry (id "1e3f82bc-4ed2-4db3-b1d9-0023663d6286")
       "* PROJ %? :blog:\n%i- [ ] Next Action:\n%a" :prepend t)
      ("f" "Project (Fiction)" entry (id "1e3f82bc-4ed2-4db3-b1d9-0023663d6286")
       "* PROJ %? :fiction:\n%i- [ ] Next Action:\n%a" :prepend t)
      ("c" "Project (Config)" entry (id "1e3f82bc-4ed2-4db3-b1d9-0023663d6286")
       "* PROJ %? :config:\n%i- [ ] Next Action:\n%a" :prepend t)))
(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain "#+created: %u\n#+filetags: %^G\n\n* ${title}\n%?"
           :target (file+head "%<%Y%m%d>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t
           :jump-to-captured t)
          ("q" "quick" plain "#+created: %u\n#+filetags: %^G\n\n%?"
           :target (file+head "%<%Y%m%d>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("p" "python" plain "#+created: %u\n#+filetags: python\n[[id:65c3183f-70ff-4d85-a7fc-e6cd54b35306][python]]\n\n%?"
           :target (file+head "python-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("w" "witness" plain "#+created: %u\n#+filetags: %^G\n\n%?"
           :target (file+head "witness_${slug}.org"
                              "#+title: ${title}\n")
           :jump-to-captured t
           :unnarrowed t)
          ("b" "bridge" plain "#+filetags: bridge\n\n* Question :drill:\n%?\n** Answer"
           :target (file+head "bridge/${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("t" "test" plain (file "~/sci/notes/templates/test.org")
           :target (file+head "%<%Y%m%d>-${slug}.org"
                              "#+title: ${title}\n")
            :unnarrowed t)))
    (setq org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%H:%M> - %?"
            :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n [[id:477e986a-2fba-4982-8158-b309baf0b14b][Daily]]")))))

(use-package! org-roam
  :init
  (setq org-roam-v2-ack t)
  (setq org-roam-graph-viewer "/usr/bin/qutebrowser")
  :config
  (org-roam-setup))

(add-hook! 'org-roam-mode-hook (add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-side-window)
               (side . right)
               (slot . 0)
               (window-width . 0.33)
               (window-parameters . ((no-other-window . t)
                                     (no-delete-other-windows . t))))))

(map! :map org-roam-mode-map
      :leader
      :prefix "r"
      :desc "Find Note"         "r"     'org-roam-node-find
      :desc "Insert Note"       "i"     'org-roam-node-insert
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
  (setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org")))

(require 'elfeed-goodies)
        (elfeed-goodies/setup)
        (setq elfeed-goodies/entry-pane-size 0.7)

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

(setq
 mu4e-get-mail-command "mbsync website"  ;; or fetchmail, or ...
 mu4e-update-interval 300
 mu4e-headers-auto-update t
 )
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp")
;; (setq sendmail-program "/usr/bin/msmtp"
;;       send-mail-function 'smtpmail-send-it
;;       message-sendmail-f-is-evil t
;;       message-sendmail-extra-arguments '("--read-envelope-from")
;;       message-send-mail-function 'message-send-mail-with-sendmail)

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
