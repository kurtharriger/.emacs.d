(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(ac-nrepl
                      auto-complete
                      cl
                      cl-lib
                      nrepl
                      clojure-mode
                      clojure-test-mode
                      expand-region
;                      flx-ido
;                      flycheck
                      flymake
                      flymake-cursor
                      flymake-jshint
                      helm
                      helm-ls-git
  ;                      helm-projectile
                      highlight-symbol
                      js2-mode
                      js2-refactor
;                      projectile
                      simp
                      starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      markdown-mode
                      ;smart-window
                      skewer-mode
                      tree-mode
                      yasnippet
                      yas-jit
                      zenburn-theme
                      zencoding-mode
                      ;emacs-pry
                      )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;(load-theme 'wombat t)
(load-theme 'zenburn t)

;; >>> Configure Load Path <<<
;; From http://stackoverflow.com/a/1062314/594677
;; >>> ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq emacs-config-path "~/.emacs.d/")
(setq base-lisp-path "~/.emacs.d/site-lisp/")
(setq site-lisp-path (concat emacs-config-path "/site-lisp"))
(defun add-path (p)
  (add-to-list 'load-path (concat base-lisp-path p)))

;; I should really just do this recursively.
(add-path "")
;; (add-path "some-nested-folder")

;; Load modules in site-lisp

(require 'transpose-frame)

;; >>> ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Configure simp - it's like Vim's Ctrl-P
;; (require 'simp)
;; (simp-project-define
;;  '(:has (.git)
;;         :ignore (tmp coverage log vendor .git public/system public/assets)))
;; (simp-project-define
;;  '(:has (.svn)
;;         :ignore (.svn)))
;; (global-set-key [(control p)] 'simp-project-find-file)

;(projectile-global-mode)
;(helm-mode 1)


;;; Load window management crap
;(load "~/.emacs.d/emacsd-tile.el")

;; Enable autp-complete - taken in part from http://www.emacswiki.org/emacs/init-auto-complete.el
(require 'auto-complete)
(global-auto-complete-mode t)           ;enable global-mode
(setq ac-auto-start t)                  ;automatically start

(setq ac-modes
      '(emacs-lisp-mode lisp-interaction-mode lisp-mode scheme-mode
                        c-mode cc-mode c++-mode
                        clojure-mode java-mode
                        perl-mode cperl-mode python-mode ruby-mode
                        ecmascript-mode javascript-mode js2-mode php-mode css-mode
                        makefile-mode sh-mode fortran-mode f90-mode ada-mode
                        xml-mode sgml-mode
                        haskell-mode literate-haskell-mode
                        emms-tag-editor-mode
                        asm-mode
                        org-mode))


;; Set up ac-nrepl, per https://github.com/clojure-emacs/ac-nrepl#installation
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ClojureScript
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JavaScript
;;(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'flymake-jshint)
(require 'flymake-cursor)
(add-hook 'js2-mode-hook 'flymake-mode)

;; Load in skewer-mode
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;; JS2-refactor mode
(js2r-add-keybindings-with-prefix "C-c C-m")

;; (require 'js-comint)
;; (setq inferior-js-program-command "node")
;; (add-hook 'js2-mode-hook '(lambda ()
;;                             (local-set-key "\C-x\C-e" 'js-send-last-sexp)
;;                             (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
;;                             (local-set-key "\C-cb" 'js-send-buffer)
;;                             (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
;;                             (local-set-key "\C-cl" 'js-load-file-and-go)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Markdown support
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

(setq
 scroll-margin 0
 scroll-conservatively 100000
 scroll-preserve-screen-position 1)

(electric-indent-mode +1)

(auto-fill-mode -1)

;; Enable winner mode - C-c <left> to go back a window configuration
(winner-mode)

;; Enable rainbow parens for all programming modes
;;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


;; Custom keybindings
(global-set-key (kbd "M-@") 'er/expand-region) ; expand selected region 


;; In-place scrolling

(defun scroll-down-in-place (n)
  (interactive "p")
  (next-line n)
  (scroll-down-line n))

(defun scroll-up-in-place (n)
  (interactive "p")
  (previous-line n)
  (scroll-up-line n))


;; Enable helm mode
(helm-mode t)

(global-set-key (kbd "C-x C-_")
                ;; I have no idea why this matches C-x C-/, but it does and that's what I was after
                (lambda ()
                  (interactive)
                  (helm :sources '(helm-source-findutils) :buffer "*helm-findutils*")))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 4)
 '(js-indent-level 4))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq create-lockfiles nil)
