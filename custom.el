;; init-custom.el --- Define customizations.	-*- lexical-binding: t -*-


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(custom-safe-themes
   '("51c71bb27bdab69b505d9bf71c99864051b37ac3de531d91fdad1598ad247138" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "ff1607d931035f2496e58566ee567b44a0f10be2f3f55d8e2956af16a2431d94" "68a665225842bc1dec619da72f6d2e05d5c46fc64a70199272ebc21cab74477f" "dfd454ea75972b348035eb0756f72a6b47ddf6b46e48800bc4dfd55a7002b2bf" "857a606b0b1886318fe4567cc073fcb1c3556d94d101356da105a4e993112dc8" "f1a116f53d9e685023ebf435c80a2fecf11a1ecc54bb0d540bda1f5e2ae0ae58" "6fad1050fbe7ee0b4bca65d33078d279a96f64c0df3286b36ce45fe4803847f2" "4f1d2476c290eaa5d9ab9d13b60f2c0f1c8fa7703596fa91b235db7f99a9441b" "835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "4b6b6b0a44a40f3586f0f641c25340718c7c626cbf163a78b5a399fbe0226659" "7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" "f91395598d4cb3e2ae6a2db8527ceb83fed79dbaf007f435de3e91e5bda485fb" "246a9596178bb806c5f41e5b571546bb6e0f4bd41a9da0df5dfbca7ec6e2250c" "d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" default))
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
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(pdf-view-midnight-colors (cons "#bbc2cf" "#282c34"))
 '(rustic-ansi-faces
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(safe-local-variable-values
   '((org-roam-db-location . "/home/eoin/Dropbox/braindump/org/org-roam.db")
     (org-roam-directory . "/home/eoin/Dropbox/braindump/org/")
     (org-roam-db-location . "/home/eoin/Dropbox/llord/org-roam.db")
     (org-roam-directory . "/home/eoin/Dropbox/llord")
     (org-roam-db-location . "/home/eoin/Dropbox/work/org-roam.db")
     (org-roam-directory . "/home/eoin/Dropbox/work")))
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
 '(vc-annotate-very-old-color nil)
 '(warning-suppress-types '(((flycheck syntax-checker)) ((flycheck syntax-checker)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-dashboard-banner ((t (:foreground "slategray"))))
 '(org-document-title ((t (:height 2.0))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.12))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.08))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))
