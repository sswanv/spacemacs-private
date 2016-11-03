
(setq ns-use-srgb-colorspace nil)
(setq-default default-tab-width 4)

(when (spacemacs/system-is-mswindows)
  (progn
    (set-fontset-font "fontset-default"
                      'gb18030 '("Microsoft YaHei" . "unicode-bmp"))
    ))
