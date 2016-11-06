
(defun sswanv/vcs-project-root ()
  "Return the project root for current buffer."
  (let ((directory default-directory))
    (or (locate-dominating-file directory ".git")
        (locate-dominating-file directory ".svn")
        (locate-dominating-file directory ".hg"))))

(defun sswanv/open-file-with-projectile-or-counsel-git ()
  (interactive)
  (if (sswanv/vcs-project-root)
      (counsel-git)
    (if (projectile-project-p)
        (projectile-find-file)
      (counsel-file-jump))))

(defun sswanv/load-my-layout ()
  (interactive)
  (persp-load-state-from-file (concat persp-save-dir "sswanv")))

(defun sswanv/save-my-layout ()
  (interactive)
  (persp-save-state-to-file (concat persp-save-dir "sswanv")))

(defun sswanv/my-mc-mark-next-line-this ()
  (interactive)
  (if (region-active-p)
      (mc/mark-next-like-this 1)
    (er/expand-region 1)))

(defun sswanv/evil-quick-replace (beg end)
  (interactive "r")
  (when (evil-visual-state-p)
    (evil-exit-visual-state)
    (let ((selection (regexp-quote (buffer-substring-no-properties beg end))))
      (setq command-string (format "%%s /%s//g" selection))
      (minibuffer-with-setup-hook
          (lambda () (backward-char 2))
        (evil-ex command-string)))))

