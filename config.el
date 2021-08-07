(setq user-full-name "Eoin Carney"
      user-mail-address "eoin@spool-five.com")

(setq doom-font (font-spec :family "FiraMono Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "Source Sans Variable" :size 24))

;; (setq doom-theme 'doom-miramare)
(setq doom-theme 'doom-one)

(setq doom-modeline-enable-word-count t)

(setq display-line-numbers-type 'relative)

(doom/set-frame-opacity 90)

(setq gnutls-verify-error 'nil)

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(define-key evil-normal-state-map (kbd "J") 'evil-next-visual-line)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(setq browse-url-generic-program "/usr/bin/qutebrowser")
(setq browse-url-browser-function 'browse-url-generic)

(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

(add-to-list 'org-modules 'org-id)

(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git" projectile-project-root-files-bottom-up)))

(add-to-list 'auto-mode-alist '("\\.gmi\\'" . markdown-mode))

(setq org-ref-default-bibliography
      '("~/sci/lib.bib"))
(setq bibtex-completion-bibliography
      '("~/sci/lib.bib"))
(setq org-roam-completion-everywhere t)

(setq org-directory "~/sci/"
      org-roam-directory (concat org-directory "notes/"))

(customize-set-variable 'org-capture-templates '(
      ("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox")
       "* TODO %?\n%i\n%a" :prepend t)
      ("n" "Personal notes" entry (file+headline +org-capture-notes-file "Inbox")
       "* %u %?\n%i\n%a" :prepend t)
      ("j" "Journal" entry (file+olp+datetree +org-capture-journal-file)
       "* %U %?\n%i\n%a" :prepend t)
      ("i" "Blog Idea" entry (id "9d9237c9-e79c-465b-9c10-2d75b6b4fdb0")
       "* IDEA %u %?\n%i" :prepend t)
      ("f" "Fiction Idea" entry (id "8a5272ce-9e99-4786-b645-942c942031c8")
       "* IDEA %u %?\n%i" :prepend t)))

(map!
 :m "<f5>" 'org-agenda-list
 :m "<f6>" (lambda() (interactive)(find-file "~/sci/todo.org"))
 :m "<f7>" '+calendar/open-calendar)

(require 'org-superstar)
        (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(after! org
(setq org-hidden-keywords '(title))
;; set basic title font
(set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
;; Low levels are unimportant => no scaling
(set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
(set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
(set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
(set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
(set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.02) ;\large
(set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.07) ;\Large
(set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.328) ;\LARGE
;; Only use the first 4 styles and do not cycle.
(setq org-cycle-level-faces nil)
(setq org-n-level-faces 4)
;; Document Title, (\huge)
(set-face-attribute 'org-document-title nil
                    :height 2.074
                    :foreground 'unspecified
                    :inherit 'org-level-8))
;; (after! org
;;   (set-face-attribute 'org-level-1 nil
;;                       :height 1.2)
;;   (set-face-attribute 'org-document-title nil
;;                       :height 1.5
;;                       :weight 'bold))

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)

(setq org-todo-keywords '((sequence "TODO(t)" "CONFIG(c)" "WAIT(w)" "IDEA(i)" "BLOG(b)" "READ(r)" "|" "DONE(d)" "CANCELLED(c)")))
(setq hl-todo-keyword-faces '(
        ("TODO" . "#ebdbb2")
        ("WAIT" . "#ebdbb2")
        ("BLOG" . "#689d6a")
        ("IDEA" . "#689d6a")
        ("READ" . "#689d6a")
        ("CONFIG" . "#689d6a")))

(use-package! org-roam
  :init
  (setq org-roam-v2-ack t)
  (setq org-roam-graph-viewer "/usr/bin/qutebrowser")
  :config
  (org-roam-setup))

(map! :map org-roam-mode-map
      :leader
      :m "r r" 'org-roam-node-find
      :m "r i" 'org-roam-node-insert
      :m "r b" 'org-roam-buffer-toggle
      :m "r t" 'org-roam-tag-add
      :m "r c" 'orb-insert-link)

(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-side-window)
               (side . right)
               (slot . 0)
               (window-width . 0.33)
               (window-parameters . ((no-other-window . t)
                                     (no-delete-other-windows . t)))))

(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :if-new (file+head "%<%Y%m%d>-${slug}.org"
                              "#+title: ${title}\n#+created: %u\n#+filetags: %^G\n\n")
           :unnarrowed t
           :jump-to-captured t)
          ("q" "quick" plain "%?"
           :if-new (file+head "%<%Y%m%d>-${slug}.org"
                              "#+title: ${title}\n#+created: %u\n#+filetags: %^{org-file-tags}\n\n")
           :unnarrowed t))))
;; (after! org-roam
;;   (setq org-roam-capture-templates
;;         '(("d" "default" plain (function org-roam--capture-get-point)
;;            "%?"
;;            :file-name "${slug}"
;;            :head "#+TITLE: ${title}\n#+CREATED: %u\n#+ROAM_TAGS:%^{org-roam-tags}\n\n* ${title}\n"
;;            :unnarrowed t
;;            :jump-to-captured t)
;;           ("q" "quicklink" plain (function org-roam--capture-get-point)
;;            "%?"
;;            :file-name "${slug}"
;;            :head "#+TITLE: ${title}\n#+CREATED: %u\n#+ROAM_TAGS:%^{org-roam-tags}\n\n* ${title}\n"
;;            :unnarrowed t))))
;;         ;; ("l" "clipboard" plain (function org-roam--capture-get-point)
;;         ;;    "%i%a"
;;         ;;    :file-name "${slug}"
;;         ;;    :head "#+TITLE: ${title}\n#+CREATED: %u\n#+Modified: %U\n#+ROAM_TAGS:%^{org-roam-tags}\n\n* ${title}\n"
;;         ;;    :unnarrowed t
;;         ;;    :prepend t
;;         ;;    :jump-to-captured t)

(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  ;; the below hook affects startup time. Could choose an alternative later...
  ;; :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t))

(setq deft-extensions '("txt" "tex" "org" "md")
      deft-directory "~/sci/notes"
      deft-recursive t
      deft-use-filename-as-title t)

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

(after! evil
  (evil-add-command-properties 'org-export-dispatch :repeat nil)
  (evil-add-command-properties 'org-latex-export-to-pdf :repeat nil))

;; (setq +zen-text-scale 0.8)
(map! :leader
    :m "Z" 'display-fill-column-indicator-mode
    :m "z" 'display-line-numbers-mode)

(defcustom centered-point-position 0.35
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
(add-hook 'writeroom-mode-hook 'centered-point-mode)
(add-hook 'olivetti-mode-on-hook 'centered-point-mode)

(map! :leader
      :m "t o" 'olivetti-mode)
