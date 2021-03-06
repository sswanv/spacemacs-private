(defconst sswanv-packages
  '(youdao-dictionary
    company
    lua-mode
    projectile
    protobuf-mode
    find-file-in-project
    evil
    spaceline
    etags-select
    cc-mode
    avy
    multiple-cursors
    ))

(defun sswanv/init-youdao-dictionary ()
  (use-package youdao-dictionary
    :defer t
    :init
    (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+))
  )

(defun sswanv/post-init-company ()
  (progn
    (setq company-minimum-prefix-length 1
          company-idle-delay 0.08)

    (when (configuration-layer/package-usedp 'company)
      (spacemacs|add-company-hook lua-mode)
      )
    ))

(defun sswanv/post-init-lua-mode ()
  (add-hook 'lua-mode-hook 'evil-matchit-mode)
  (setq lua-indent-level 4)

  (with-eval-after-load 'lua-mode
  (require 'company-keywords)
  (push '(lua-mode  "setmetatable" "local" "function" "and" "break" "do" "else" "elseif" "self" "resume" "yield"
                    "end" "false" "for" "function" "goto" "if" "nil" "not" "or" "repeat" "return" "then" "true"
                    "until" "while" "__index" "dofile" "getmetatable" "ipairs" "pairs" "print" "rawget" "status"
                    "rawset" "select" "_G" "assert" "collectgarbage" "error" "pcall" "coroutine"
                    "rawequal" "require" "load" "tostring" "tonumber" "xpcall" "gmatch" "gsub"
                    "rep" "reverse" "sub" "upper" "concat" "pack" "insert" "remove" "unpack" "sort"
                    "lower") company-keywords-alist))
  )

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
    (define-key evil-insert-state-map [escape] 'evil-normal-state)
    ))

(defun sswanv/post-init-spaceline ()
  (progn
    (setq-default powerline-default-separator 'arrow)))

(defun sswanv/init-etags-select ()
  (use-package etags-select
    :init
    (progn
      (define-key evil-normal-state-map (kbd "gf")
        (lambda () (interactive) (find-tag (find-tag-default-as-regexp))))

      (define-key evil-normal-state-map (kbd "gb") 'pop-tag-mark)

      (define-key evil-normal-state-map (kbd "gn")
        (lambda () (interactive) (find-tag last-tag t)))

      (evilified-state-evilify etags-select-mode etags-select-mode-map)
      (spacemacs/set-leader-keys-for-major-mode 'js2-mode
        "gd" 'etags-select-find-tag-at-point))))

(defun sswanv/post-init-cc-mode ()
    (progn
      (setq c-default-style "linux")
      (setq c-basic-offset 4)
      (c-set-offset 'substatement-open 0)
      ))

(defun sswanv/post-init-avy ()
  (progn
    (define-key evil-normal-state-map (kbd "SPC SPC") 'avy-goto-char-timer)))

(defun sswanv/init-multiple-cursors ()
  (use-package multiple-cursors
    :defer t
    :init
    (progn
      (bind-key* "C-s-l" 'mc/edit-lines)
      (bind-key* "C-s-f" 'mc/mark-all-dwim)
      (bind-key* "C-s-." 'mc/mark-next-like-this)
      (bind-key* "C-s-," 'mc/mark-previous-like-this)
      (bind-key* "s->" 'mc/unmark-next-like-this)
      (bind-key* "s-<" 'mc/unmark-previous-like-this)
      (bind-key* "C-c C-s-." 'mc/mark-all-like-this)

      ;; http://endlessparentheses.com/multiple-cursors-keybinds.html?source=rss
      (define-prefix-command 'endless/mc-map)
      ;; C-x m is usually `compose-mail'. Bind it to something
      ;; else if you use this command.
      (define-key ctl-x-map "m" 'endless/mc-map)
;;; Really really nice!
      (define-key endless/mc-map "i" #'mc/insert-numbers)
      (define-key endless/mc-map "h" #'mc-hide-unmatched-lines-mode)
      (define-key endless/mc-map "a" #'mc/mark-all-like-this)
      ))
  )
