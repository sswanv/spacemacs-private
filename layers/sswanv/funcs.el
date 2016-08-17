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
