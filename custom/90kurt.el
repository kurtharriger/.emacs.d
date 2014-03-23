

;; Enable mouse support
(unless window-system
    (require 'mouse)
      (xterm-mouse-mode t)
        (global-set-key [mouse-4] '(lambda ()
                                                                    (interactive)
                                                                                                   (scroll-down 1)))
          (global-set-key [mouse-5] '(lambda ()
                                                                      (interactive)
                                                                                                     (scroll-up 1)))
            (defun track-mouse (e))
              (setq mouse-sel-mode t))


;; clipboard
(defun paste-from-osx ()
    (interactive)
      (shell-command-to-string "pbpaste"))

(defun copy-to-osx (text &optional push)
    (interactive)
      (let ((process-connection-type nil))
            (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
                    (process-send-string proc text)
                          (process-send-eof proc))))

;; only enable this on OS X

(when (not (string= "" (shell-command-to-string "/usr/bin/which pbpaste")))
    (setq interprogram-cut-function 'copy-to-osx)
      (setq interprogram-paste-function 'paste-from-osx))

(setq auto-save-default nil)
(setq backup-inhibited t)

(define-globalized-minor-mode global-undo-tree-mode
    undo-tree-mode undo-tree-mode)

(global-undo-tree-mode 1)
