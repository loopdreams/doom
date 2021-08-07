;; init-custom.el --- Define customizations.	-*- lexical-binding: t -*-


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/sci/notes/blognotes.org" "/home/eoin/sci/notes/storynotes.org" "/home/eoin/sci/notes/korea_september_trip.org" "/home/eoin/sci/notes/birthdays_holidays.org" "/home/eoin/sci/notes/reading_notes.org" "/home/eoin/sci/notes/website.org" "/home/eoin/sci/todo.org" "/home/eoin/sci/archive.org" "/home/eoin/sci/notes/travelling_home.org" "/home/eoin/sci/recurring_todo.org" "/home/eoin/sci/notes/20210616194744-index.org" "/home/eoin/sci/journal.org"))
 '(org-capture-templates
   '(("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox")
      "* TODO %?
%i
%a" :prepend t)
     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox")
      "* %u %?
%i
%a" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree +org-capture-journal-file)
      "* %U %?
%i
%a" :prepend t)
     ("i" "Blog Idea" entry
      (id "9d9237c9-e79c-465b-9c10-2d75b6b4fdb0")
      "* IDEA %u %?
%i" :prepend t)
     ("f" "Fiction Idea" entry
      (id "8a5272ce-9e99-4786-b645-942c942031c8")
      "* IDEA %u %?
%i" :prepend t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-dashboard-banner ((t (:foreground "slategray")))))
