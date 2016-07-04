;;; packages.el --- sswanv layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: John <Rawlins@sswanv.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `sswanv-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `sswanv/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `sswanv/pre-init-PACKAGE' and/or
;;   `sswanv/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst sswanv-packages
  '(youdao-dictionary
    company
    lua-mode))

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

;;; packages.el ends here
