(setq user-full-name "Eoin Carney"
      user-mail-address "eoin@spool-five.com")

(setq doom-font (font-spec :family "Source Code Pro" :size 20)
      doom-variable-pitch-font (font-spec :family "Source Sans Variable"))

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

(custom-set-variables
 '(org-directory "~/sci")
 '(org-agenda-files (list org-directory)))
(require 'org-superstar)
        (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(require 'elfeed-org)
         (elfeed-org)
         (setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))


(require 'elfeed-goodies)
        (elfeed-goodies/setup)
        (setq elfeed-goodies/entry-pane-size 0.7)

(use-package dashboard
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Box Three Spool Five")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.doom.d/splashimg.png")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 5)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
			      (bookmarks . "book"))))

(setq doom-fallback-buffer "*dashboard*")

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
