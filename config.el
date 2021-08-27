(setq user-full-name "Eoin Carney"
      user-mail-address "eoin@spool-five.com")

(setq doom-font (font-spec :family "FiraMono Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "Source Sans Variable" :size 22)
      mixed-pitch-set-height 22)

;; (setq doom-theme 'doom-miramare)
(setq doom-theme 'doom-one)

(setq doom-modeline-enable-word-count t)
(display-time-mode 1)
(doom/set-frame-opacity 90)
(setq display-line-numbers-type 'relative
      scroll-margin 2)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

(add-to-list 'auto-mode-alist '("\\.gmi\\'" . markdown-mode))
(add-hook! markdown-mode 'mixed-pitch-mode)

;; (unless (string-match-p "^Power N/A" (battery))
;;   (display-battery-mode 1))
(setq elpher-start-page-url "gemini://spool-five.com/feed/feed.gmi")

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(setq browse-url-generic-program "/usr/bin/qutebrowser")
(setq browse-url-browser-function 'browse-url-generic)
(setq gnutls-verify-error 'nil)

(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git" projectile-project-root-files-bottom-up)))

 (setq org-directory "~/sci/"
       org-roam-directory (concat org-directory "notes/")
       org-ref-default-bibliography "~/sci/lib.bib"
       bibtex-completion-bibliography "~/sci/lib.bib")

(setq org-roam-completion-everywhere t)

(add-to-list 'org-modules 'org-id)

(map!
 :n "<f5>" 'org-agenda-list
 :n "<f6>" (lambda() (interactive)(find-file "~/sci/todo.org"))
 :n "<f7>" '+calendar/open-calendar)

(after! org
        (setq org-todo-keywords '((sequence "TODO(t)" "CONFIG(c)" "WAIT(w)" "IDEA(i)" "BLOG(b)" "READ(r)" "|" "DONE(d)" "CANCELLED(n)")))
        ;; (setq org-superstar-headline-bullets-list '("❁" "❃" "✹" "✦"))
        (setq org-superstar-headline-bullets-list '("❁" "◉" "○" "◦"))
        ;; (setq org-superstar-headline-bullets-list '("♠" "♥" "♦" "♣"))
        (setq org-superstar-special-todo-items t)
        ;; (setq org-superstar-cycle-headline-bullets nil)
        (setq org-superstar-todo-bullet-alist '(
                                                ("TODO" . 9744)
                                                ("CONFIG" . 9744)
                                                ("DONE" . 9745)))
        (setq org-todo-keyword-faces '(
                                       ("TODO" . "#b16286")
                                       ("CONFIG" . "#83a598")
                                       ("WAIT" . "#a89984")
                                       ("IDEA" . "#8ec07c")
                                       ("BLOG" . "#8ec07c")
                                       ("READ" . "#458588"))))

(setq org-agenda-custom-commands
      '(("n" . "Custom Menu")
        ("nr" "Roam Todos" tags-todo "roam")
        ("nc" "Config" tags-todo "config")
        ("nf" "Fiction" tags-todo "fiction")
        ("N" "Custom Menu Block"
         ((tags-todo "general")
          (tags-todo "roam")
          (tags-todo "config")
          (tags-todo "fiction"))
         nil
          ("~/next-actions.html")) ;; exports block to this file with C-c a e
       ;; ..other commands here
        ))

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

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode #'org-superstar-mode)

(customize-set-variable 'org-capture-templates '(
      ("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox")
       "* TODO %?\n%i\n%a" :prepend t)
      ("r" "Roam Todo" entry (id "0a6e0e8a-c2e2-4d6d-ba85-066645c087ef")
       "* TODO %?\n%i\n%a" :prepend t)
      ("j" "Journal" entry (file+olp+datetree +org-capture-journal-file)
       "* %U %?\n%i\n%a" :prepend t)
      ("c" "Config Todo" entry (id "05774d4c-565c-4cd8-8f32-ccefe997a75a")
       "* CONFIG %?\n%i\n%a" :prepend t)
      ("n" "Personal notes" entry (file+headline +org-capture-notes-file "Inbox")
       "* %u %?\n%i\n%a" :prepend t)
      ("i" "Blog Idea" entry (id "9d9237c9-e79c-465b-9c10-2d75b6b4fdb0")
       "* IDEA %u %?\n%i" :prepend t)
      ("f" "Fiction Idea" entry (id "8a5272ce-9e99-4786-b645-942c942031c8")
       "* IDEA %u %?\n%i" :prepend t)))
(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain "#+created: %u\n#+filetags: %^G\n\n* ${title}\n%?"
           :if-new (file+head "%<%Y%m%d>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t
           :jump-to-captured t)
          ("q" "quick" plain "#+created: %u\n#+filetags: %^G\n\n%?"
           :if-new (file+head "%<%Y%m%d>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("p" "python" plain "#+created: %u\n#+filetags: python\n[[id:65c3183f-70ff-4d85-a7fc-e6cd54b35306][python]]\n\n%?"
           :if-new (file+head "python-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("w" "witness" plain "#+created: %u\n#+filetags: %^G\n\n%?"
           :if-new (file+head "witness_${slug}.org"
                              "#+title: ${title}\n")
           :jump-to-captured t
           :unnarrowed t)
          ("b" "bridge" plain "#+filetags: bridge\n\n* Question :drill:\n%?\n** Answer"
           :if-new (file+head "bridge/${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("t" "test" plain (file "~/sci/notes/templates/test.org")
           :if-new (file+head "%<%Y%m%d>-${slug}.org"
                              "#+title: ${title}\n")
            :unnarrowed t)))
    (setq org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%H:%M> - %?"
            :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n [[id:477e986a-2fba-4982-8158-b309baf0b14b][Daily]]")))))

(use-package! org-roam
  :init
  (setq org-roam-v2-ack t)
  (setq org-roam-graph-viewer "/usr/bin/qutebrowser")
  :config
  (add-to-list 'display-buffer-alist
                '("\\*org-roam\\*"
                (display-buffer-in-side-window)
                (side . right)
                (slot . 0)
                (window-width . 0.33)
                (window-parameters . ((no-other-window . t)
                                        (no-delete-other-windows . t)))))
  (org-roam-setup))

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



(setq org-roam-node-display-template "${title} ${tags}")

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

(setq sendmail-program "/usr/bin/msmtp"
      send-mail-function 'smtpmail-send-it
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-send-mail-function 'message-send-mail-with-sendmail)

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

(add-hook! (writeroom-mode olivetti-mode) 'centered-point-mode-on)
(remove-hook! (writeroom-mode) #'+zen-enable-mixed-pitch-mode-h) ;; added this since mixed-pitch is defaul on most 'writing' files (org, md). Otherwise, when exiting writeroom mode, font switched back to fixed-pitch
