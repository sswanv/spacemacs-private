(defconst sswanv-packages
  '(youdao-dictionary
    company
    lua-mode
    protobuf-mode))

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

