
;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
;; Utilities for integrating Windows and Linux.


(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(javascript
     helm
     evil-commentary
     (evil-snipe :variables
                    evil-snipe-enable-alternate-f-and-t-behaviors t)
     (auto-completion :variables
                         auto-completion-return-key-behavior 'complete
                         auto-completion-tab-key-behavior 'complete
                         auto-completion-enable-snippets-in-popup t)
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     (clojure :variables
              clojure-enable-fancify-symbols nil)
     (python :variables
             python-sort-imports-on-save t
             python-test-runner 'pytest)

     emacs-lisp
     evernote
     spotify
     twitter
     deft
     osx
     ranger
     better-defaults
     ;;git
     ;;github
     ;;version-control
     markdown
     org
     (colors :variables
              colors-enable-nyan-cat-progress-bar t )
     ;;(restclient :variables
     ;;            restclient-use-org t)
     ;; spotify
     (shell :variables
            shell-default-shell 'multi-term
            shell-default-height 30
            shell-default-position 'bottom)
     ;;(version-control :variables
     ;;                 version-control-global-margin t
     ;;                 version-control-diff-tool 'git-gutter+)
     ;; xkcd
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
                                      ;;sublimity
                                      mic-paren
                                      solarized-theme
                                      ;; org-sticky-header
                                      ;; org-plus-contrib
                                      ;; org-gcal
                                      org-ref
                                      ;; calfw
                                      yasnippet-snippets
                                      interleave
                                      helm-bibtex
                                      beacon
                                      smart-mode-line
                                      lispy
                                      ;; sunshine
                                      4clojure
                                      ;; Org
                                      ;; org-vcard                ; Import/export google contacts
                                      org-projectile
                                      undo-tree
                                      ;; Misc
                                      ;;helm-spotify-plus        ; Spotify improvements
                                      virtualenvwrapper        ; Python environment management

     )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(spaceline magit tramp)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https nil
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'nil
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((projects . 5)
                                (bookmarks . 5)
                                (recents . 10)
                                )
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-light
                         leuven)

   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
 ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default              dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (setq custom-file "~/.emacs.d/private/.custom-settings.el")
  (setq sml/no-confirm-load-theme t)
  (sml/setup)
  (beacon-mode 1)
  (setq epa-file-encrypt-to '("jgraham20@gmail.com"))

  (setq user-full-name "Jason Graham"
        user-mail-address "jgraham20@gmail.com")

  (setq sunshine-location "Bowling Green,KY")

  ;; Add a directory to our load path so that when you `load` things
  ;; below, Emacs knows where to look for the corresponding file.
  ;;(add-to-list 'load-path "~/.spacemacs.d/local/")
  (add-to-list 'load-path "~/Dropbox/.secret/secret.el")

  (load "~/Dropbox/.secret/secret.el")

  ;; Sets up exec-path-from shell
  ;; https://github.com/purcell/exec-path-from-shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

  ;; Key binding to use "hippie expand" for text autocompletion
  ;; http://www.emacswiki.org/emacs/HippieExpand
  (global-set-key (kbd "M-/") 'hippie-expand)

  ;; Lisp-friendly hippie expand
  (setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

  (setq cider-repl-display-help-banner nil)

  ;; yasnippet
  ;; http://www.emacswiki.org/emacs/Yasnippet
  (setq yas-snippet-dirs
        '("~/.spacemacs.d/snippets"                 ;; personal snippets
          ))

  (yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

  (setq reftex-default-bibliography '("~/Notes/references/references.bib"))

  ;; see org-ref for use of these variables
  (setq org-ref-bibliography-notes "~/Notes/references/notes.org"
        org-ref-default-bibliography '("~/Notes/references/references.bib")
        org-ref-pdf-directory "~/Notes/references/pdfs/")

  (setq bibtex-completion-bibliography "~/Notes/references/references.bib"
        bibtex-completion-library-path "~/Notes/references/pdfs/"
        bibtex-completion-notes-path "~/Notes/references/helm-bibtex-notes")

  ;; open pdf with system pdf viewer (works on mac)
  (setq bibtex-completion-pdf-open-function
        (lambda (fpath)
          (start-process "open" "*open*" "open" fpath)))

  ;; alternative
  ;; (setq bibtex-completion-pdf-open-function 'org-open-file)

  ;; yay rainbows!
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (global-set-key (kbd "M-p") 'ace-window)
  (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
  (define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)

  (setq blink-matching-paren nil)
  (paren-activate)
  (setq paren-match-face 'mode-line)
  (menu-bar-mode 1)

  (setq projectile-indexing-method 'native)
  (setq multi-term-program "/usr/bin/zsh")
  (if (memq window-system '(w32))
    'module/system/w32)

  (setq neo-smart-open t)
  (setq projectile-switch-project-action 'neotree-projectile-action)

  ;; (module/misc/gnus)
  ;; (module/misc/mail)
  (module/configure-magit)
  (module/configure-eshell)
  (module/org)

)

(defun endless/4clojure-check-and-proceed ()
  "Check the answer and show the next question if it worked."
  (interactive)
  (unless
      (save-excursion
        ;; Find last sexp (the answer).
        (goto-char (point-max))
        (forward-sexp -1)
        ;; Check the answer.
        (cl-letf ((answer
                   (buffer-substring (point) (point-max)))
                  ;; Preserve buffer contents, in case you failed.
                  ((buffer-string)))
          (goto-char (point-min))
          (while (search-forward "__" nil t)
            (replace-match answer))
          (string-match "failed." (4clojure-check-answers))))
    (4clojure-next-question)))

(defadvice 4clojure/start-new-problem
    (after endless/4clojure/start-new-problem-advice () activate)
  ;; Prettify the 4clojure buffer.
  (goto-char (point-min))
  (forward-line 2)
  (forward-char 3)
  (fill-paragraph)
  ;; Position point for the answer
  (goto-char (point-max))
  (insert "\n\n\n")
  (forward-char -1)
  ;; Define our key.
  (local-set-key (kbd "M-j") #'endless/4clojure-check-and-proceed))

;;;; W32 Settings
(defun module/system/w32 ()
  (module/display/windows-frame-size-fix)
  (setq dotspacemacs-smooth-scrolling nil)
  (clipmon-mode-start)
  )

;;; Python
(defun module/python ()
  (require 'python)
  (module/python/fixes)
  (module/python/mypy)
  (module/python/venvs))

(defun module/org ()
  (with-eval-after-load 'org

    (setq org-modules '(
                      org-habit
                      org-mouse
                      org-protocol
                      org-annotate-file
                      org-eval
                      org-expiry
                      org-interactive-query
                      org-collector
                      org-panel
                      org-screen
                      org-toc))

    (module/org/babel)
    (module/org/misc)
    (module/org/templates)
    (module/org/weekly-review)
    (jsg/configure-org-mode)
    (module/org/mobile)
    (module/org/org-projects)
    ))

(defun jsg/configure-org-mode ()
  (require 'org-checklist)

  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (add-hook 'org-mode-hook 'flyspell-mode)

  ;; settings
  (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|org\\.txt\\)$" . org-mode))
  (setq org-startup-indented t)
  (setq org-cycle-separator-lines 1)
  (setq org-blank-before-new-entry '((heading . t) (plain-list-item . nil)))
  (setq org-agenda-file-regexp "\\`[^.].*\\.\\(org\\.txt\\|org\\)\\'")
  (setq org-clock-idle-time 15)
  ;; (setq org-ellipsis " ▼") ;; http://endlessparentheses.com/changing-the-org-mode-ellipsis.html

  ;; todos
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

  (setq org-todo-state-tags-triggers
        (quote (("CANCELLED" ("CANCELLED" . t))
                ("WAITING" ("WAITING" . t))
                ("HOLD" ("WAITING") ("HOLD" . t))
                (done ("WAITING") ("HOLD"))
                ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

  ;; organizer directory
  (if (memq window-system '(w32))
      (setq jsg/home-dir "C:/Users/jg186074")
      (setq jsg/home-dir (expand-file-name "~")))

  (setq org-directory "~/Notes/")
  (setq org-default-notes-file "~/Notes/organizer.org")
  (setq jsg/org-default-habits-file "~/Notes/habits.org")

  ;; agenda
  (setq org-agenda-files (list org-directory))
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)

  ;; tags
  ;; Tags with fast selection keys
  (setq org-tag-alist (quote ((:startgroup)** Ignore Tableu tickets in queue.
                              ** Windows AD gives access to all machines.
                              ("@errand" . ?e)
                              ("@office" . ?o)
                              ("@home" . ?h)
                              ("@writing" . ?w)
                              ("@errands" . ?e)
                              ("@drawing" . ?d)
                              ("@coding" . ?c)
                              ("kaizen" . ?k)
                              ("@phone" . ?p)
                              ("@reading" . ?r)
                              ("@computer" . ?l)
                              ("quantified" . ?q)
                              ("fuzzy" . ?0)
                              ("highenergy" . ?1)
                              (:endgroup)
                              ("WAITING" . ?W)
                              ("HOLD" . ?H)
                              ("IDEA" . ?I)
                              ("PERSONAL" . ?P)
                              ("DRAFT" . ?D)
                              ("NOTE" . ?N)
                              ("CANCELLED" . ?C)
                              ("FLAGGED" . ??))))

    ;; refiling
    (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                     (org-agenda-files :maxlevel . 9))))

    ;; pomodoro
    (add-hook 'org-pomodoro-finished-hook (lambda()
                                            (org-journal-new-entry nil)
                                            ))

    '(org-agenda-files
     (quote
       ("~/Notes/church.org"
        "~/Notes/organizer.org")))

    (setq org-agenda-text-search-extra-files '(agenda-archives))

  	(setq org-blank-before-new-entry (quote ((heading) (plain-list-item))))

  	(setq org-enforce-todo-dependencies t)

  	(setq org-log-done (quote time))

  	(setq org-log-redeadline (quote time))

  	(setq org-log-reschedule (quote time))

    (load "org-mouse")
    (require 'org-bullets)
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

    (setq org-html-checkbox-type 'unicode)
    (setq org-html-checkbox-types
      '((unicode (on . "<span class=\"task-done\">&#x2611;</span>")
                 (off . "<span class=\"task-todo\">&#x2610;</span>")
                 (trans . "<span class=\"task-in-progress\">[-]</span>"))))

    ;; Agenda
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

    ;;Dependecies
    (setq org-columns-default-format "%14SCHEDULED %Effort{:} %1PRIORITY %TODO %50ITEM %TAGS")
    (setq org-enforce-todo-dependencies t)
    (setq org-track-ordered-property-with-tag t)
    (setq org-agenda-dim-blocked-tasks t)

    ;;Refile
    (setq org-reverse-note-order t)
    (setq org-refile-use-outline-path nil)
    (setq org-refile-allow-creating-parent-nodes 'confirm)
    (setq org-refile-use-cache nil)
    (setq org-refile-targets '((org-agenda-files . (:maxlevel . 3))))
    (setq org-blank-before-new-entry nil)

    ;; Time Tracking
    (setq org-expiry-inactive-timestamps t)
    (setq org-clock-idle-time nil)
    (setq org-log-done 'time)
    (setq org-clock-continuously nil)
    (setq org-clock-persist t)
    (setq org-clock-in-switch-to-state "STARTED")
    (setq org-clock-in-resume nil)
    (setq org-show-notification-handler 'message)
    (setq org-clock-report-include-clocking-task t)
    (setq org-log-into-drawer "LOGBOOK")
    (setq org-clock-into-drawer 1)

    )

;;;; Prettify-magit
(defun module/configure-magit ())

;;;; Prettify-magit
(defun module/configure-theme ()
  ;; Get color-theme-solarized working. It is specified as an additional package
  ;; above. First we setup some theme modifications - we must do this *before*
  ;; we load the theme. Note that the color-theme-solarized package appears in
  ;; the list of themes as plain old 'solarized'.
  (setq theming-modifications
        '((sanityinc-solarized-light
           ;; Provide a sort of "on-off" modeline whereby the current buffer has a nice
           ;; bright blue background, and all the others are in cream.
           ;; TODO: Change to use variables here. However, got error:
           ;; (Spacemacs) Error in dotspacemacs/user-config: Wrong type argument: stringp, pd-blue
           (mode-line :foreground "#839496" :background "#eee8d5" :inverse-video nil)
           (powerline-active1 :foreground "#839496" :background "#eee8d5" :inverse-video nil)
           (powerline-active2 :foreground "#839496" :background "#eee8d5" :inverse-video nil)
           (mode-line-inactive :foreground "#839496" :background "#eee8d5" :inverse-video nil)
           (powerline-inactive1 :foreground "#839496" :background "#eee8d5" :inverse-video nil)
           (powerline-inactive2 :foreground "#839496" :background "#eee8d5" :inverse-video nil)
           ;; Make a really prominent helm selection line.
           (helm-selection :foreground "white" :background "red" :inverse-video nil)
           ;; See comment above about dotspacemacs-colorize-cursor-according-to-state.
           (cursor :background "#b58900")
         ))

        )

  (set-terminal-parameter nil 'background-mode 'light)
  (set-frame-parameter nil 'background-mode 'light)
  (spacemacs/load-theme 'sanityinc-solarized-light)

  ;; Highlights matching parenthesis
  (show-paren-mode 1)
  (fancy-battery-mode)
  ;; Highlight current line
  (global-hl-line-mode 1))

;;;; Shell
(defun module/misc/shell ()
  "Quick eshell with vim interaction."

  (defun my-spacemacs/shell-pop-eshell ()
    (interactive)
    (spacemacs/shell-pop-eshell nil)
    (if (string= major-mode "eshell-mode")
			(evil-insert 1)
      (evil-escape)))

  (evil-global-set-key 'normal (kbd "C-e") 'my-spacemacs/shell-pop-eshell)
  (evil-global-set-key 'insert (kbd "C-e") 'my-spacemacs/shell-pop-eshell)

  ;; Enables Python shell to print unicode
  ;; TODO might have to make this pyvenv hook
  (setenv "PYTHONIOENCODING" "utf-8")
  (setenv "LANG" "en_US.UTF-8"))

(defun module/configure-eshell ()
  "Eshell prettification."

  (setq eshell-prompt-number 0)
  (add-hook 'eshell-exit-hook (lambda () (setq eshell-prompt-number 0)))
  (advice-add 'eshell-send-input :before
              (lambda (&rest args)
                (setq eshell-prompt-number (+ 1 eshell-prompt-number))))

  (defmacro with-face (STR &rest PROPS)
    "Return STR propertized with PROPS."
    `(propertize ,STR 'face (list ,@PROPS)))

  (defun set-eshell-prompt-icon (ICON PROPS)
    "Update eshell prompt with ICON propertized with PROPS."
    (let ((prompt (concat ICON " ")))
      (setq eshell-prompt-regexp prompt)
      (concat "\n" (with-face prompt PROPS))))

  (defun eshell-section (ICON STR &rest PROPS)
    "Return eshell section string with ICON header for STR with PROPS."
    (when STR
      (with-face (concat ICON " " STR) PROPS)))

  (defun esh-prompt-function ()
    "Custom `eshell-prompt-function'."
    (let* ((esh-header "\n ")
           (esh-header-face nil)
           (esh-prompt "")
           (esh-prompt-face nil)
           (esh-sep " | ")
           (esh-sep-face nil)

           (esh-dir-section (abbreviate-file-name (eshell/pwd)))
           (esh-dir-face nil)

           (esh-git-section (magit-get-current-branch))
           (esh-git-face nil)

           (esh-venv-section pyvenv-virtual-env-name)
           (esh-venv-face nil)

           (esh-time-section (format-time-string "%H:%M" (current-time)))
           (esh-time-face nil)

           (esh-prompt-num-section (number-to-string eshell-prompt-number))
           (esh-prompt-num-face nil)

           (esh-sections (list
                          (eshell-section "" esh-dir-section esh-dir-face)
                          (eshell-section "" esh-git-section esh-git-face)
                          (eshell-section "" esh-venv-section esh-venv-face)
                          (eshell-section "" esh-time-section esh-time-face)
                          (eshell-section "" esh-prompt-num-section esh-prompt-num-face))))
      (concat
       (with-face esh-header esh-header-face)
       (s-join (with-face esh-sep esh-sep-face)
               (-non-nil esh-sections))
       (set-eshell-prompt-icon esh-prompt esh-prompt-face))))

  (setq eshell-prompt-function 'esh-prompt-function))

;;;; Babel
(defun module/org/babel ()
  "Org babel languages and config."

  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t  ; Otherwise python is painful
        org-src-window-setup 'current-window)  ; `, ,` opens in same window
  (org-babel-do-load-languages
   'org-babel-load-languages '((python .  t)
                               (haskell . t)
                               (clojure . t)
                               (restclient . t)
                               (dot .     t)  ; Graphviz
                               (http .    t)  ; Requests
                               )))

;;;; Org-mobile
(defun module/org/mobile ()

    (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
    (setq org-mobile-inbox-for-pull "~/Notes/mobileorg.org")
    (setq default-buffer-file-coding-system 'utf-8)
    (setq org-mobile-files '("~/Notes/organizer.org"
                             "~/Notes/church.org"
                             "~/Notes/todo.org"))
    (setq org-mobile-agendas '("a"))
)

;;;; Misc
(defun module/org/misc ()
  "Misc org-mode bindings and improvements."

  ;; Header property ignore for true no-export of header and its contents
  (with-eval-after-load 'ox-extra
    (ox-extras-activate '(ignore-headlines)))

  ;; Quick refile of project tasks
  (setq org-refile-targets
        '((nil :regexp . "Week of")))

  ;; Hide all org-blocks, including src, quote, etc. blocks, on buffer load
  (defvar org-blocks-hidden nil)
  (defun org-toggle-blocks ()
    (interactive)
    (if org-blocks-hidden
        (org-show-block-all)
      (org-hide-block-all))
    (setq-local org-blocks-hidden (not org-blocks-hidden)))

  (add-hook 'org-mode-hook 'org-toggle-blocks)
  (define-key org-mode-map (kbd "C-c t") 'org-toggle-blocks)

  ;; Enable flyspell in org-mode
  (add-hook 'org-mode-hook 'flyspell-mode)

  ;; Outline style navigation
  (evil-define-key '(normal visual motion) org-mode-map
    "gh" 'outline-up-heading
    "gj" 'outline-forward-same-level
    "gk" 'outline-backward-same-level
    "gl" 'outline-next-visible-heading
    "gu" 'outline-previous-visible-heading))

;;;; Templates
(defun module/org/templates ()

  ;; Org Capture Templates

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
  (defvar my/org-basic-work-task-template "* TODO %^{Task}
:PROPERTIES:
:Client:
:Ticket:
:END:
Captured %<%Y-%m-%d %H:%M>
%?

%i\"
" "Basic task data")

  (setq org-capture-templates
        `(("t" "Tasks" entry
           (file+headline "~/Notes/organizer.org" "Inbox")
           ,my/org-basic-task-template)
          ("T" "Quick task" entry
           (file+headline "~/Notes/organizer.org" "Inbox")
           "* TODO %^{Task}\nSCHEDULED: %t\n"
           :immediate-finish t)
          ("i" "Interrupting task" entry
           (file+headline "~/Notes/organizer.org" "Inbox")
           "* STARTED %^{Task}"
           :clock-in :clock-resume)
          ("e" "Idea" entry
           (file+headline "~/Notes/tasks.org" "Idea")
           "* TODO %^{Task}"
           :immediate-finish t)
          ("E" "Energy" table-line
           (file+headline "~/Notes/organizer.org" "Track energy")
           "| %U | %^{Energy 5-awesome 3-fuzzy 1-zzz} | %^{Note} |"
           :immediate-finish t
           )
          ("w" "Work task" entry
           (file+headline "~/Notes/organizer.org" "Tasks")
           ,my/org-basic-work-task-template)
          ("p" "People task" entr
           (file+headline "~/Notes/people.org" "Tasks")
           ,my/org-basic-task-template)
          ("j" "Journal entry" plain
           (file+datetree "~/Notes/journal.org")
           "%K - %a\n%i\n%?\n"
           :unnarrowed t)
          ("J" "Journal entry with date" plain
           (file+datetree+prompt "~/Notes/journal.org")
           "%K - %a\n%i\n%?\n"
           :unnarrowed t)
          ("s" "Journal entry with date, scheduled" entry
           (file+datetree+prompt "~/Notes/journal.org")
           "* \n%K - %a\n%t\t%i\n%?\n"
           :unnarrowed t)
          ("c" "Protocol Link" entry (file+headline ,org-default-notes-file "Inbox")
           "* [[%:link][%:description]] \n\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n%?\n\nCaptured: %U")
          ("db" "Done - Business" entry
           (file+headline "~/Notes/business.org" "Tasks")
           "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
          ("dp" "Done - People" entry
           (file+headline "~/Notes/people.org" "Tasks")
           "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
          ("dt" "Done - Task" entry
           (file+headline "~/Notes/organizer.org" "Inbox")
           "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
          ("q" "Quick note" item
           (file+headline "~/Notes/organizer.org" "Quick notes"))
          ("B" "Book" entry
           (file+datetree "~/Notes/books.org" "Inbox")
           "* %^{Title}  %^g
  %i
  *Author(s):* %^{Author} \\\\
  *ISBN:* %^{ISBN}

  %?

  *Review on:* %^t \\
  %a
  %U"
           :clock-in :clock-resume)
           ("C" "Contact" entry (file "~/Notes/contacts.org")
            "* %(org-contacts-template-name)
  :PROPERTIES:
  :EMAIL: %(my/org-contacts-template-email)
  :END:")
           ("n" "Daily note" table-line (file+olp "~/Notes/organizer.org" "Inbox")
            "| %u | %^{Note} |"
            :immediate-finish t)
           ("r" "Notes" entry
            (file+datetree "~/Notes/organizer.org")
            "* %?\n\n%i\n%U\n"
            )))
  (bind-key "C-M-r" 'org-capture)

  "Org-babel template code-block expansions."

  (mapc (lambda (x) (add-to-list 'org-structure-template-alist x))
        (list
         ;; Name block
         '("n" "#+NAME: ?")
         ;; Language Blocks
         '("c" "#+BEGIN_SRC clojure\n\n#+END_SRC")
         '("e" "#+BEGIN_SRC emacs-lisp\n\n#+END_SRC")
         '("l" "#+BEGIN_SRC lisp\n\n#+END_SRC")
         '("h" "#+BEGIN_SRC haskell\n\n#+END_SRC")
         '("p" "#+BEGIN_SRC python\n\n#+END_SRC")
         ;; Graphviz Block
         '("d" "#+BEGIN_SRC dot\n\n#+END_SRC")
         ;; Collapse previous header by default in themed html export
         '("clps" ":PROPERTIES:\n :HTML_CONTAINER_CLASS: hsCollapsed\n :END:\n")
         )))

;;;; Org project management
(defun module/org/org-projects ()

  (defun my/org-show-active-projects ()
    "Show my current projects."
    (interactive)
    (org-tags-view nil "project-inactive-someday"))

    (defun my/org-agenda-project-agenda ()
      "Return the project headline and up to `my/org-agenda-limit-items' tasks."
      (save-excursion
        (let* ((marker (org-agenda-new-marker))
               (heading
                (org-agenda-format-item "" (org-get-heading) (org-get-category) nil))
               (org-agenda-restrict t)
               (org-agenda-restrict-begin (point))
               (org-agenda-restrict-end (org-end-of-subtree 'invisible))
               ;; Find the TODO items in this subtree
               (list (org-agenda-get-day-entries (buffer-file-name) (calendar-current-date) :todo)))
          (org-add-props heading
              (list 'face 'defaults
                    'done-face 'org-agenda-done
                    'undone-face 'default
                    'mouse-face 'highlight
                    'org-not-done-regexp org-not-done-regexp
                    'org-todo-regexp org-todo-regexp
                    'org-complex-heading-regexp org-complex-heading-regexp
                    'help-echo
                    (format "mouse-2 or RET jump to org file %s"
                            (abbreviate-file-name
                             (or (buffer-file-name (buffer-base-buffer))
                                 (buffer-name (buffer-base-buffer))))))
            'org-marker marker
            'org-hd-marker marker
            'org-category (org-get-category)
            'type "tagsmatch")
          (concat heading "\n"
                  (org-agenda-finalize-entries list))))

    (defun jump-to-org-agenda ()
      (interactive)
      (let ((buf (get-buffer "*Org Agenda*"))
            wind)
        (if buf
            (if (setq wind (get-buffer-window buf))
                (select-window wind)
              (if (called-interactively-p)
                  (progn
                    (select-window (display-buffer buf t t))
                    (org-fit-window-to-buffer)
                    ;; (org-agenda-redo)
                    )
                (with-selected-window (display-buffer buf)
                  (org-fit-window-to-buffer)
                  ;; (org-agenda-redo)
                  )))
          (call-interactively 'org-agenda-list))))

      (defun my/org-agenda-projects-and-tasks (match)
        "Show TODOs for all `org-agenda-files' headlines matching MATCH."
        (interactive "MString: ")
        (let ((todo-only nil))
          (if org-agenda-overriding-arguments
              (setq todo-only (car org-agenda-overriding-arguments)
                    match (nth 1 org-agenda-overriding-arguments)))
          (let* ((org-tags-match-list-sublevels
                  org-tags-match-list-sublevels)
                 (completion-ignore-case t)
                 rtn rtnall files file pos matcher
                 buffer)
            (when (and (stringp match) (not (string-match "\\S-" match)))
              (setq match nil))
            (when match
              (setq matcher (org-make-tags-matcher match)
                    match (car matcher) matcher (cdr matcher)))
            (catch 'exit
              (if org-agenda-sticky
                  (setq org-agenda-buffer-name
                        (if (stringp match)
                            (format "*Org Agenda(%s:%s)*"
                                    (or org-keys (or (and todo-only "M") "m")) match)
                          (format "*Org Agenda(%s)*" (or (and todo-only "M") "m")))))
              (org-agenda-prepare (concat "TAGS " match))
              (org-compile-prefix-format 'tags)
              (org-set-sorting-strategy 'tags)
              (setq org-agenda-query-string match)
              (setq org-agenda-redo-command
                    (list 'org-tags-view `(quote ,todo-only)
                          (list 'if 'current-prefix-arg nil `(quote ,org-agenda-query-string))))
              (setq files (org-agenda-files nil 'ifmode)
                    rtnall nil)
              (while (setq file (pop files))
                (catch 'nextfile
                  (org-check-agenda-file file)
                  (setq buffer (if (file-exists-p file)
                                   (org-get-agenda-file-buffer file)
                                 (error "No such file %s" file)))
                  (if (not buffer)
                      ;; If file does not exist, error message to agenda
                      (setq rtn (list
                                 (format "ORG-AGENDA-ERROR: No such org-file %s" file))
                            rtnall (append rtnall rtn))
                    (with-current-buffer buffer
                      (unless (derived-mode-p 'org-mode)
                        (error "Agenda file %s is not in `org-mode'" file))
                      (save-excursion
                        (save-restriction
                          (if org-agenda-restrict
                              (narrow-to-region org-agenda-restrict-begin
                                                org-agenda-restrict-end)
                            (widen))
                          (setq rtn (org-scan-tags 'my/org-agenda-project-agenda matcher todo-only))
                          (setq rtnall (append rtnall rtn))))))))
              (if org-agenda-overriding-header
                  (insert (org-add-props (copy-sequence org-agenda-overriding-header)
                              nil 'face 'org-agenda-structure) "\n")
                (insert "Headlines with TAGS match: ")
                (add-text-properties (point-min) (1- (point))
                                     (list 'face 'org-agenda-structure
                                           'short-heading
                                           (concat "Match: " match)))
                (setq pos (point))
                (insert match "\n")
                (add-text-properties pos (1- (point)) (list 'face 'org-warning))
                (setq pos (point))
                (unless org-agenda-multi
                  (insert "Press `C-u r' to search again with new search string\n"))
                (add-text-properties pos (1- (point)) (list 'face 'org-agenda-structure)))
              (org-agenda-mark-header-line (point-min))
              (when rtnall
                (insert (mapconcat 'identity rtnall "\n") ""))
              (goto-char (point-min))
              (or org-agenda-multi (org-agenda-fit-window-to-buffer))
              (add-text-properties (point-min) (point-max)
                                   `(org-agenda-type tags
                                                     org-last-args (,todo-only ,match)
                                                     org-redo-cmd ,org-agenda-redo-command
                                                     org-series-cmd ,org-cmd))
              (org-agenda-finalize)
              (setq buffer-read-only t)))))))

;; Weekly Reviews
(defun module/org/weekly-review ()

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
             (format "  - *Woodwork* (%.1fh)\n"
                     (my/quantified-get-hours "Discretionary - Productive - Woodwork" time-summary))
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
                                   (file+headline "~/Notes/organizer.org" "Tasks")
                                   "")))
          (org-capture nil "t")
          (insert "TODO " task "\nSCHEDULED: <" (org-read-date) ">")))


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
  )

(defun module/org/timetracking()

    (defvar my/org-quantified-categories
    '(("Business"
       ("Earn" . "Business - Earn")
       ("Connect" . "Business - Connect")
       ("Build" . "Business - Build"))
      ("Discretionary"
       ("Social" . "Discretionary - Social")
       ("Productive" . "Discretionary - Productive")
       ("Woodwork" . "Discretionary - Productive - Woodwork")
       ("Writing" . "Discretionary - Productive - Writing")
       ("Reading" . "Discretionary - Productive - Reading")
       ("Emacs" . "Discretionary - Productive - Emacs")
       ("Play" . "Discretionary - Play"))
      ("Personal"
       ("Routines" . "Personal - Routines"))
      ("Sleep" nil))
    "Categories for time summary.")

  (defun my/org-summarize-time-use (&optional start end)
    (require 'quantified)
    (interactive (list (org-read-date) (org-read-date)))
    (let ((time-summary (quantified-summarize-time start end))
          (categories my/org-quantified-categories)
          result)
      (setq result
            (mapconcat
             (lambda (a)
               (if (assoc (car a) time-summary)
                   (concat
                    (format "- %s: %.1f hours" (car a) (/ (cdr (assoc (car a) time-summary)) 3600.0))
                    (if (cdr a)
                        (let ((detail
                               (delq nil
                                     (mapcar (lambda (b)
                                               (if (assoc (cdr b) time-summary)
                                                   (format "%s: %.1f"
                                                           (car b)
                                                           (/ (cdr (assoc (cdr b) time-summary)) 3600.0))
                                                 nil))
                                             (cdr a)))))
                          (if detail
                              (concat " (" (mapconcat 'identity detail ", ") ")")
                            ""))
                      "")
                    (if (string-equal (car a) "Sleep")
                        (format " - average of %.1f hours per day" (/ (cdr (assoc (car a) time-summary)) 3600.0 7.0))
                      "")
                    "\n")))
       categories ""))
      (if (called-interactively-p 'any)
        (insert result)
        result)))
    (defun my/org-summarize-upcoming-week ()
      "Summarize upcoming tasks as a list."
      (interactive)
      (org-agenda nil "w")
      (let ((string (buffer-string))
            business relationships life)
        (with-temp-buffer
          (insert string)
          (goto-char (point-min))
          (while (re-search-forward my/weekly-review-line-regexp nil t)
            (cond
             ((string= (match-string 1) "routines") nil) ; skip routine tasks
             ((string= (match-string 1) "business")
              (add-to-list 'business (concat "  - [ ] " (match-string 3))))
             ((string= (match-string 1) "people")
              (add-to-list 'relationships (concat "  - [ ] " (match-string 3))))
             (t (add-to-list 'life (concat "  - [ ] " (match-string 3)))))))
        (setq string
              (concat
          "*Plans for next week*\n"
          "- Business\n"
          (mapconcat 'identity business "\n")
          "\n- Relationships\n"
          (mapconcat 'identity relationships "\n")
          "\n- Life\n"
          (mapconcat 'identity life "\n")))
        (if (called-interactively-p)
            (kill-new string)
          string)))

      (defun my/org-summarize-previous-week ()
      "Summarize previously-completed tasks as a list."
      (interactive)
      (save-window-excursion
        (org-agenda nil "w")
        (org-agenda-later -1)
        (org-agenda-log-mode 16)
        (let ((string (buffer-string))
              business relationships life)
          (with-temp-buffer
            (insert string)
          (goto-char (point-min))
          (while (re-search-forward my/weekly-review-line-regexp nil t)
            (cond
             ((string= (match-string 1) "routines") nil) ; skip routine tasks
             ((string= (match-string 1) "business")
              (add-to-list 'business (concat "  - " (match-string 2))))
             ((string= (match-string 1) "people")
              (add-to-list 'relationships (concat "  - " (match-string 2))))
             (t (add-to-list 'life (concat "  - " (match-string 2)))))))
        (setq string
              (concat
               "*Accomplished this week*\n\n"
               "- Business\n"
               (mapconcat 'identity business "\n")
               "\n- Relationships\n"
               (mapconcat 'identity relationships "\n")
               "\n- Life\n"
               (mapconcat 'identity life "\n")))
        (if (called-interactively-p)
            (kill-new string)
          string))))

    (defun my/quantified-compare (start1 end1 start2 end2 &optional categories label1 label2)
    "Return a table comparing the times for START1 - END1 and START2 - END2."
    (let* ((start2 (org-read-date nil nil (or start2 "-sat")))
           (end2 (org-read-date nil nil (or end2 "+1")))
           (start1 (org-read-date nil nil (or start1 "-4sat")))
           (end1 (org-read-date nil nil (or end1 "-sat")))
           (time2 (quantified-summarize-time start2 end2))
           (time1 (quantified-summarize-time start1 end1))
           (label1 (or label1 "Period 1 %"))
           (label2 (or label2 "Period 2 %"))
           (total2 (* 0.01 (- (org-time-string-to-seconds end2) (org-time-string-to-seconds start2))))
           (total1 (* 0.01 (- (org-time-string-to-seconds end1) (org-time-string-to-seconds start1))))
           (keys (or categories (-union (mapcar 'car time1) (mapcar 'car time2)))))
      ;; Build a list comparing the two
      (append
      `(("Category" ,label1 ,label2 "Diff" "h/wk" "Diff h/wk"))
      (mapcar (lambda (key)
                (list
                 key
                 (format "%.1f" (/ (or (assoc-default key time1) 0) total1))
                 (format "%.1f" (/ (or (assoc-default key time2) 0) total2))
                 (format "%.1f" (- (/ (or (assoc-default key time2) 0) total2)
                                   (/ (or (assoc-default key time1) 0) total1)))
                 (format "%.1f" (* (/ (or (assoc-default key time2) 0) total1) 1.68))
                 (format "%.1f"
                         (* (- (/ (or (assoc-default key time2) 0) total2)
                               (/ (or (assoc-default key time1) 0) total1)) 1.68))
                 )) keys))))
  )

;;;; Aspell
(defun module/misc/aspell ()
  "Setup aspell."
  (setq ispell-program-name "aspell"))

;;;; Gnus
(defun module/misc/gnus ()

  ;; Get email, and store in nnml
  (setq gnus-secondary-select-methods
  '(
    (nnimap "gmail"
             (nnimap-address
              "imap.gmail.com")
             (nnimap-server-port 993)
             (nnimap-stream ssl))
    ))

  ;; Send email via Gmail:
  (setq message-send-mail-function 'smtpmail-send-it
    smtpmail-default-smtp-server "smtp.gmail.com")

  ;; Archive outgoing email in Sent folder on imap.gmail.com:
  (setq gnus-message-archive-method '(nnimap "imap.gmail.com")
      gnus-message-archive-group "[Gmail]/Sent Mail")

  ;; set return email address based on incoming email address
  (setq gnus-posting-styles
      '(((header "to" "address@outlook.com")
         (address "address@outlook.com"))
    ((header "to" "address@gmail.com")
       (address "address@gmail.com"))))

  ;; store email in ~/gmail directory
  (setq nnml-directory "~/gmail")
  (setq message-directory "~/gmail"))

;;;; mu4e
(defun module/misc/mail ()

  ;; default
  (setq mu4e-maildir "~/Maildir/Gmail")

  (setq mu4e-drafts-folder "/[Gmail].Drafts")
  (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
  (setq mu4e-trash-folder  "/[Gmail].Trash")

  ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  (setq mu4e-sent-messages-behavior 'delete)

  ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
  ;; additional non-Gmail addresses and want assign them different
  ;; behavior.)

  ;; setup some handy shortcuts
  ;; you can quickly switch to your Inbox -- press ``ji''
  ;; then, when you want archive some messages, move them to
  ;; the 'All Mail' folder by pressing ``ma''.

  (setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[Gmail].Sent Mail"   . ?s)
         ("/[Gmail].Trash"       . ?t)
         ("/[Gmail].All Mail"    . ?a)))

  ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-get-mail-command "offlineimap")

  ;; something about ourselves
  (setq
     user-mail-address "jgraham20@gmail.com"
     user-full-name  "Jason Graham"
     mu4e-compose-signature
      (concat
        "Jason Graham\n"
        "--\n"))

  (require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
     starttls-use-gnutls t
     smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
     smtpmail-auth-credentials
       '(("smtp.gmail.com" 587 "jgraham20@gmail.com" nil))
     smtpmail-default-smtp-server "smtp.gmail.com"
     smtpmail-smtp-server "smtp.gmail.com"
     smtpmail-smtp-service 587)

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t))

;;;; Windows-pytest
(defun module/python/windows-pytest ()
  "Pytest is broken on Windows. Basic functionality is provided for Windows."

  (defun ek-pytest-module ()
    (interactive)
    (shell-command (format "py.test -x -s %s&" buffer-file-name)))

  (defun ek-pytest-one ()
    (interactive)
    (save-excursion
      (let ((test-name
             (progn
               (re-search-backward "^[ ]*def \\(test_[a-zA-Z0-9_]*\\)")
               (match-string 1))))
        (shell-command
         (format "py.test -x -s %s::%s&" buffer-file-name test-name)))))

  (spacemacs/set-leader-keys-for-major-mode
    'python-mode (kbd "t m") 'ek-pytest-module)
  (spacemacs/set-leader-keys-for-major-mode
    'python-mode (kbd "t t") 'ek-pytest-one))

;;;; Python Fixes
(defun module/python/fixes ()
  "Various python bugfixes."

  ;; Sometimes ipython shells trigger a bad error to popup
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_")))

  ;; No log output in pytests
  ;; (setq pytest-cmd-flags "-x --no-print-logs")
  (setq pytest-cmd-flags "-x -s")

  ;; Remove flyspell from python buffers
  (dolist (hook '(python-mode-hook))
    (add-hook hook (lambda () (flyspell-mode -1)))))

;;;; Mypy
(defun module/python/mypy ()
  "Enable mypy flycheck integration in-tandem with pylint."

  (flycheck-define-checker
      python-mypy ""
      :command ("mypy"
                "--ignore-missing-imports" "--fast-parser"
                "--python-version" "3.6"
                source-original)
      :error-patterns
      ((error line-start (file-name) ":" line ": error:" (message) line-end))
      :modes python-mode)

  (add-to-list 'flycheck-checkers 'python-mypy t)
  (flycheck-add-next-checker 'python-pylint 'python-mypy t))

;;;; Venvs
(defun module/python/venvs ()
  "Initialize virtual environment management for Python."

  (require 'virtualenvwrapper)
  (pyvenv-mode 1)

  ;; Fixes hy-mode environment when pyvenv is activated
  (add-hook 'pyvenv-post-activate-hooks 'python/init-hy-mode)

  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

;;; Blog  FIXME
(defun module/blog ()

  (setq blog-dir "~/dev/blog"
        public-blog-dir "~/dev/public-blog"
        hugo-process "Hugo Server"
        hugo-server-site "http://localhost:1313/")

  (defun deploy-blog ()
    "Run hugo and push changes upstream from anywhere."
    (interactive)
    (let ((original-dir default-directory)
          (run-hugo (concat "hugo -d " public-blog-dir)))
      (cd blog-dir)
      (shell-command run-hugo)
      (cd public-blog-dir)

      (shell-command "git add .")
      (shell-command (concat "git commit -m \"" (current-time-string) "\""))
      (magit-push-current-to-upstream nil)

      (cd original-dir)))

  (defun start-blog-server ()
    "Run hugo server if not already running and open its webpage."
    (interactive)
    (let ((original-dir default-directory))
      (unless (get-process hugo-process)
        (cd blog-dir)
        (start-process hugo-process nil "hugo" "server")
        (cd original-dir))

      (browse-url hugo-server-site)))

  (defun end-blog-server ()
    "End hugo server process if running."
    (interactive)
    (--when-let (get-process hugo-process)
      (delete-process it)))

  (spacemacs/set-leader-keys (kbd "ab") 'deploy-blog)
  (spacemacs/set-leader-keys (kbd "aa") 'start-blog-server)
  (spacemacs/set-leader-keys (kbd "ae") 'end-blog-server))
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ghub+ apiwrap ghub gitignore-mode gh marshal logito pcache ht magit magit-popup org-ref pdf-tools key-chord tablist yasnippet-snippets interleave helm-bibtex biblio parsebib biblio-core yapfify xterm-color ws-butler winum which-key web-beautify volatile-highlights virtualenvwrapper vi-tilde-fringe uuidgen use-package unfill twittering-mode toc-org symon string-inflection spotify solarized-theme smeargle smart-mode-line shell-pop sayid reveal-in-osx-finder restclient-helm restart-emacs ranger rainbow-mode rainbow-identifiers rainbow-delimiters pyvenv pytest pyenv-mode py-isort popwin pip-requirements persp-mode pcre2el pbcopy password-generator paradox osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-download org-bullets org-brain open-junk-file ob-restclient ob-http neotree mwim multi-term move-text mmm-mode mic-paren markdown-toc magithub magit-gitflow magit-gh-pulls macrostep lorem-ipsum livid-mode live-py-mode lispy linum-relative link-hint launchctl json-mode js2-refactor js-doc info+ indent-guide ibuffer-projectile hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-spotify helm-pydoc helm-purpose helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot github-search github-clone gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gist gh-md geeknote fuzzy flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-org evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-args evil-anzu eshell-z eshell-prompt-extras esh-help elisp-slime-nav editorconfig dumb-jump diff-hl deft cython-mode company-tern company-statistics company-restclient company-anaconda column-enforce-mode color-identifiers-mode coffee-mode clojure-snippets clj-refactor clean-aindent-mode cider-eval-sexp-fu browse-at-remote beacon auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-link ace-jump-helm-line ac-ispell 4clojure))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
