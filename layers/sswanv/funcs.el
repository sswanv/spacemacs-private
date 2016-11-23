
(defun sswanv/vcs-project-root ()
  "Return the project root for current buffer."
  (let ((directory default-directory))
    ;; (or (locate-dominating-file directory ".git")
    ;;     (locate-dominating-file directory ".svn")
    ;;     (locate-dominating-file directory ".hg"))))
    (or (locate-dominating-file directory ".git"))))

(defun sswanv/open-file-with-projectile-or-counsel-git ()
  (interactive)
  (if (sswanv/vcs-project-root)
      (counsel-git)
    (if (projectile-project-p)
        (projectile-find-file)
      (counsel-file-jump))))

;; (defun sswanv/open-file-with-projectile-or-counsel-git ()
;;   (interactive)
;;   (if (or (sswanv/vcs-project-root)
;;           (projectile-project-p))
;;       (counsel-projectile-find-file)
;;     (counsel-file-jump)))

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


(defun my-project-name-contains-substring (REGEX)
  (let ((dir (if (buffer-file-name)
                 (file-name-directory (buffer-file-name))
               "")))
    (string-match-p REGEX dir)))


(defvar my-tags-updated-time nil)

(defun my-create-tags-if-needed (SRC-DIR &optional FORCE)
  "return the full path of tags file"
  (let ((dir (file-name-as-directory (file-truename SRC-DIR)))
        file)
    (setq file (concat dir "TAGS"))
    (when (spacemacs/system-is-mswindows)
      (setq dir (substring dir 0 -1)))
    (when (or FORCE (not (file-exists-p file)))
      (message "Creating TAGS in %s ..." dir)
      (shell-command
       (format "d:\\emacs\\bin\\ctags.exe -f %s -e -R %s" file dir)))
    file))

(defun my-update-tags ()
  (interactive)
  "check the tags in tags-table-list and re-create it"
  (dolist (tag tags-table-list)
    (my-create-tags-if-needed (file-name-directory tag) t)))


(defun my-auto-update-tags-when-save (prefix)
      (interactive "P")
      (cond
       ((not my-tags-updated-time)
        (setq my-tags-updated-time (current-time)))

       ((and (not prefix)
             (< (- (float-time (current-time)) (float-time my-tags-updated-time)) 300))
        ;; < 300 seconds
        (message "no need to update the tags")
        )
       (t
        (setq my-tags-updated-time (current-time))
        (my-update-tags)
        (message "updated tags after %d seconds." (- (float-time (current-time)) (float-time my-tags-updated-time))))))


(defun my-setup-develop-environment ()
  (interactive)
  (when (my-project-name-contains-substring "lianjiwushuang")
    (cond
     ((my-project-name-contains-substring "lianjiwushuang")
      ;; C++ project don't need html tags
      (setq tags-table-list (list (my-create-tags-if-needed "d:/sswanv/workspace-git/client/game/trunk/lianjiwushuang/res/script")))))))

