
(spacemacs|defvar-company-backends lua-mode)

(setq ns-use-srgb-colorspace nil)
(setq-default default-tab-width 4)

(when (spacemacs/system-is-mswindows)
  (progn
    (set-fontset-font "fontset-default"
                      'gb18030 '("Microsoft YaHei" . "unicode-bmp"))
    ))

(when (spacemacs/system-is-mac)
  (setq ns-pop-up-frames nil))

(global-prettify-symbols-mode 1)
(setq-default fill-column 80)

(defun spacemacs/check-large-file ()
  (when (> (buffer-size) 500000)
    (progn (fundamental-mode)
           (hl-line-mode 01))))

(add-hook 'find-file-hook 'spacemacs/check-large-file)

