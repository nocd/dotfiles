;;;; on open...

;; set custom dir variables

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq *my-custom-home-dir-windows* "c:/workspace")
(setq *my-custom-home-dir-linux* "~/workspace")
(setq *my-custom-home-dir* "")

;; set *my-custom-home-dir
(defun my/set-custom-home-dir()
    (if (eq system-type 'windows-nt)
	(setq *my-custom-home-dir* *my-custom-home-dir-windows*)
        (setq *my-custom-home-dir* *my-custom-home-dir-linux*)))
(my/set-custom-home-dir)


;;;; theme
(load-theme 'misterioso)

;;;; vars
(setq *my-dev-dir* (concat *my-custom-home-dir* "/dev"))
(setq *my-docs-dir* (concat *my-custom-home-dir* "/docs"))
(setq *my-docs-archive-dir* (concat *my-custom-home-dir* "/docs-archive"))
(setq *my-logs-dir* (concat *my-custom-home-dir* "/log"))
(setq *my-tmp-dir* (concat *my-custom-home-dir* "/tmp"))
(setq *my-notes-dir* (concat *my-custom-home-dir* "/notes"))
(setq *my-notes-in-docs-dir* (concat *my-custom-home-dir* "/docs/_notes"))
(setq *my-elisp-dir* (concat *my-custom-home-dir* "/dev/emacs/elisp"))


;;;; functions
;; reload init.el
(defun my/reload-dot-emacs()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; newdoc function
(setq newdoc-dir (concat *my-docs-dir* "/_notes"))
(defun my/newdoc(doc)
  (interactive "sNew doc name: ") 
  (setq root-doc-dir (concat *my-custom-home-dir* "/docs"))
  (setq new-doc-name (replace-regexp-in-string " " "-" doc))
  (setq new-doc-dir (concat (format-time-string "%Y%m%d-%H%M%S") "-" new-doc-name))
  (setq final-doc-name (concat newdoc-dir "/" (format-time-string "%Y%m%d-%H%M%S") "-" new-doc-name ".org"))
  (mkdir (concat root-doc-dir "/" new-doc-dir))
  (mkdir (concat root-doc-dir "/" new-doc-dir "/reference"))
  (mkdir (concat root-doc-dir "/" new-doc-dir "/archive"))
  (write-region (concat "#+TITLE: " doc "\n\n") nil final-doc-name)
  (find-file final-doc-name))

(defun my/today-short()
  "Insert string for today's date formatted in ISO standard format."
  (interactive)                 
  (insert (format-time-string "%Y-%m-%d")))

(defun my/today-long()
  "Insert string for today's date including day of the week."
  (interactive)                 
  (insert (format-time-string "%A, %B %d, %Y")))

(defun my/goto-dir(dir)
  (dired dir))

(defun my/goto-snippets()
  (interactive)
  (my/goto-dir my/snippets-dir))

(defun my/goto-dev()
  (interactive)
  (my/goto-dir my/dev-dir))

(defun my/goto-home()
  (interactive)
  (my/goto-dir (my/get-user-root-dir)))

(defun my/goto-docs()
  (interactive)
  (my/goto-dir my/docs-dir))

(defun my/get-todo-file()
  (interactive)
  (find-file (concat (my/get-user-root-dir) "/notes/todo.org")))


;;;; keybindings
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))       ; use escape instead of C-g
(global-set-key (kbd "C-S-l") 'my/today-long)
(global-set-key (kbd "C-S-k") 'my/today-short)
(global-set-key (kbd "C-c t") 'my/get-todo-file)


;;;; misc.
;; enable copy-paste via "usual" commands
(cua-mode t)

;; no startup message
(setq inhibit-startup-message t)                 

;; disable backup files
(setq make-backup-files nil)                     

;; disable auto save
(setq auto-save-default nil)                     

;; debug messages on
(setq debug-on-error t)

;; don't use tabs
(setq-default indent-tabs-mode nil)

;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)

;; maximize screen on start
(setq initial-frame-alist
       '((fullscreen . maximized)))

;; show column numbers
(setq column-number-mode t)

;; show battery percentage
(display-battery-mode)

;; turn off confirmation of new buffer/file
(setq confirm-nonexistent-file-or-buffer nil)

;; set default shell
(if (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "C:/Program Files/Git/bin/bash.exe")
  (setq explicit-shell-file-name "/bin/bash"))


;;;; packages
;; dired
(setq dired-listing-switches "-la --group-directories-first")

;; edif
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; electric-pair-mode
(electric-pair-mode t)

;; hi-lock-mode
(global-hi-lock-mode 1)

;; ido mode
(ido-mode t)
(setq ido-use-virtual-buffers t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)

;; show-paren mode
(show-paren-mode 1)                         ;; highlight matching parens
(setq show-paren-style 'parenthesis)

;; vc-mode
(setq vc-follow-symlinks t)

;; visual-line-mode
(visual-line-mode t)

;; TODO: check what this does.
;; (wrap-region-global-mode t)

;; org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t))
          t)


;;;; functions

;; print today's date in ISO format.
(defun my/today-short()
  "Insert string for today's date formatted in ISO standard format."
  (interactive)                 
  (insert (format-time-string "%Y-%m-%d")))

;; print today's date in full.
(defun my/today-long()
  "Insert string for today's date including day of the week."
  (interactive)                 
  (insert (format-time-string "%A, %B %d, %Y")))


;;;; keybindings

;; use escape instead of C-g
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; bind my/today-long
(global-set-key (kbd "C-S-l") 'my/today-long)

;; bind my/today-short
(global-set-key (kbd "C-S-k") 'my/today-short)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
