;; -*- lexical-binding: t; -*-

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;(package-initialize)
;(package-refresh-contents)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'warm-night :no-confirm)

(electric-indent-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode -1)
;line number
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;(internal-border-width . 10)
; opacity
(set-frame-parameter (selected-frame) 'alpha '(90 . 70))
(add-to-list 'default-frame-alist '(alpha . (90 . 70)))
;;Font
(set-frame-font "JetBrainsMono 11" nil t)
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(setq evil-want-keybinding nil)
;; Enable Evil
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9ab46512b8b69478b057f79d0eb0faee61d19e53917a868a14e41bf357cee6d4" default))
 '(org-agenda-files '("~/Documents/Budget/June.2024.org"))
 '(package-selected-packages
   '(xah-fly-keys lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number ((t (:inherit (shadow default) :background "#181515"))))
 '(shadow ((t (:foreground "gainsboro")))))

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

;; Company
(add-hook 'after-init-hook 'global-company-mode)

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)


;;Show line numbers how I like
(defun display-relative-line-numbers ()
    (interactive)
    (display-line-numbers-mode)
    (setq display-line-numbers ' relative))

(which-key-mode)
(defun add-hook-c ()
  (lsp)
  (display-relative-line-numbers))
(add-hook 'c-mode-hook #'add-hook-c)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'display-line-numbers-mode)
(add-hook 'emacs-lisp-mode-hook 'display-relative-line-numbers)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(require 'compile) ; makes sure you have compile

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))


;; evil in other modes
(require 'evil-collection)
(with-eval-after-load 'ansi-term (evil-collection-term-setup))
(put 'erase-buffer 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/predictive/")
(add-hook 'org-journal-mode-hook '(load-library predictive))
(add-hook 'org-journal-mode-hook 'visual-line-mode)
