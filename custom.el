;; init-custom.el --- Define customizations.	-*- lexical-binding: t -*-


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(custom-safe-themes
   '("d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" default))
 '(exwm-floating-border-color "#191b20")
 '(fci-rule-color "#5B6268")
 '(highlight-tail-colors
   ((("#333a38" "#99bb66" "green")
     . 0)
    (("#2b3d48" "#46D9FF" "brightcyan")
     . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(objed-cursor-color "#ff6c6b")
 '(org-agenda-files
   '("~/Dropbox/sci/notes/20211020-shopping.org" "/home/eoin/Dropbox/sci/notes/20211020-downtime.org" "/home/eoin/Dropbox/sci/notes/20211019-actions.org" "/home/eoin/Dropbox/sci/notes/20211019-projects.org" "/home/eoin/Dropbox/sci/trash.org" "/home/eoin/Dropbox/sci/notes/20211015-comptia_core_1_lesson_3_hardware.org" "/home/eoin/Dropbox/sci/notes/20211011-arch_linux.org" "/home/eoin/Dropbox/sci/notes/20211011-comptia_core1.org" "/home/eoin/Dropbox/sci/subscriptions.org" "/home/eoin/Dropbox/sci/notes/blognotes.org" "/home/eoin/Dropbox/sci/notes/reading_notes.org" "/home/eoin/Dropbox/sci/notes/storynotes.org" "/home/eoin/Dropbox/sci/notes/20210616194744-index.org" "/home/eoin/Dropbox/sci/archive.org" "/home/eoin/Dropbox/sci/recurring_todo.org" "/home/eoin/Dropbox/sci/notes/20211003-administrative_office_application.org" "/home/eoin/Dropbox/sci/notes/20211005-comptia_aplus.org" "/home/eoin/Dropbox/sci/todo.org"))
 '(org-capture-templates
   '(("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox")
      "* TODO %?
%i
%a" :prepend t)
     ("r" "Roam Todo" entry
      (id "0a6e0e8a-c2e2-4d6d-ba85-066645c087ef")
      "* TODO %?
%i
%a" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree +org-capture-journal-file)
      "* %U %?
%i
%a" :prepend t)
     ("c" "Config Todo" entry
      (id "05774d4c-565c-4cd8-8f32-ccefe997a75a")
      "* CONFIG %?
%i
%a" :prepend t)
     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox")
      "* %u %?
%i
%a" :prepend t)
     ("i" "Blog Idea" entry
      (id "9d9237c9-e79c-465b-9c10-2d75b6b4fdb0")
      "* IDEA %u %?
%i" :prepend t)
     ("f" "Fiction Idea" entry
      (id "8a5272ce-9e99-4786-b645-942c942031c8")
      "* IDEA %u %?
%i" :prepend t)))
 '(pdf-view-midnight-colors (cons "#bbc2cf" "#282c34"))
 '(rustic-ansi-faces
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(smtpmail-smtp-server "mail.spool-five.com")
 '(smtpmail-smtp-service 25)
 '(vc-annotate-background "#282c34")
 '(vc-annotate-color-map
   (list
    (cons 20 "#98be65")
    (cons 40 "#b4be6c")
    (cons 60 "#d0be73")
    (cons 80 "#ECBE7B")
    (cons 100 "#e6ab6a")
    (cons 120 "#e09859")
    (cons 140 "#da8548")
    (cons 160 "#d38079")
    (cons 180 "#cc7cab")
    (cons 200 "#c678dd")
    (cons 220 "#d974b7")
    (cons 240 "#ec7091")
    (cons 260 "#ff6c6b")
    (cons 280 "#cf6162")
    (cons 300 "#9f585a")
    (cons 320 "#6f4e52")
    (cons 340 "#5B6268")
    (cons 360 "#5B6268")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-dashboard-banner ((t (:foreground "slategray")))))
