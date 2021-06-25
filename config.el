(setq user-full-name "Eoin Carney"
      user-mail-address "eoin@spool-five.com")

(setq doom-font (font-spec :family "Source Code Pro" :size 20)
      doom-variable-pitch-font (font-spec :family "Source Sans Variable" :size 20))

(setq doom-theme 'doom-miramare)

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

(setq org-directory "~/sci/"
      org-roam-directory (concat org-directory "notes/"))

(require 'org-superstar)
        (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(after! org
  (set-face-attribute 'org-level-1 nil
                      :height 1.2)
  (set-face-attribute 'org-document-title nil
                      :height 1.5
                      :weight 'bold))

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode #'visual-fill-column-mode)

(setq org-todo-keywords '((sequence "TODO(t)" "PROG(p)" "WAIT(w)" "IDEA(i)" "BLOG(b)" "|" "DONE(d)" "CANCELLED(c)")))

;; (map! :leader "n r B" '#org-roam-buffer-toggle-display)
(map! :map org-roam-mode-map
      :m "C-h /" 'org-roam-find-file
      :m "C-h i" 'org-roam-insert
      :m "C-h I" 'org-roam-insert-immediate
      :m "C-h c" 'org-roam-capture
      :m "C-h b" 'org-roam-buffer-toggle-display
      :m "C-h u" 'org-roam-db-build-cache
      :m "C-h t" 'org-roam-tag-add)

(after! org-roam
  (set-face-attribute 'org-roam-link nil :foreground "#458588"))

(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "${slug}"
           :head "#+TITLE: ${title}\n#+CREATED: %u\n#+Modified: %U\n#+ROAM_TAGS:%^{org-roam-tags}\n\n* ${title}\n"
           :unnarrowed t
           :jump-to-captured t)
        ("l" "clipboard" plain (function org-roam--capture-get-point)
           "%i%a"
           :file-name "${slug}"
           :head "#+TITLE: ${title}\n#+CREATED: %u\n#+Modified: %U\n#+ROAM_TAGS:%^{org-roam-tags}\n\n* ${title}\n"
           :unnarrowed t
           :prepend t
           :jump-to-captured t))))

(use-package! org-roam-server
  :after org-roam
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref))

(setq deft-extensions '("txt" "tex" "org" "md")
      deft-directory "~/sci/notes"
      deft-recursive t)

(setq-default elfeed-search-filter "@1-week-ago +unread ")
(use-package! elfeed-org
  :after elfeed
  :init
  (setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org")))

;; (require 'elfeed-org)
;;          (elfeed-org)
;;          (setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))

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

;; (defun write-hook ()
;;   (centered-point-mode)
;;   (doom/set-frame-opacity 100)
;;   (visual-line-mode)
;;   (setq display-fill-column-indicator nil
;;         display-line-numbers nil))
;; (add-hook 'writeroom-mode-hook 'write-hook)
;; (add-hook 'text-mode-hook 'set-fill-column 67)
