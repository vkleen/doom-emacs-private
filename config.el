;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

;; (defvar xdg-data (getenv "XDG_DATA_HOME"))
;; (defvar xdg-bin (getenv "XDG_BIN_HOME"))
;; (defvar xdg-cache (getenv "XDG_CACHE_HOME"))
;; (defvar xdg-config (getenv "XDG_CONFIG_HOME"))

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(setq-default
 user-full-name    "Viktor Kleen"
 user-mail-address "vkleen@17220103.de"

 ;; doom-variable-pitch-font (font-spec :family "Fira Sans")
 ;; doom-unicode-font (font-spec :family "Input Mono Narrow" :size 12)
 doom-big-font (font-spec :family "PragmataPro" :size 19)

 +workspaces-switch-project-function #'ignore
 +pretty-code-enabled-modes '(emacs-lisp-mode org-mode)
 +format-on-save-enabled-modes '(not emacs-lisp-mode)
 doom-theme 'doom-one
 doom-localleader-key "\\" )

;; (setq-hook! 'minibuffer-setup-hook show-trailing-whitespace nil)

(add-to-list 'org-modules 'org-habit t)


;;
;; Host-specific config

(pcase (system-name)
  (_
   (setq doom-font (font-spec :family "PragmataPro" :size 16 :weight 'semi-light)
         +modeline-height 25)))

;;
;; Keybindings


(map!
 :n "\\" nil
 ;; Easier window navigation
 :n "C-h"   #'evil-window-left
 :n "C-j"   #'evil-window-down
 :n "C-k"   #'evil-window-up
 :n "C-l"   #'evil-window-right

 :n "J"     (lambda () (interactive) (evil-next-line 10))
 :n "K"     (lambda () (interactive) (evil-previous-line 10))

 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))

 (:leader
   ;; (:prefix "f"
   ;;   :desc "Find file in dotfiles" :n "t" #'+hlissner/find-in-dotfiles
   ;;   :desc "Browse dotfiles"       :n "T" #'+hlissner/browse-dotfiles)
   (:prefix "n"
     :desc "Browse mode notes"     :n  "m" #'+hlissner/find-notes-for-major-mode
     :desc "Browse project notes"  :n  "p" #'+hlissner/find-notes-for-project)

   :desc "Join" :n "j" #'evil-join))


;;
;; Modules

;; app/rss
(add-hook! 'elfeed-show-mode-hook (text-scale-set 2))

;; emacs/eshell
(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg"  "rg --color=always $*"))

;; tools/magit
(setq magit-repository-directories '(("~/work" . 2))
      magit-save-repository-buffers nil
      magit-commit-arguments '("--gpg-sign=1FE9015A0610E43C74EFC813744138390330BB39")
      magit-rebase-arguments '("--autostash" "--gpg-sign=1FE9015A0610E43C74EFC813744138390330BB39")
      magit-pull-arguments   '("--rebase" "--autostash" "--gpg-sign=1FE9015A0610E43C74EFC813744138390330BB39"))

;; lang/org
(setq org-directory (expand-file-name "~/work/org/")
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "

      ;; The standard unicode characters are usually misaligned depending on the
      ;; font. This bugs me. Personally, markdown #-marks for headlines are more
      ;; elegant.
      org-bullets-bullet-list '("#"))
