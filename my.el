;;; my.el -*- lexical-binding: t; -*-

;;;  Disiplay related dailies - used with org agenda

(setq my/daily-dir "~/docs/org/notes/daily/")
(setq my/daily-files (directory-files my/daily-dir nil ".org$" t))

(defun my/insert-current-date () (interactive)
     (shell-command-to-string "echo -n $(date +%m-%d)"))

(defun my/get-matching-dailies (date)
    (seq-filter (lambda (x) (string-match date x)) my/daily-files))

(defun my/make-dailies-link (file)
  (let ((text "[This Day in Previous Years - ")
        (year (substring file 0 4)))
    (concat "[[" (concat my/daily-dir file) "]"
            text
            year "]]" "\n")))

(defun my/agenda-past-dailies ()
  (let ((x (my/get-matching-dailies (my/insert-current-date))))
    (if x
        (mapcar
         (lambda (x)
           (my/make-dailies-link x))
         x) "")))

(defun my/print-elements-of-list (list)
  "Print each element of LIST on a line of its own."
  (if (eq list "") ""
    (while list
      (insert (car list))
      (setq list (cdr list)))))




;;;  
;;;  Various URL-related functions

(defcustom youtube-viewer-program "youtube-viewer" "Progam path to youtube-viewer")
(defcustom youtube-viewer-args nil "Extra arguments for youtube-viewer")
(defcustom web-article-viewer-program "brave" "Program path to readable")
(defcustom web-article-viewer-args nil "Extra args for qutebrowser")
(defcustom web-article-css "/home/eoin/.config/qutebrowser/minimal.css" "path to minimal stylesheet")

(defun view-youtube-url (url &rest _)
  "Open Youtube-Viewer to browse the given URL."
  (interactive (browse-url-interactive-arg "URL: "))
  (setq url (browse-url-encode-url url))
  (let* ((process-environment (browse-url-process-environment)))
    (apply #'start-process
           (concat "youtube-viewer " url) nil
           youtube-viewer-program
           (append
            youtube-viewer-args
            (list url)))))

(defun my/get-url-at-point ()
   (interactive)
 (kill-new (thing-at-point-url-at-point)))

(defun my/orig-url-link (url)
    (concat "<a href=" (prin1-to-string url) "> Original Link </a>"))

(defun my/readable-url (url)
  (let ((html-file "/tmp/elfeed.html"))
    (progn
     (call-process "readable" nil nil nil (concat "-o " html-file " -s " web-article-css " \""url"\""))
     (append-to-file (my/orig-url-link url) nil html-file)
     html-file)))

(defun my/eww-readable-url ()
  (interactive)
  (let ((link (my/get-url-at-point)))
       (eww-open-file (my/readable-url link))))

(defun my/eww-browse-url ()
  (interactive)
  (eww-browse-url (my/get-url-at-point)))

(defun my/view-readable-webpage-handler (url &rest _)
  (interactive (browse-url-interactive-arg "URL: "))
  (setq url (browse-url-encode-url (my/readable-url url)))
  (let* ((process-environment (browse-url-process-environment)))
    (apply #'start-process
           (concat "brave " url) nil
           web-article-viewer-program
           (append
            web-article-viewer-args
            (list url)))))
