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

  (defun my/org-contacts-template-email (&optional return-value)
    "Try to return the contact email for a template.
  If not found return RETURN-VALUE or something that would ask the user."
    (or (cadr (if (gnus-alive-p)
                  (gnus-with-article-headers
                    (mail-extract-address-components
                     (or (mail-fetch-field "Reply-To") (mail-fetch-field "From") "")))))
        return-value
        (concat "%^{" org-contacts-email-property "}p")))


  (defvar my/org-basic-task-template "* TODO %^{Task}
:PROPERTIES:
:Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
:END:
Captured %<%Y-%m-%d %H:%M>
%?

%i
" "Basic task data")
  (setq org-capture-templates
        `(("t" "Tasks" entry
           (file+headline "~/Dropbox/org-life/organizer.org" "Inbox")
           ,my/org-basic-task-template)
          ("T" "Quick task" entry
           (file+headline "~/Dropbox/org-life/organizer.org" "Inbox")
           "* TODO %^{Task}\nSCHEDULED: %t\n"
           :immediate-finish t)
          ("i" "Interrupting task" entry
           (file+headline "~/Dropbox/org-life/organizer.org" "Inbox")
           "* STARTED %^{Task}"
           :clock-in :clock-resume)
          ("e" "Emacs idea" entry
           (file+headline "~/Dropbox/org-life/emacs-notes/tasks.org" "Emacs")
           "* TODO %^{Task}"
           :immediate-finish t)
          ("E" "Energy" table-line
           (file+headline "~/Dropbox/org-life/organizer.org" "Track energy")
           "| %U | %^{Energy 5-awesome 3-fuzzy 1-zzz} | %^{Note} |"
           :immediate-finish t
           )
          ("b" "Business task" entry
           (file+headline "~/Dropbox/org-life/business.org" "Tasks")
           ,my/org-basic-task-template)
          ("p" "People task" entry
           (file+headline "~/Dropbox/org-life/people.org" "Tasks")
           ,my/org-basic-task-template)
          ("j" "Journal entry" plain
           (file+datetree "~/Dropbox/org-life/journal.org")
           "%K - %a\n%i\n%?\n"
           :unnarrowed t)
          ("J" "Journal entry with date" plain
           (file+datetree+prompt "~/Dropbox/org-life/journal.org")
           "%K - %a\n%i\n%?\n"
           :unnarrowed t)
          ("s" "Journal entry with date, scheduled" entry
           (file+datetree+prompt "~/Dropbox/org-life/journal.org")
           "* \n%K - %a\n%t\t%i\n%?\n"
           :unnarrowed t)
          ("c" "Protocol Link" entry (file+headline ,org-default-notes-file "Inbox")
           "* [[%:link][%:description]] \n\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n%?\n\nCaptured: %U")
          ("db" "Done - Business" entry
           (file+headline "~/Dropbox/org-life/business.org" "Tasks")
           "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
          ("dp" "Done - People" entry
           (file+headline "~/Dropbox/org-life/people.org" "Tasks")
           "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
          ("dt" "Done - Task" entry
           (file+headline "~/Dropbox/org-life/organizer.org" "Inbox")
           "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
          ("q" "Quick note" item
           (file+headline "~/Dropbox/org-life/organizer.org" "Quick notes"))
          ("l" "Ledger entries")
          ("lm" "MBNA" plain
           (file "~/personal/ledger")
           "%(org-read-date) %^{Payee}
    Liabilities:MBNA
    Expenses:%^{Account}  $%^{Amount}
  " :immediate-finish t)
          ("ln" "No Frills" plain
           (file "~/personal/ledger")
           "%(let ((org-read-date-prefer-future nil)) (org-read-date)) * No Frills
    Liabilities:MBNA
    Assets:Wayne:Groceries  $%^{Amount}
  " :immediate-finish t)
          ("lc" "Cash" plain
           (file "~/personal/ledger")
           "%(org-read-date) * %^{Payee}
    Expenses:Cash
    Expenses:%^{Account}  %^{Amount}
  ")
          ("b" "Book" entry
           (file+datetree "~/Dropbox/org-life/books.org" "Inbox")
           "* %^{Title}  %^g
  %i
  *Author(s):* %^{Author} \\\\
  *ISBN:* %^{ISBN}

  %?

  *Review on:* %^t \\
  %a
  %U"
           :clock-in :clock-resume)
          ("B" "Bible" entry
           (file+datetree "~/Dropbox/org-life/bible.org" "Inbox")
           "* %^{Book}  %^g
  %i
  *Chapter(s):* %^{Chap} \\\\
  *Verse(s):* %^{Verses}

  %?

  *Read on:* %^t \\
  %a
  %U"
           :clock-in :clock-resume)
           ("C" "Contact" entry (file "~/Dropbox/org-life/contacts.org")
            "* %(org-contacts-template-name)
  :PROPERTIES:
  :EMAIL: %(my/org-contacts-template-email)
  :END:")
           ("n" "Daily note" table-line (file+olp "~/Dropbox/org-life/organizer.org" "Inbox")
            "| %u | %^{Note} |"
            :immediate-finish t)
           ("r" "Notes" entry
            (file+datetree "~/Dropbox/org-life/organizer.org")
            "* %?\n\n%i\n%U\n"
            )))

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
 
(defun my/org-refile-and-jump ()
  (interactive)
  (if (derived-mode-p 'org-capture-mode)
      (org-capture-refile)
    (call-interactively 'org-refile))
  (org-refile-goto-last-stored))
(eval-after-load 'org-capture
  '(bind-key "C-c C-r" 'my/org-refile-and-jump org-capture-mode-map))

(setq org-reverse-note-order t)
(setq org-refile-use-outline-path nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-use-cache nil)
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 3))))
(setq org-blank-before-new-entry nil)

;; Example: (org-refile 4 nil (my/org-refile-get-location-by-substring "Other Emacs"))
(defun my/org-refile-get-location-by-substring (regexp &optional file)
  "Return the refile location identified by REGEXP."
  (let ((org-refile-targets org-refile-targets) tbl)
    (setq org-refile-target-table (org-refile-get-targets)))
  (unless org-refile-target-table
    (user-error "No refile targets"))
  (cl-find regexp org-refile-target-table
           :test
           (lambda (a b)
             (and
              (string-match a (car b))
              (or (null file)
                  (string-match file (elt b 1)))))))
(defun my/org-refile-subtree-to (name)
  (org-refile nil nil (my/org-refile-get-location-exact name)))

 (defun my/org-refile-get-location-exact (name &optional file)
  "Return the refile location identified by NAME."
  (let ((org-refile-targets org-refile-targets) tbl)
    (setq org-refile-target-table (org-refile-get-targets)))
  (unless org-refile-target-table
    (user-error "No refile targets"))
  (cl-find name org-refile-target-table
           :test (lambda (a b)
                 (and (string-equal a (car b))
              (or (null file)
                  (string-match file (elt b 1)))))))
;; Example: (my/org-clock-in-refile "Off my computer")
 (defun my/org-clock-in-refile (location &optional file)
  "Clocks into LOCATION.
LOCATION and FILE can also be regular expressions for `my/org-refile-get-location-by-substring'."
  (interactive (list (my/org-refile-get-location)))
  (save-window-excursion
    (save-excursion
      (if (stringp location) (setq location (my/org-refile-get-location-by-substring location file)))
      (org-refile 4 nil location)
      (org-clock-in))))

 (defun my/org-finish-previous-task-and-clock-in-new-one (location &optional file)
  (interactive (list (my/org-refile-get-location)))
  (save-window-excursion
    (org-clock-goto)
    (org-todo 'done))
  (my/org-clock-in-and-track-by-name location file))

(defun my/org-clock-in-and-track-by-name (location &optional file)
  (interactive (list (my/org-refile-get-location)))
  (save-window-excursion
    (save-excursion
      (if (stringp location) (setq location (my/org-refile-get-location-exact location file)))
      (org-refile 4 nil location)
      (my/org-clock-in-and-track))))
(defun my/org-off-my-computer (category)
  (interactive "MCategory: ")
  (my/org-clock-in-refile "Off my computer")
  (quantified-track category))

(defun my/org-jump ()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (call-interactively 'org-refile)))
