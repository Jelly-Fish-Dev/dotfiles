;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;(package-initialize)
;(package-refresh-contents)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'github-dark-vscode t)

; disable the bars
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode -1)
; internal border
;(internal-border-width . 10)
; opacity
(set-frame-parameter (selected-frame) 'alpha '(90 . 70))
(add-to-list 'default-frame-alist '(alpha . (90 . 70)))
;;Font
(set-frame-font "JetBrainsMono 13" nil t)
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(org-inline-anim org-download org-journal evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; OrgMode
;flyspell
(add-hook 'org-mode-hook 'flyspell-mode)
(setq org-startup-with-inline-images t)
(setq org-image-actual-width nil)
;;Journaling
(require 'org-journal)
(setq org-journal-dir "~/Documents/journal")
(setq org-journal-date-format "%A, %d %B %Y")
(setq org-journal-file-format "%Y.%m.%d.org")
(add-hook 'org-journal-hook
	  (lambda ()
	    (setq org-download-image-dir "~/journal/%Y.%M.%d")))
