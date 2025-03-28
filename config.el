(setq user-full-name "Edimar Calebe Castanho"
      user-mail-address "calebe94@disroot.org")

;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 32 :weight 'normal :style 'medium)
;;     doom-variable-pitch-font (font-spec :family "sans" :size 32))

(setq
    doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 22)
    doom-big-font (font-spec :family "JetBrainsMonoMedium Nerd Font" :size 22)
    doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 22)
    doom-serif-font (font-spec :family "JetBrainsMono Nerd Font" :size 22)
)
(custom-set-faces
 '(variable-pitch ((t (:family "JetBrains Mono")))))

(custom-set-faces!
  '(vertical-border :foreground "#81a2be")
  '(mode-line :box (:line-width 1 :color "#81a2be")))

(setq doom-theme 'doom-tomorrow-night)

;(load-theme 'doom-tomorrow-night t)

(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

;; (beacon-mode 1)

(setq display-line-numbers-type t)

(setq org-re-reveal-klipsify-src t)

;; Auto save buffers on focus lost
(add-function :after after-focus-change-function (lambda () (save-some-buffers t)))
;; Exit insert mode on focus loss
(add-function :after after-focus-change-function (lambda () (evil-normal-state)))

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

; Better default indent style
(setq custom-tab-width 4)
(setq-default c-basic-offset 4 tab-width 4 indent-tabs-mode nil)
(setq c-default-style "linux" c-basic-offset 4 tab-width 4)

;(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET
(setq-default electric-indent-inhibit t)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'disable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)

;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere
(defun markdown-html (buffer)
    (princ (with-current-buffer buffer
    (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://ndossougbe.github.io/strapdown/dist/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
    (current-buffer)))
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(after! org
  (setq org-directory "~/org/"
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "GYM(g)"            ; Things to accomplish at the gym
             "PROJ(p)"           ; A project that contains other tasks
             "VIDEO(v)"          ; Video assignments
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled

(defun adicionar-timestamp-amanha ()
  (interactive)
  (when (and (string= org-state "TODO")
             (not (org-entry-get nil "TIMESTAMP")))
    (end-of-line)
    (insert " <")
    (insert (format-time-string "%Y-%m-%d %a %H:%M" (time-add (current-time) (* 24 3600))))
    (insert ">")))

(add-hook 'org-after-todo-state-change-hook #'adicionar-timestamp-amanha)


(setq org-image-actual-width 400)

;; Follow org links with enter
(after! org
  (map! :map org-mode-map
        :n "RET" #'org-open-at-point
        :n "S-<return>" #'org-open-at-point))

(setq org-babel-sh-command "~/.sh_stderr.sh")

(defun org-link-copy (&optional arg)
  "Extract URL from org-mode link and add it to kill ring."
  (interactive "P")
  (let* ((link (org-element-lineage (org-element-context) '(link) t))
          (type (org-element-property :type link))
          (url (org-element-property :path link))
          (url (concat type ":" url)))
    (kill-new url)
    (message (concat "Copied URL: " url))))

;; (define-key org-mode-map (kbd "C-x C-l") 'org-link-copy)

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

;; Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fontify-natively t)
;; Don't prompt before running code in org
(setq org-confirm-babel-evaluate nil)
;; Fix an incompatibility between the ob-async and ob-ipython packages
(setq ob-async-no-async-languages-alist '("ipython"))

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "firefox")
;; (setq browse-url-browser-function #'browse-url-firefox)

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t)
)

(setq plantuml-jar-path "~/Downloads/plantuml-1.2023.13.jar")
(setq plantuml-default-exec-mode 'jar)

(setq org-plantuml-jar-path (expand-file-name "~/Downloads/plantuml-1.2023.13.jar"))
;; (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (ipython . t)
   (sh . t)
   (bash . t)
   (C . t)
   ;; Include other languages here...
   (plantuml . t)
   )
 )

(after! org-kanban
  :config
(defun org-kanban//link-for-heading (heading file description)
  "Create a link for a HEADING optionally USE-FILE a FILE and DESCRIPTION."
  (if heading
      (format "[[*%s][%s]]" heading description)
    (error "Illegal state")))
  )

(use-package! org-noter
  :config
  (setq
   org-noter-pdftools-markup-pointer-color "yellow"
   org-noter-notes-search-path '("~/org")
   ;; org-noter-insert-note-no-questions t
   org-noter-doc-split-fraction '(0.7 . 03)
   org-noter-always-create-frame nil
   org-noter-hide-other nil
   org-noter-pdftools-free-pointer-icon "Note"
   org-noter-pdftools-free-pointer-color "red"
   org-noter-kill-frame-at-session-end nil
   )
  (map! :map (pdf-view-mode)
        :leader
        (:prefix-map ("n" . "notes")
          :desc "Write notes"                    "w" #'org-noter)
        )
  )

(require 'org-bullets)(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(after! org
        (setq
                ;; org-agenda-files '("~/org/agenda.org")
                org-agenda-files (list "~/org/agenda/")
                org-archive-location "~/org/agenda-archive.org::* Archived Tasks"
                ;; org-archive-location (concat "~/org/agenda-archive.org::* Archived Tasks::"
                ;;                                 "* Archived Tasks"
                ;;                                 " :"
                ;;                                 (car org-archive-tag-preserve-whitespace)
                ;;                                 ":")
        )
)

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(use-package org-fancy-priorities
  :ensure t
  :hook
        (org-mode . org-fancy-priorities-mode)
  :config
        (setq
                org-fancy-priorities-list '("‼" "⬆" "⬇" "☕")
                org-priority-faces
                                '((?A :foreground "#ff6c6b" :weight bold)
                                (?B :foreground "#98be65" :weight bold)
                                (?C :foreground "#c678dd" :weight bold))
                                )
)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "customtag"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))

(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-file-format "%d-%m-%Y.org"
      )

(defun insert-emacs-lisp-block ()
  "Insere um bloco de código Emacs Lisp no formato org-mode."
  (interactive)
  (insert "#+begin_src emacs-lisp\n\n#+end_src")
  (forward-line -1))

(map! :leader
      (:prefix "i"
        :desc "Insert Emacs Lisp block" "b" #'insert-emacs-lisp-block))

;; Install org-present if needed
;; (unless (package-installed-p 'org-present)
;;   (package-install 'org-present))

;; Install visual-fill-column
;; (unless (package-installed-p 'visual-fill-column)
;;   (package-install 'visual-fill-column))

;; Configure fill width
(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

(defun my/org-present-prepare-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children))

(defun my/org-present-start ()
  ;; Tweak font sizes
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                     (header-line (:height 4.0) variable-pitch)
                                     (org-document-title (:height 1.75) org-document-title)
                                     (org-code (:height 1.0) org-code)
                                     (org-verbatim (:height 1.55) org-verbatim)
                                     (org-block (:height 1.25) org-block)
                                     (org-block-begin-line (:height 0.7) org-block)))

  ;; Set a blank header line string to create blank space at the top
  (setq header-line-format " ")

  ;; Display inline images automatically
  (org-display-inline-images)

  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (display-line-numbers-mode 0)
)

(defun my/org-present-end ()
  ;; Reset font customizations
  (setq-local face-remapping-alist '((default variable-pitch default)))

  ;; Clear the header line string so that it isn't displayed
  (setq header-line-format nil)

  ;; Stop displaying inline images
  (org-remove-inline-images)

  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  ;; (setq line-number-mode 1)
  (display-line-numbers-mode 1)
)

;; Register hooks with org-present
(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)
(add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)

;; Auto-rename new eww buffers
(defun xah-rename-eww-hook ()
  "Rename eww browser's buffer so sites open in new page."
  (rename-buffer "eww" t))
(add-hook 'eww-mode-hook #'xah-rename-eww-hook)

;; Enable emojify on startup
(use-package! emojify
  :hook (after-init . global-emojify-mode))

(use-package org-ai
  :ensure t
  :commands (org-ai-mode
             org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode) ; enable org-ai in org-mode
  (org-ai-global-mode) ; installs global keybindings on C-c M-a
  :config
  (setq org-ai-default-chat-model "gpt-3.5-turbo") ; if you are on the gpt-4 beta:
  (setq org-ai-openai-api-token "<REDACTED>")
  (org-ai-install-yasnippets)) ; if you are using yasnippet and want `ai` snippets

(setq warning-suppress-types '((org-element-cache)))

(defun check-update (file)
  "Check if the file needs to be updated."
  (let* ((threshold (- (float-time) 86400))  ; 86400 seconds = 1 day
         (file-mtime (float-time (nth 5 (file-attributes file))))
         (update (if (not (file-exists-p file))
                     t
                   (< file-mtime threshold))))
    (if update
        (cache-prompts))))

(defun cache-prompts ()
  "Cache prompts by downloading from the given URL."
  (url-copy-file "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv" "/tmp/prompts.csv"))

(defun remove-quotes (str)
  "Remove quotes from the given string."
  (replace-regexp-in-string "\"" "" str))

(defun list-prompts-acts ()
  "List prompts acts."
  (check-update "/tmp/prompts.csv")
  (with-temp-buffer
    (insert-file-contents "/tmp/prompts.csv")
    (goto-char (point-min))
    (forward-line)
    (while (not (eobp))
      (let ((line (split-string (buffer-substring (line-beginning-position) (line-end-position)) ",")))
        (message (remove-quotes (car line)))
        (forward-line)))))

(defun find-prompt-by-act (selected-prompt)
  "Find prompt by act."
  (with-temp-buffer
    (insert-file-contents "/tmp/prompts.csv")
    (goto-char (point-min))
    (forward-line)
    (while (not (eobp))
      (let ((line (split-string (buffer-substring (line-beginning-position) (line-end-position)) ",")))
        (when (string= (remove-quotes (car line)) selected-prompt)
          (let ((prompt ""))
            (dolist (elem (cdr line))
              (setq prompt (concat prompt elem)))
            (message prompt)))
        (forward-line)))))

;; Função para abrir uma conexão SSH para um host específico
(defun ssh-to-host (username host)
  (interactive)
  (require 'em-tramp) ;; Certifique-se de que o pacote em-tramp seja carregado antes de usar tramp
  (let ((default-directory (format "/sshx:%s@%s:/home/%s/" username host username)))
    (eshell)))

;; Função para selecionar e abrir uma conexão SSH para um host
(defun ssh-to-selected-host ()
  (interactive)
  (let ((chosen-host (completing-read "Choose host: " '("magalu" "magalu-pc" "calebe.dev.br"))))
    (cond ((string-equal chosen-host "magalu")
           (ssh-to-host "calebe" "magalu"))
          ((string-equal chosen-host "magalu-pc")
           (ssh-to-host "calebe94" "magalu-pc"))
          ((string-equal chosen-host "calebe.dev.br")
           (ssh-to-host "calebe94" "calebe.dev.br"))
        )))

;; Mapeie a função ssh-to-selected-host para a combinação de teclas SPC o s
(map! :leader
      :desc "SSH to host"
      "o s" #'ssh-to-selected-host)
;; (company-mode -1)

(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil  ;; Not supported by company capf
        lsp-pyls-plugins-flake8-enabled t
        lsp-pyls-plugins-pycodestyle-enabled nil
        lsp-pyls-plugins-mccabe-enabled nil
        lsp-pyls-plugins-pyflakes-enabled nil)
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)))
  :hook
  ((sh-mode . lsp)
   (python-mode . lsp)
   (c-mode . lsp)
   (c++-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration)))

(use-package lsp-ui
  :config
  (setq lsp-ui-sideline-show-hover t
        lsp-ui-sideline-delay 0.5
        lsp-ui-doc-delay 5
        lsp-ui-sideline-ignore-duplicates t
        lsp-ui-doc-position 'bottom
        lsp-ui-doc-alignment 'frame
        lsp-ui-doc-header nil
        lsp-ui-doc-include-signature t
        lsp-ui-doc-use-childframe t)
  :commands lsp-ui-mode
  :bind (:map evil-normal-state-map
              ("gd" . lsp-ui-peek-find-definitions)
              ("gr" . lsp-ui-peek-find-references)))

(use-package pyvenv
  :demand t
  :config
  (setq pyvenv-workon "emacs")  ; Default venv
  (pyvenv-tracking-mode 1))  ; Automatically use pyvenv-workon via dir-locals

;;; C Language Configuration
;; Prevent namespace indentation in C/C++
(c-set-offset 'innamespace 0)
;; Disable formatting with LSP, use clang-format instead
(setq +format-with-lsp nil)

(after! eglot
  :config
  (add-hook 'python-mode-hook (lambda ()
                                (add-hook 'before-save-hook 'py-autopep8-buffer nil 'local)))
  (add-hook 'f90-mode-hook 'eglot-ensure)
  (set-eglot-client! 'cc-mode '("clangd" "-j=3" "--clang-tidy"))
  (set-eglot-client! 'python-mode '("pylsp"))
  ;; (when (string= (system-name) "blah"))
)

;;; Hooks to inhibit LSP features during company completion
(add-hook 'company-completion-started-hook
          (lambda (&rest _)
            (setq-local lsp-inhibit-lsp-hooks t)
            (lsp--capf-clear-cache))
          nil
          t)

;;; Disable on-type formatting globally for LSP
(use-package-hook! lsp-mode
  :post-config
  (setq lsp-enable-on-type-formatting nil))

;; Configuração do fzf
(use-package fzf
  :ensure t  ;; Assegura que o pacote será instalado se ainda não estiver
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        fzf/grep-command "grep -nrH"
        fzf/position-bottom t
        fzf/window-height 15))

;; Função para obter o diretório atual do buffer dired
(defun my-dired-fzf ()
  "Open fzf with current dired directory as default path."
  (interactive)
  (require 'fzf)
  (let ((default-directory (dired-current-directory)))
    (fzf/start)))

;; Mapeamento para chamar my-dired-fzf com SPC f z
(map! :map dired-mode-map
      :localleader
      :desc "fzf in dired"
      "z" #'my-dired-fzf)

;; Mapeamento personalizado com prefixo SPC m
;; (map! :leader
;;       :prefix "m"
;;       :desc "fzf"
;;       "z" #'fzf)
(map! :n "C-c C-b" #'my-format-bold
      :n "C-c C-i" #'my-format-italic
      :n "C-c C-s" #'my-format-strikethrough)

(defun my-format-bold ()
  (interactive)
  (insert "**")
  (save-excursion
    (insert "**")))

(defun my-format-italic ()
  (interactive)
  (insert "*")
  (save-excursion
    (insert "*")))

(defun my-format-strikethrough ()
  (interactive)
  (insert "~~")
  (save-excursion
    (insert "~~")))

;; Funções para adicionar formatação a itens de lista em Markdown
(defun my-format-markdown-bold ()
  "Adiciona negrito ao item da lista atual em Markdown."
  (interactive)
  (save-excursion
    (let ((item (thing-at-point 'line t)))
      (beginning-of-line)
      (delete-region (point) (line-end-position))
      (insert (format "**%s**" item)))))

(defun my-format-markdown-italic ()
  "Adiciona itálico ao item da lista atual em Markdown."
  (interactive)
  (save-excursion
    (let ((item (thing-at-point 'line t)))
      (beginning-of-line)
      (delete-region (point) (line-end-position))
      (insert (format "*%s*" item)))))

(defun my-format-markdown-strikethrough ()
  "Adiciona tachado ao item da lista atual em Markdown."
  (interactive)
  (save-excursion
    (let ((item (thing-at-point 'line t)))
      (beginning-of-line)
      (delete-region (point) (line-end-position))
      (insert (format "~~%s~~" item)))))

;; Mapeia os atalhos para os comandos de formatação em Markdown
(map! :map markdown-mode-map
      :leader
      :desc "Italicize item in Markdown" "m i i" #'my-format-markdown-italic
      :desc "Bold item in Markdown" "m i b" #'my-format-markdown-bold
      :desc "Strikethrough item in Markdown" "m i s" #'my-format-markdown-strikethrough)

;; Funções para adicionar formatação a itens de lista em Org Mode
(defun my-format-org-bold ()
  "Adiciona negrito ao item da lista atual em Org Mode."
  (interactive)
  (save-excursion
    (let ((item (thing-at-point 'line t)))
      (beginning-of-line)
      (let ((line (thing-at-point 'line t)))
        (when (string-match "^\\+ \\([0-9]+\\..*\\)" line)
          (delete-region (point) (line-end-position))
          (insert (format "+ %s+" (match-string 1 line))))))))

(defun my-format-org-italic ()
  "Adiciona itálico ao item da lista atual em Org Mode."
  (interactive)
  (save-excursion
    (let ((item (thing-at-point 'line t)))
      (beginning-of-line)
      (let ((line (thing-at-point 'line t)))
        (when (string-match "^\\+ \\([0-9]+\\..*\\)" line)
          (delete-region (point) (line-end-position))
          (insert (format "/%s/" (match-string 1 line))))))))

(defun my-format-org-strikethrough ()
  "Adiciona tachado ao item da lista atual em Org Mode."
  (interactive)
  (save-excursion
    (let ((item (thing-at-point 'line t)))
      (beginning-of-line)
      (let ((line (thing-at-point 'line t)))
        (when (string-match "^\\+ \\([0-9]+\\..*\\)" line)
          (delete-region (point) (line-end-position))
          (insert (format "+ +%s+" (match-string 1 line))))))))

;; Função para remover qualquer formatação (negrito, itálico, tachado) do item da lista em Org Mode
(defun my-remove-org-formatting ()
  "Remove qualquer formatação (negrito, itálico, tachado) do item da lista atual em Org Mode."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((line (thing-at-point 'line t)))
      ;; Remove formatação de negrito
      (setq line (replace-regexp-in-string "\\*\\(.*?\\)\\*" "\\1" line))
      ;; Remove formatação de itálico
      (setq line (replace-regexp-in-string "/\\(.*?\\)/" "\\1" line))
      ;; Remove formatação de tachado
      (setq line (replace-regexp-in-string "\\+ \\(.*?\\)\\+" "\\1" line))
      ;; Remove espaços em excesso
      (setq line (replace-regexp-in-string "\\s-+$" "" line))
      (delete-region (point) (line-end-position))
      (insert line))))

;; Mapeia os atalhos para os comandos de formatação em Org Mode
(map! :map org-mode-map
      :leader
      :desc "Italicize item in Org" "m i i" #'my-format-org-italic
      :desc "Bold item in Org" "m i b" #'my-format-org-bold
      :desc "Strikethrough item in Org" "m i s" #'my-format-org-strikethrough
      :desc "Remove any formatting from item in Org" "m i r" #'my-remove-org-formatting)
