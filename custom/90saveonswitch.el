;; Source:
;; http://batsov.com/articles/2012/03/08/emacs-tip-number-5-save-buffers-automatically-on-buffer-or-window-switch/

;; use shift + arrow keys to switch between visible buffers
(require 'windmove)
(windmove-default-keybindings 'super)

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defadvice switch-to-buffer (before save-buffer-now activate)
    (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
    (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
    (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
    (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
    (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
    (when buffer-file-name (save-buffer)))

(global-auto-revert-mode 1)
