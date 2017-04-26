;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(setq org-default-notes-file "~/Dropbox/org-life/notes.org")
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-indent-mode t)

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
        ("dt" "Done - Task" entry
         (file+headline "~/Dropbox/org-life/organizer.org" "Inbox")
         "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
        ("q" "Quick note" item
         (file+headline "~/Dropbox/org-life/organizer.org" "Quick notes"))
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
        ("b" "Bible" entry
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

;;(with-eval-after-load 'org
   (setq org-use-effective-time t)

   (defun my/org-use-speed-commands-for-headings-and-lists ()
     "Activate speed commands on list items too."
     (or (and (looking-at org-outline-regexp) (looking-back "^\**"))
         (save-excursion (and (looking-at (org-item-re)) (looking-back "^[ \t]*")))))
   (setq org-use-speed-commands 'my/org-use-speed-commands-for-headings-and-lists)

(with-eval-after-load 'org
   (add-to-list 'org-speed-commands-user '("x" org-todo "DONE"))
   (add-to-list 'org-speed-commands-user '("y" org-todo-yesterday "DONE"))
   (add-to-list 'org-speed-commands-user '("!" my/org-clock-in-and-track))
   (add-to-list 'org-speed-commands-user '("s" call-interactively 'org-schedule))
   (add-to-list 'org-speed-commands-user '("d" my/org-move-line-to-destination))
   (add-to-list 'org-speed-commands-user '("i" call-interactively 'org-clock-in))
   (add-to-list 'org-speed-commands-user '("P" call-interactively 'org2blog/wp-post-subtree))
   (add-to-list 'org-speed-commands-user '("o" call-interactively 'org-clock-out))
   (add-to-list 'org-speed-commands-user '("$" call-interactively 'org-archive-subtree))
   ;;(bind-key "!" 'my/org-clock-in-and-track org-agenda-mode-map)

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
)
  ;;(let* ((variable-tuple (cond ((x-list-fonts "Consolas") '(:font "Consolas"))
  ;;                           ((x-list-fonts "DejaVu Sans Mono for Powerline")   '(:font "DejaVu Sans Mono for Powerline"))
  ;;                           (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
  ;;(base-font-color     (face-foreground 'default nil 'default))
  ;;(headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  ;;(custom-theme-set-faces 'user
  ;;                        `(markdown-header-level-1 ((t (,@headline ,@variable-tuple :height 1.5)))))

  ;;(custom-theme-set-faces 'user
  ;;                     `(org-level-8 ((t (,@headline ,@variable-tuple))))
  ;;                     `(org-level-7 ((t (,@headline ,@variable-tuple))))
  ;;                     `(org-level-6 ((t (,@headline ,@variable-tuple))))
  ;;                     `(org-level-5 ((t (,@headline ,@variable-tuple))))
  ;;                     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
  ;;                     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
  ;;                     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.35))))
  ;;                     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
  ;;                     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))

  (setq org-confirm-babel-evaluate t)
 ;; (add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
;;)
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

(setq org-todo-keywords
      '((sequence
         "TODO(t)"  ; next action
         "TOBLOG(b)"  ; next action
         "STARTED(s)"
         "WAITING(w@/!)"
         "SOMEDAY(.)" "|" "DONE(x!)" "CANCELLED(c@)")
        (sequence "LEARN" "TRY" "TEACH" "|" "COMPLETE(x)")
        (sequence "TOSKETCH" "SKETCHED" "|" "POSTED")
        (sequence "TOBUY" "TOSHRINK" "TOCUT"  "TOSEW" "|" "DONE(x)")
        (sequence "TODELEGATE(-)" "DELEGATED(d)" "|" "COMPLETE(x)")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "green" :weight bold))
        ("DONE" . (:foreground "cyan" :weight bold))
        ("WAITING" . (:foreground "red" :weight bold))
        ("SOMEDAY" . (:foreground "gray" :weight bold))))

(setq org-log-done 'time)

(setq org-tags-exclude-from-inheritance '("project"))

;;(add-to-list 'org-speed-commands-user '("N" org-narrow-to-subtree))
;;(add-to-list 'org-speed-commands-user '("W" widen))

(defun my/org-agenda-for-subtree ()
  (interactive)
  (when (derived-mode-p 'org-agenda-mode) (org-agenda-switch-to))
  (my/org-with-current-task
   (let ((org-agenda-view-columns-initially t))
     (org-agenda nil "t" 'subtree))))
;;(add-to-list 'org-speed-commands-user '("T" my/org-agenda-for-subtree))

(setq org-tag-alist '(("@work" . ?b)
                      ("@home" . ?h)
                      ("@writing" . ?w)
                      ("@errands" . ?e)
                      ("@learning" . ?d)
                      ("@coding" . ?c)
                      ("@improvement" . ?i)
                      ("@phone" . ?p)
                      ("@reading" . ?r)
                      ("@computer" . ?l)
                      ("@bible" . ?q)
                      ("@church" . ?1)))

;;(add-to-list 'org-global-properties
;;             '("Effort_ALL". "0:05 0:15 0:30 1:00 2:00 3:00 4:00"))

(use-package org
  :init
  (progn
    (setq org-expiry-inactive-timestamps t)
    (setq org-clock-idle-time nil)
    (setq org-log-done 'time)
    (setq org-clock-continuously nil)
    (setq org-clock-persist t)
    (setq org-clock-in-switch-to-state "STARTED")
    (setq org-clock-in-resume nil)
    (setq org-show-notification-handler 'message)
    (setq org-clock-report-include-clocking-task t))
  :config
  (org-clock-persistence-insinuate))

(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer 1)

(setq org-habit-graph-column 80)
(setq org-habit-show-habits-only-for-today nil)

(add-hook 'org-clock-in-prepare-hook
          'my/org-mode-ask-effort)

(defun my/org-mode-ask-effort ()
  "Ask for an effort estimate when clocking in."
  (unless (org-entry-get (point) "Effort")
    (let ((effort
           (completing-read
            "Effort: "
            (org-entry-get-multivalued-property (point) "Effort"))))
      (unless (equal effort "")
        (org-set-property "Effort" effort)))))

(defvar my/org-agenda-limit-items nil "Number of items to show in agenda to-do views; nil if unlimited.")
(eval-after-load 'org
  '(defadvice org-agenda-finalize-entries (around sacha activate)
     (if my/org-agenda-limit-items
         (progn
           (setq list (mapcar 'org-agenda-highlight-todo list))
           (setq ad-return-value
                 (subseq list 0 my/org-agenda-limit-items))
           (when org-agenda-before-sorting-filter-function
             (setq list (delq nil (mapcar org-agenda-before-sorting-filter-function list))))
           (setq ad-return-value
                 (mapconcat 'identity
                            (delq nil
                                  (subseq
                                   (sort list 'org-entries-lessp)
                                   0
                                   my/org-agenda-limit-items))
                            "\n")))
       ad-do-it)))

(setq org-enforce-todo-dependencies t)
(setq org-track-ordered-property-with-tag t)
(setq org-agenda-dim-blocked-tasks t)

(setq org-structure-template-alist
      '(("s" "#+begin_src ?\n\n#+end_src" "<src lang=\"?\">\n\n</src>")
        ("e" "#+begin_example\n?\n#+end_example" "<example>\n?\n</example>")
        ("q" "#+begin_quote\n?\n#+end_quote" "<quote>\n?\n</quote>")
        ("v" "#+BEGIN_VERSE\n?\n#+END_VERSE" "<verse>\n?\n</verse>")
        ("c" "#+BEGIN_COMMENT\n?\n#+END_COMMENT")
        ("p" "#+BEGIN_PRACTICE\n?\n#+END_PRACTICE")
        ("l" "#+begin_src emacs-lisp\n?\n#+end_src" "<src lang=\"emacs-lisp\">\n?\n</src>")
        ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
        ("h" "#+begin_html\n?\n#+end_html" "<literal style=\"html\">\n?\n</literal>")
        ("H" "#+html: " "<literal style=\"html\">?</literal>")
        ("a" "#+begin_ascii\n?\n#+end_ascii")
        ("A" "#+ascii: ")
        ("i" "#+index: ?" "#+index: ?")
        ("I" "#+include %file ?" "<include file=%file markup=\"?\">")))

(defun my/org-html-quote2 (block backend info)
  (when (org-export-derived-backend-p backend 'html)
    (when (string-match "\\`<div class=\"quote2\">" block)
      (setq block (replace-match "<blockquote>" t nil block))
      (string-match "</div>\n\\'" block)
      (setq block (replace-match "</blockquote>\n" t nil block))
      block)))
(eval-after-load 'ox
  '(add-to-list 'org-export-filter-special-block-functions 'my/org-html-quote2))

(setq org-agenda-span 2)
(setq org-agenda-tags-column -100) ; take advantage of the screen width
(setq org-agenda-sticky nil)
(setq org-agenda-inhibit-startup t)
(setq org-agenda-use-tag-inheritance t)
(setq org-agenda-show-log t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
(setq org-agenda-time-grid
      '((daily today require-timed)
        "----------------"
        (800 1000 1200 1400 1600 1800)))
(setq org-columns-default-format "%14SCHEDULED %Effort{:} %1PRIORITY %TODO %50ITEM %TAGS")

(defvar my/weekly-review-line-regexp
  "^  \\([^:]+\\): +\\(Sched[^:]+: +\\)?TODO \\(.*?\\)\\(?:[      ]+\\(:[[:alnum:]_@#%:]+:\\)\\)?[        ]*$"
  "Regular expression matching lines to include.")
(defvar my/weekly-done-line-regexp
  "^  \\([^:]+\\): +.*?\\(?:Clocked\\|Closed\\):.*?\\(TODO\\|DONE\\) \\(.*?\\)\\(?:[       ]+\\(:[[:alnum:]_@#%:]+:\\)\\)?[        ]*$"
  "Regular expression matching lines to include as completed tasks.")

(defun my/quantified-get-hours (category time-summary)
  "Return the number of hours based on the time summary."
  (if (stringp category)
      (if (assoc category time-summary) (/ (cdr (assoc category time-summary)) 3600.0) 0)
    (apply '+ (mapcar (lambda (x) (my/quantified-get-hours x time-summary)) category))))

(defun _my/extract-tasks-from-agenda (string matchers prefix line-re)
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (while (re-search-forward line-re nil t)
      (let ((temp-list matchers))
        (while temp-list
          (if (save-match-data
                (string-match (car (car temp-list)) (match-string 1)))
              (progn
                (add-to-list (cdr (car temp-list)) (concat prefix (match-string 3)) t)
                (setq temp-list nil)))
          (setq temp-list (cdr temp-list)))))))

(ert-deftest _my/extract-tasks-from-agenda ()
  (let (list-a list-b (line-re "\\([^:]+\\):\\( \\)\\(.*\\)"))
    (_my/extract-tasks-from-agenda
     "listA: Task 1\nother: Task 2\nlistA: Task 3"
     '(("listA" . list-a)
       ("." . list-b))
     "- [ ] "
     line-re)
    (should (equal list-a '("- [ ] Task 1" "- [ ] Task 3")))
    (should (equal list-b '("- [ ] Task 2")))))

(defun _my/get-upcoming-tasks ()
  (save-window-excursion
      (org-agenda nil "W")
      (_my/extract-tasks-from-agenda (buffer-string)
                                        '(("routines" . ignore)
                                          ("business" . business-next)
                                          ("people" . relationships-next)
                                          ("tasks" . emacs-next)
                                          ("." . life-next))
                                        "  - [ ] "
                                        my/weekly-review-line-regexp)))
(defun _my/get-previous-tasks ()
  (let (string)
    (save-window-excursion
      (org-agenda nil "W")
      (org-agenda-later -1)
      (org-agenda-log-mode 16)
      (setq string (buffer-string))
      ;; Get any completed tasks from the current week as well
      (org-agenda-later 1)
      (org-agenda-log-mode 16)
      (setq string (concat string "\n" (buffer-string)))
      (_my/extract-tasks-from-agenda string
                                        '(("routines" . ignore)
                                          ("business" . business)
                                          ("people" . relationships)
                                          ("tasks" . emacs)
                                          ("." . life))
                                        "  - [X] "
                                        my/weekly-done-line-regexp))))

(defun my/org-summarize-focus-areas (date)
  "Summarize previous and upcoming tasks as a list."
  (interactive (list (org-read-date-analyze (if current-prefix-arg (org-read-date) "-fri") nil '(0 0 0))))
  (let (business relationships life business-next relationships-next life-next string emacs emacs-next
                 start end time-summary biz-time ignore base-date)
    (setq base-date (apply 'encode-time date))
    (setq start (format-time-string "%Y-%m-%d" (days-to-time (- (time-to-number-of-days base-date) 6))))
    (setq end (format-time-string "%Y-%m-%d" (days-to-time (1+ (time-to-number-of-days base-date)))))
    (setq time-summary (quantified-summarize-time start end))
    (setq biz-time (my/quantified-get-hours "Business" time-summary))
    (_my/get-upcoming-tasks)
    (_my/get-previous-tasks)
    (setq string
          (concat
           (format "- *Business* (%.1fh - %d%%)\n" biz-time (/ biz-time 1.68))
           (mapconcat 'identity business "\n") "\n"
           (mapconcat 'identity business-next "\n")
           "\n"
           (format "  - *Earn* (%.1fh - %d%% of Business)\n"
                   (my/quantified-get-hours "Business - Earn" time-summary)
                   (/ (my/quantified-get-hours "Business - Earn" time-summary) (* 0.01 biz-time)))
           (format "  - *Build* (%.1fh - %d%% of Business)\n"
                   (my/quantified-get-hours "Business - Build" time-summary)
                   (/ (my/quantified-get-hours "Business - Build" time-summary) (* 0.01 biz-time)))
           (format "  - *Connect* (%.1fh - %d%% of Business)\n"
                   (my/quantified-get-hours "Business - Connect" time-summary)
                   (/ (my/quantified-get-hours "Business - Connect" time-summary) (* 0.01 biz-time)))
           (format "- *Relationships* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours '("Discretionary - Social"
                                                 "Discretionary - Family") time-summary)
                   (/ (my/quantified-get-hours '("Discretionary - Social"
                                                    "Discretionary - Family") time-summary) 1.68))
           (mapconcat 'identity relationships "\n") "\n"
           (mapconcat 'identity relationships-next "\n") "\n"
           "\n"
           (format "- *Discretionary - Productive* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours "Discretionary - Productive" time-summary)
                   (/ (my/quantified-get-hours "Discretionary - Productive" time-summary) 1.68))
           (format "  - *Drawing* (%.1fh)\n"
                   (my/quantified-get-hours '("Discretionary - Productive - Drawing")  time-summary))
           (format "  - *Emacs* (%.1fh)\n"
                   (my/quantified-get-hours "Discretionary - Productive - Emacs" time-summary))
           (mapconcat 'identity emacs "\n") "\n"
           (mapconcat 'identity emacs-next "\n") "\n"
           (format "  - *Coding* (%.1fh)\n"
                   (my/quantified-get-hours "Discretionary - Productive - Coding" time-summary))
           (mapconcat 'identity life "\n") "\n"
           (mapconcat 'identity life-next "\n") "\n"
           (format "  - *Sewing* (%.1fh)\n"
                   (my/quantified-get-hours "Discretionary - Productive - Sewing" time-summary))
           (format "  - *Writing* (%.1fh)\n"
                   (my/quantified-get-hours "Discretionary - Productive - Writing" time-summary))
           (format "- *Discretionary - Play* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours "Discretionary - Play" time-summary)
                   (/ (my/quantified-get-hours "Discretionary - Play" time-summary) 1.68))
           (format "- *Personal routines* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours "Personal" time-summary)
                   (/ (my/quantified-get-hours "Personal" time-summary) 1.68))
           (format "- *Unpaid work* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours "Unpaid work" time-summary)
                   (/ (my/quantified-get-hours "Unpaid work" time-summary) 1.68))
           (format "  - *Childcare* (%.1fh - %d%% of total)\n"
                   (my/quantified-get-hours '("Unpaid work - Childcare") time-summary)
                   (/ (my/quantified-get-hours '("Unpaid work - Childcare") time-summary) 1.68))
           (format "- *Sleep* (%.1fh - %d%% - average of %.1f per day)\n"
                   (my/quantified-get-hours "Sleep" time-summary)
                   (/ (my/quantified-get-hours "Sleep" time-summary) 1.68)
                   (/ (my/quantified-get-hours "Sleep" time-summary) 7)
                   )))
    (if (called-interactively-p 'any)
        (insert string)
      string)))

(defun my/org-add-line-item-task (task)
  (interactive "MTask: ")
  (org-insert-heading)
  (insert "[ ] " task)
  (let ((org-capture-entry '("t" "Tasks" entry
                             (file+headline "~/Dropbox/org-life/organizer.org" "Tasks")
                             "")))
    (org-capture nil "t")
    (insert "TODO " task "\nSCHEDULED: <" (org-read-date) ">")))
                                        ;(define-key org-mode-map (kbd "C-c t") 'my/org-add-line-item-task)

(defun my/org-prepare-weekly-review (&optional date skip-urls)
  "Prepare weekly review template."
  (interactive (list (org-read-date-analyze (if current-prefix-arg (org-read-date) "-fri") nil '(0 0 0))))
  (let ((base-date (apply 'encode-time date))
        start end links)
    (setq start (format-time-string "%Y-%m-%d" (days-to-time (- (time-to-number-of-days base-date) 6))))
    (setq end (format-time-string "%Y-%m-%d" (days-to-time (1+ (time-to-number-of-days base-date)))))
    (outline-next-heading)
    (insert
     "*** Weekly review: Week ending " (format-time-string "%B %e, %Y" base-date) "  :weekly:\n"
     "*Blog posts*\n\n"
     "*Sketches*\n\n"
     (my/sketches-export-and-extract start end) "\n"
     "\n\n*Focus areas and time review*\n\n"
     (my/org-summarize-focus-areas date)
     "\n")))

(defun my/org-review-month (start-date)
  "Review the month's clocked tasks and time."
  (interactive (list (org-read-date)))
  ;; Set to the beginning of the month
  (setq start-date (concat (substring start-date 0 8) "01"))
  (let ((org-agenda-show-log t)
        (org-agenda-start-with-log-mode t)
        (org-agenda-start-with-clockreport-mode t)
        (org-agenda-clockreport-parameter-plist '(:link t :maxlevel 3)))
    (org-agenda-list nil start-date 'month)))
