(package! dired-hide-dotfiles)

(package! prettier)
;; (package! django-snippets)
(package! pony-mode)
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))

(package! org :recipe
  (:host nil :repo "https://git.tecosaur.net/mirrors/org-mode.git" :remote "mirror" :fork
         (:host nil :repo "https://git.tecosaur.net/tec/org-mode.git" :branch "dev" :remote "tecosaur")
         :files
         (:defaults "etc")
         :build t :pre-build
         (with-temp-file "org-version.el"
           (require 'lisp-mnt)
           (let
               ((version
                 (with-temp-buffer
                   (insert-file-contents "lisp/org.el")
                   (lm-header "version")))
                (git-version
                 (string-trim
                  (with-temp-buffer
                    (call-process "git" nil t nil "rev-parse" "--short" "HEAD")
                    (buffer-string)))))
             (insert
              (format "(defun org-release () \"The release version of Org.\" %S)\n" version)
              (format "(defun org-git-version () \"The truncate git commit hash of Org mode.\" %S)\n" git-version)
              "(provide 'org-version)\n"))))
  :pin nil)

(unpin! org)

;;(package! beacon)
;;(package! powerline-evil)
;;(package! lorem-ipsum)
(package! nyan-mode)
;;(package! cakecrumbs)
(package! org-roam-ui)
(package! ido-completing-read+)
;;(package! good-scroll)
;;(package! good-scroll)
(package! picpocket)

(package! org-modern)
(package! olivetti)
(package! elegant-agenda-mode)

(package! atom-one-dark-theme)
(package! gruber-darker-theme)
(package! ewal-doom-themes)
