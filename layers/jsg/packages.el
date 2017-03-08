;;; packages.el --- jsg-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Jason Graham <Jason@Jasons-MacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;;; Code:

(defconst jsg-packages
  '()

(defun jsg/init-jsg ()
   "Initialize my package"
   (use-package org-bullets org-journal restclient))

;;; packages.el ends here
