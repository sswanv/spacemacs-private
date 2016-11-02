(defconst sswanv-packages
  '(youdao-dictionary
    company
    lua-mode
    projectile
    protobuf-mode
    find-file-in-project
    evil
    ))

(defun sswanv/init-youdao-dictionary ()
  (use-package youdao-dictionary
    :defer t
    :init
    (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+))
  )


(defun sswanv/post-init-company ()
  (setq company-minimum-prefix-length 1))


(defun sswanv/post-init-lua-mode ()
  (setq lua-indent-level 4))

(defun sswanv/init-protobuf-mode ()
  (use-package protobuf-mode
    :defer t
    :mode ("\\.proto\\'" . protobuf-mode)))

(defun sswanv/post-init-projectile ()
  (progn
    (with-eval-after-load 'projectile
      (progn
        (setq projectile-completion-system 'ivy)
        (add-to-list 'projectile-other-file-alist '("html" "js"))
        (add-to-list 'projectile-other-file-alist '("js" "html"))))

    (defvar my-simple-todo-regex "\\<\\(FIXME\\|TODO\\|BUG\\):")

    (defun my-simple-todo ()
      "When in a project, create a `multi-occur' buffer matching the
  regex in `my-simple-todo-regex' across all buffers in the
  current project. Otherwise do `occur' in the current file."
      (interactive)
      (if (projectile-project-p)
          (multi-occur (projectile-project-buffers) my-simple-todo-regex)
        (occur my-simple-todo-regex)))
    (spacemacs/set-leader-keys "pf" 'sswanv/open-file-with-projectile-or-counsel-git)
    ;; (spacemacs/set-leader-keys "pt" 'my-simple-todo)
	))

(defun sswanv/init-find-file-in-project ()
  (use-package find-file-in-project
    :defer t))

(defun sswanv/post-init-evil ()
  (progn
    (setcdr evil-insert-state-map nil)
    (define-key evil-insert-state-map [escape] 'evil-normal-state)))
