;; -*- mode: elisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MELPA 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

;; Add melpa package source when using package list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; Load emacs packages and activate them
;; This must come before configurations of installed packages
;; Don't delete this line
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable files ending in ~ 
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; Change default tab with to 4 spaces 
(setq default-tab-width 4)

;; Disable the scroll bar 
(scroll-bar-mode -1)

;; Disables tool bar 
(tool-bar-mode -1)

;; Disable the splash screen (to enable, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode (should be enabled by default)
(transient-mark-mode 1)

;; Bind =C-x v= to open ~/.emacs, remnant from my Vim times where
;; =<Leader> v= would open my ~/.vimrc
(global-set-key (kbd "\C-xv") (lambda () (interactive)
  (find-file "~/.emacs")
  (message "Opened:  %s" (buffer-name))))

;; Enables this: 
;; * Top level headline             |    * Top level headline
;; ** Second level                  |      * Second level
;; *** 3rd level                    |        * 3rd level
(add-hook 'org-mode-hook 'org-indent-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org mode 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable org-mode
(require 'org)


;; Log tasks that are done with a timestamp 
(setq org-log-done t)

;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-archive-location (concat "~/Documents/Reference/org/archive/" (format-time-string "%Y-%m") ".org::"))

;; Allow multiline emphasis/bold
(setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n,\"")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-mode settings I should delete but keep for some reason 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(setq org-archive-location (concat "archive/archive-"
;;                                   (format-time-string "%Y%m" (current-time))
;;                                   ".org_archive::"))

;; https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html

;;;;;;;;;;;;;
;; SETTINGS 1
;;;;;;;;;;;;;
;;(setq org-archive-location (concat "~/gtd/archive/" (format-time-string "%Y-%m") ".org::"))
;;(setq org-agenda-files '("~/gtd/inbox.org"
;;                         "~/gtd/gtd.org"
;;                         "~/gtd/tickler.org"))

;; I press C-c c t to add an entry to my inbox,
;; and C-c c T to add an entry to the tickler (more on that later).
;;(setq org-capture-templates '(("t" "Todo [inbox]" entry
;;                               (file+headline "~/gtd/inbox.org" "Tasks")
;;                               "* TODO %i%?")
;;                              ("T" "Tickler" entry
;;                               (file+headline "~/gtd/tickler.org" "Tickler")
;;                               "* %i%? \n %U")))
;;
;;(setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
;;                           ("~/gtd/someday.org" :level . 1)
;;                           ("~/gtd/tickler.org" :maxlevel . 2)
;;			   ("~/gtd/notes.org" :maxlevel . 2)))


;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
;; (setq org-agenda-files '("~/org/agenda/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil mode 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable Evil mode 
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;; Makes C-u scroll up (see: https://stackoverflow.com/questions/14302171/ctrlu-in-emacs-when-using-evil-key-bindings)
(setq evil-want-C-u-scroll t)

;; Enable KeyChords
(add-to-list 'load-path "~/.emacs.d/key-chord")
(require 'key-chord)
(key-chord-mode 1)

;; Binds =S-j S-j= to swap to previous buffer 
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer. Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(key-chord-define-global "JJ" 'switch-to-previous-buffer)

;; Binds =kj= to =Esc= using KeyChords 
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(fci-rule-color "#eee8d5")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files
   (quote
    ("~/Documents/Reference/org/main2.org" "~/Documents/Reference/org/main.org" "~/Documents/Reference/2019-05-17-Fri.org" "~/Documents/Reference/main.org")))
 '(package-selected-packages
   (quote
    (org-bullets htmlize evil-easymotion projectile auctex-latexmk latex-math-preview spaceline spacemacs-theme auctex solarized-theme)))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c9485ddd1797")
     (60 . "#bf7e73b30bcb")
     (80 . "#b58900")
     (100 . "#a5a58ee30000")
     (120 . "#9d9d91910000")
     (140 . "#9595943e0000")
     (160 . "#8d8d96eb0000")
     (180 . "#859900")
     (200 . "#67119c4632dd")
     (220 . "#57d79d9d4c4c")
     (240 . "#489d9ef365ba")
     (260 . "#3963a04a7f29")
     (280 . "#2aa198")
     (300 . "#288e98cbafe2")
     (320 . "#27c19460bb87")
     (340 . "#26f38ff5c72c")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:background "#292B2E" :foreground "#2aa1ae" :slant normal)))))

;; Make evil paragraphs behave like vim paragraphs
;; See: https://emacs.stackexchange.com/questions/38596/make-evil-paragraphs-behave-like-vim-paragraphs
(with-eval-after-load 'evil
  (defadvice forward-evil-paragraph (around default-values activate)
    (let ((paragraph-start (default-value 'paragraph-start))
          (paragraph-separate (default-value 'paragraph-separate)))
      ad-do-it)))

;; Evil-easymotion, downloaded and added manually on 31-05-2019 
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "evil-easymotion") ;; best not to include the ending “.el” or “.elc”
(evilem-default-keybindings "SPC")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Neotree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Install Neotree
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)

;; Bind =M-f8= to toggle neotree
(global-set-key [f8] 'neotree-toggle)

;; Conflicting keybinds Neotree + Evil mode 
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

;; Makes neotree resizeable
(setq neo-window-fixed-size nil)

;; Set neotree window width
;;(setq neo-window-width 20)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; First install using M-x package-install RET use-package RET 
(require 'use-package)

;; Get that spacemacs powerline feel 
(use-package spaceline
  :demand t
  :init
  (setq powerline-default-separator 'nil)
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Adds stuff to my PATH (LaTeX, etc) 
(setq exec-path (append exec-path '("/Library/TeX/texbin")))

(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin"))

;; Set the default LaTeX exec to pdfTeX
(setq TeX-PDF-mode t)

;; Load AucTeX!! :D <= unnecessary with auxtex
;;(load "auctex.el" nil t t) ;; loads tex-site in such a way so that it can be undone
;;(load "preview-latex.el" nil t t) ;; actual preview-latex

;; Sets the default PDF viewer to, well, the default PDF viewer.
(setq TeX-view-program-list '(("Shell Default" "open %o")))
(setq TeX-view-program-selection '((output-pdf "Shell Default")))

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;; #292B2E
(setq org-latex-create-formula-image-program 'dvipng)

;; preview font scale  => doesnt work => customize face 
;;(set-default 'preview-scale-function 10)
;;https://emacs.stackexchange.com/questions/19880/font-size-control-of-latex-previews-in-org-files
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Projectile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; projectile bindings 
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)
