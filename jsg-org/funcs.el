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

(defun jsg-org/meeting-notes ()
      "Call this after creating an org-mode heading for where the notes for the meeting
should be. After calling this function, call 'meeting-done' to reset the environment."
      (interactive)
      (outline-mark-subtree)                              ;; Select org-mode section
      (narrow-to-region (region-beginning) (region-end))  ;; Only show that region
      (deactivate-mark)
      (delete-other-windows)                              ;; Get rid of other windows
      (text-scale-set 2)                                  ;; Text is now readable by others
      (fringe-mode 0)
      (message "When finished taking your notes, run meeting-done."))

(defun jsg-org/meeting-done ()
      "Attempt to 'undo' the effects of taking meeting notes."
      (interactive)
      (widen)                                       ;; Opposite of narrow-to-region
      (text-scale-set 0)                            ;; Reset the font size increase
      (fringe-mode 1)
      (winner-undo))                                ;; Put the windows back in place


(defun jsg-org/nolinum ()
      (global-linum-mode 0)
    )

;;; funcs.el ends here
