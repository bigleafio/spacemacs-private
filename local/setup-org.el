;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(setq org-default-notes-file "~/Dropbox/org-life/notes.org")
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-indent-mode t)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/org-life/projects.org" "Quick Tasks")
         "* TODO %?\n  %i\n  %a")
        ("d" "Debug journal" entry (file+datetree "~/Dropbox/org-life/debug-journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("n" "Note" entry (file "~/Dropbox/org-life/notes.org")
         "* %?")))
(setq org-startup-indented t)
(setq org-agenda-files (list "~/Dropbox/org-life/projects.org"))
;; Configure refile to use ido and allow nested targets
(setq org-completion-use-ido t)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path t)
(setq org-refile-targets '((nil . (:maxlevel . 5))))
(setq org-capture-bookmark nil)

(with-eval-after-load 'org

  (org-sticky-header-mode)
  (setq org-fontify-whole-heading-line t)

  (font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                         (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  (setq org-ellipsis "⬎")

  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (add-hook 'markdown-mode-hook (lambda () (variable-pitch-mode t)))
  (add-hook 'org-mode-hook (lambda () (variable-pitch-mode t)))

  (let* ((variable-tuple (cond ((x-list-fonts "Consolas") '(:font "Consolas"))
                             ((x-list-fonts "DejaVu Sans Mono for Powerline")   '(:font "DejaVu Sans Mono for Powerline"))
                             (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
  (base-font-color     (face-foreground 'default nil 'default))
  (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces 'user
                          `(markdown-header-level-1 ((t (,@headline ,@variable-tuple :height 1.5)))))

  (custom-theme-set-faces 'user
                       `(org-level-8 ((t (,@headline ,@variable-tuple))))
                       `(org-level-7 ((t (,@headline ,@variable-tuple))))
                       `(org-level-6 ((t (,@headline ,@variable-tuple))))
                       `(org-level-5 ((t (,@headline ,@variable-tuple))))
                       `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
                       `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
                       `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.35))))
                       `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
                       `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))

  (setq org-confirm-babel-evaluate t)
  (add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
)
  (setq org-goto-interface 'outline
      org-goto-max-level 10)
	(require 'imenu)
	(setq org-startup-folded nil)
	(bind-key "C-c j" 'org-clock-goto) ;; jump to current task from anywhere
	(bind-key "C-c C-w" 'org-refile)
	(setq org-cycle-include-plain-lists 'integrate)	

  (defun my/org-follow-entry-link ()
  "Follow the defined link for this entry."
  (interactive)
  (if (org-entry-get (point) "LINK")
      (org-open-link-from-string (org-entry-get (point) "LINK"))
    (org-open-at-point)))

(defun my/org-link-projects (location)
  "Add link properties between the current subtree and the one specified by LOCATION."
  (interactive
   (list (let ((org-refile-use-cache nil))
     (org-refile-get-location "Location"))))
  (let ((link1 (org-store-link nil)) link2)
    (save-window-excursion
      (org-refile 4 nil location)
      (setq link2 (org-store-link nil))
      (org-set-property "LINK" link1))
    (org-set-property "LINK" link2)))
 