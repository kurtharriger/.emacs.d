

(let ((sonian-nav-file "~/sonian/sa-safe/.elisp/sonian-navigation.el"))
    (when (file-exists-p sonian-nav-file)
          (load (expand-file-name sonian-nav-file))))
