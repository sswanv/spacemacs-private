
(spacemacs/set-leader-keys "oll" 'sswanv/load-my-layout)
(spacemacs/set-leader-keys "ols" 'sswanv/save-my-layout)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(global-set-key (kbd "s-d") 'sswanv/my-mc-mark-next-line-this)

(define-key evil-visual-state-map (kbd "C-r") 'sswanv/evil-quick-replace)

