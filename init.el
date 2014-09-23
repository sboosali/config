;;;;;;;;;;;;;;; INIT ;;;;;;;;;;;;;;;;;;;;;;
(require 'cl)

(setq HOME "/Users/sambo/.emacs.d/")

(defvar load-paths '(
 "structured-haskell-mode/elisp"
 "ghc-server/elisp"
 "hindent/elisp"
) "load paths that don't obey the normal package-name/module-name.el format.")

(add-to-list 'load-path HOME)
(add-to-list 'load-path (concat HOME "packages/"))
(add-to-list 'load-path (concat HOME "structured-haskell-mode/elisp/"))

(loop for location in load-paths
      do (add-to-list 'load-path (concat HOME location)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Packaging ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar packages
 '(starter-kit smex undo-tree magit solarized-theme smart-tabs-mode))

(dolist (p packages)
  (unless (package-installed-p p)
    (package-install p)))


;; (require 'shm)
;; (require 'hindent)
;; (require 'ghc)
;; (require 'shm-case-split)

;; (smex-initialize)
;; (turn-on-haskell-simple-indent)
;; (load "haskell-mode-autoloads.el")




;;;;;;;;;;;;;;; UTIL ;;;;;;;;;;;;;;;;;;;;;;
(defun cons! (x xs) ; ~ add-to-list
  (setq xs (cons x xs)))

(defun print-list (list)
  "Print each element of LIST on a line of its own."
  (while list
    (print (car list))
    (setq list (cdr list))))

(defun key (key act)
  (global-set-key key act))


;;;;;;;;;;;;;;; SETTINGS ;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-splash-screen t)

; hide menu bar
;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;;peek
(setq scroll-step 1)
(setq scroll-conservatively 10000)


(set-face-attribute 'default nil :height 140)

(setq keyboard-coding-system nil)
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(setq visible-bell t)

;font-size
;(set-face-attribute 'default nil :height 50)
;(set-frame-parameter nil 'font "Monospace-2")
(set-default-font "-apple-Monaco-medium-normal-normal-*-18-*-*-*-m-0-iso10646-1")

(set-background-color "gray")

;;   (set-background-color "black")
;;   (set-face-background 'default "black")
;;   (set-face-background 'region "black")
;;   (set-face-foreground 'default "white")
;;   (set-face-foreground 'region "gray60")
;;   (set-foreground-color "white")
;;   (set-cursor-color "red")

;; Prevent Emacs from extending file when
;; pressing down arrow at end of buffer.
(setq next-line-add-newlines nil)
;; Silently ensure newline at end of file
;; (setq require-final-newline t)
;; or make Emacs ask about missing newline
(setq require-final-newline nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;; SavePlace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'saveplace)

(setq-default save-place t)
;can't use setq because the variable is buffer-local.

(setq save-place-file "~/.emacs.d/saved-places")
;your saved places are written to this file


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Abbreviations ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; tell emacs where to read abbrev definitions from...
(setq abbrev-file-name "~/.emacs.d/.abbrev_defs")

;; save abbrevs when files are saved
;; you will be asked before the abbreviations are saved
(setq save-abbrevs t)
(if (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file))

;; keep it always on
;(setq default-abbrev-mode t)

;; turn it on sometimes
;(dolist (hook '(text-mode-hook python-mode-hook))
;  (add-hook hook (lambda () (abbrev-mode 1))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Deft ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'deft)

(setq deft-extension "txt")
(setq deft-directory "~/Dropbox/deft")

(setq deft-text-mode 'markdown-mode)

(global-set-key [f8] 'deft)


;;;;;;;;;;;;;;;;;;;;;;;; Smex ;;;;;;;;;;;;;;;;;;;;;;;;
; "Smex is a M-x enhancement for Emacs. Built on top of IDO, it provides a convenient interface to your recently and most frequently used commands."

;
(global-set-key [(meta x)] (lambda ()
 (interactive)
 (or (boundp 'smex-cache)
     (smex-initialize))
 (global-set-key [(meta x)] 'smex)
 (smex)))

;
(global-set-key [(shift meta x)] (lambda ()
 (interactive)
 (or (boundp 'smex-cache)
    (smex-initialize))
 (global-set-key [(shift meta x)] 'smex-major-mode-commands)
 (smex-major-mode-commands)))


;;;;;;;;;;;;;;;;;;;;;;;; PYTHON ;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smart-tabs-mode)

(defun my-python-mode-hook ()
  (smart-tabs-advice python-indent-line-1 python-indent)

  (setq tab-width 4)
  (setq py-indent-offset 4)

  (setq py-indent-offset tab-width)
  (setq python-indent tab-width)
  (setq py-smart-indentation nil)

  (setq-default show-trailing-whitespace t)
  ;(add-hook 'before-save-hook 'delete-trailing-whitespace)

  (setq py-indent-comments nil)
  (setq py-electric-comment-p nil)
)
(add-hook 'python-mode-hook 'my-python-mode-hook)


;;;;;;;;;;;;;;;;;;;;;;;; Templates ;;;;;;;;;;;;;;;;;;;;;;;;
;http://emacs-template.sourceforge.net/
(require 'template)
(template-initialize)

;$ mkdir ~/.templates/
;$ touch ~/.templates/TEMPLATE.hs.tpl
;$ ls ~/.templates/*.tpl

;M-x template-new-file
;M-x template-expand-template

;some standard embedded tags (note the parentheses):
;; (>>>POINT<<<)
;; (>>>FILE_SANS<<<)
;; (>>>DATE<<<)
;; (>>>USER_NAME<<<)

; defines the tag (>>>GUIID<<<)
;(add-to-list 'template-expansion-alist
; '("GUIID" (insert (substring (shell-command-to-string "uuidgen") 0 -1))))

;(add-to-list 'template-find-file-commands 'ido-exit-minibuffer)


;;;;;;;;;;;;;;;;;;;;;;;; NOTES ;;;;;;;;;;;;;;;;;;;;;;;;

;inline latex. inserts unicode.
(defun note-mode ()
  (when (string-match "\\.note$" buffer-file-name)
   (set-input-method "TeX")
   ;(comment-dwim ".")
))
(add-hook 'find-file-hook 'note-mode)


;;;;;;;;;;;;;;; ??? ;;;;;;;;;;;;;;;;;;;;;;
; I forget why
(defun set-exec-path-from-shell-path ()
  (let ((path-from-shell
         (replace-regexp-in-string
          "[[:space:]\n]*$"
          ""
          (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-path))
(set-exec-path-from-shell-path)


;; ;;;;;;;;;;;;;;; Haskell ;;;;;;;;;;;;;;;;;;;;;;
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-to-list 'auto-mode-alist '("\\.elm$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.curry$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.idr$" . haskell-mode))


;; ;;;;;;;;;;;;;;; Prolog ;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.pl$" . prolog-mode))


;; ;;;;;;;;;;;;;;; Scala ;;;;;;;;;;;;;;;;;;;;;;
;(add-to-list 'load-path (concat HOME ".emacs.d/scala-mode2/"))
;(require 'scala-mode2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Remote Access ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq tramp-default-method "ssh")


;;;;;;;;;;;;;;; Abbreviations ;;;;;;;;;;;;;;;;;;;;;;

(defun after-abbrev-expand-hook ()
  (when (looking-back "\"\"\\|''\\|()\\|\\[\\]\\|{}")
    (backward-char 1))
  t)
(put 'after-abbrev-expand-hook 'no-self-insert t)


;;;;;;;;;;;;;;; Terminal ;;;;;;;;;;;;;;;;;;;;;;
(require 'multi-term)

(setq multi-term-program "/bin/bash")

;; default (print-list term-bind-key-alist)
;; ("C-c C-c" . term-interrupt-subjob)
;; ("C-p" . previous-line)
;; ("C-n" . next-line)
;; ("C-s" . isearch-forward)
;; ("C-r" . isearch-backward)
;; ("C-m" . term-send-raw)
;; ("M-f" . term-send-forward-word)
;; ("M-b" . term-send-backward-word)
;; ("M-o" . term-send-backspace)
;; ("M-p" . term-send-up)
;; ("M-n" . term-send-down)
;; ("M-M" . term-send-forward-kill-word)
;; ("M-N" . term-send-backward-kill-word)
;; ("M-r" . term-send-reverse-search-history)
;; ("M-," . term-send-input)
;; ("M-." . comint-dynamic-complete)

;; default (print-list term-unbind-key-list)
;; "C-z"
;; "C-x"
;; "C-c"
;; "C-h"
;; "C-y"
;; "<ESC>"

(setq term-bind-key-alist '(
   ("C-c" . term-interrupt-subjob)

   ("<up>" . term-send-up)
   ("<down>" . term-send-down)

   ("C-r" . term-send-reverse-search-history)

   ("M-f" . term-send-forward-word)
   ("M-b" . term-send-backward-word)
   ("M-d" . term-send-forward-kill-word)
   ("M-DEL" . term-send-backward-kill-word)

   ("M-v" . term-paste)
))

(setq term-unbind-key-list '(
   "C-z"
   "C-x"
   "C-h"
   "C-y"
   "<ESC>"

   ; copy and paste
   "M-v"
   "M-c"
))

;unicode
;(set-terminal-coding-system 'utf-8-unix)
;(setq default-process-coding-system '((utf-8-unix . utf-8-unix)))

;;;;;;;;;;;;;;; transpar ;;;;;;;;;;;;;;;;;;;;;;
;transpose paragraphs
(require 'transpar)


;;;;;;;;;;;;;;; Windows ;;;;;;;;;;;;;;;;;;;;;;
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-S-<left>") 'windmove-left)
(global-set-key (kbd "C-S-<right>") 'windmove-right)


;;;;;;;;;;;;;;; Frames ;;;;;;;;;;;;;;;;;;;;;;
; full-screen the frame
; frames are called windows in other applications
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))


;;;;;;;;;;;;;;; Applications ;;;;;;;;;;;;;;;;;;;;;;

(defun server-app ()
 (server-start)
; undo with:
;  (server-force-delete)
)
(if (string-match "Emacs\\.app" (getenv "EMACSPATH"))
    (server-app))

(defun notes-app ()
  (find-file "~/Dropbox/.note")
  (end-of-buffer)
)
(if (string-match "Notes\\.app" (getenv "EMACSPATH"))
    (notes-app))

(defun obs-app ()
;  (find-file "~/Dropbox/.obs")
  (find-file "~/Dropbox/scratch")
  (next-line)
)
(if (string-match "Obs\\.app" (getenv "EMACSPATH"))
    (obs-app))

(defun diary-app ()
  (find-file "~/diary/sleep")
)
(if (string-match "Diary\\.app" (getenv "EMACSPATH"))
    (diary-app))

(defun work-app ()
  (find-file "~/Haskell")
  (find-file "~/TODO")
  (end-of-buffer)
  ;; (split-window-horizontally)
  ;; (find-file "/Users/sambo/Library/Application Support/LightTable/plugins/Claire/README.md")
  ;; (find-file "/Users/sambo/poc/README")
  ;; (other-window 1)
  ;; (find-file "~/poc_everything/example-lighttable-plugin/README.md")
)
(if (string-match "Work\\.app" (getenv "EMACSPATH"))
    (work-app))

(defun terminal-app ()
  (split-window-horizontally)
  (multi-term)
  (other-window 1)
  (multi-term)
  (other-window 1)
)
(if (string-match "Terminal\\.app" (getenv "EMACSPATH"))
    (terminal-app))


;;;;;;;;;;;;;;; AUTOSAVE ;;;;;;;;;;;;;;;;;;;;;;
;(setq auto-save-timeout 1)
;(setq auto-save-interval 20)

(run-with-idle-timer 3 t 'save-buffer)


;;;;;;;;;;;;;;; Shortucts ;;;;;;;;;;;;;;;;;;;;;;

(defun indent-and-next () (interactive)
  (move-beginning-of-line 1)
  (insert " ")
  (next-line)
  (move-beginning-of-line 1))
(global-set-key "\M-j" 'indent-and-next)

(defun kill-line-save () (interactive)
  (kill-line)
  (yank))
(global-set-key "\M-k" 'kill-line-save)

(defun force-kill-buffer () (interactive)
  (kill-buffer (buffer-name)))
(global-set-key "\C-x k" 'force-kill-buffer)

(defun delete-line ()
  "Deletes a line, but preserves the kill-ring."
  (interactive)
  (if (not (equal (point) (point-max))) ; end of buffer
      (kill-line)
    (setq kill-ring (cdr kill-ring))))

(defun new-note () (interactive)
  (end-of-buffer)
  (backward-paragraph)
  (forward-paragraph)
  (delete-line) (delete-line) (delete-line) (delete-line)
  (newline) (newline))
(global-set-key "\M-n" 'new-note)

(defun transpose-paragraph () (interactive)
 (backward-paragraph)
 (kill-paragraph)
 (backward-paragraph)
 (yank))
(global-set-key "\M-T" 'transpose-paragraph)

(global-set-key "\M-c" 'kill-ring-save)
(global-set-key "\M-v" 'yank)

(global-set-key "\M-x" 'kill-region)
(global-set-key "\C-w" 'execute-extended-command)

(global-set-key "\M-w" 'capitalize-word)

(global-set-key "\M-g" 'goto-line)

(global-set-key [(meta up)] 'beginning-of-buffer)
(global-set-key [(meta down)] 'end-of-buffer)

(global-set-key "\C-x\C-o" 'other-window)

(global-set-key "\M-q" 'save-buffers-kill-terminal)
(global-set-key "\C-xk" 'kill-this-buffer)
(global-set-key "\C-x\C-k" 'kill-this-buffer)
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\M-m" 'switch-to-buffer)
(global-set-key "\M-`" "\C-xb")
(global-set-key "\M-s" 'save-buffer)

(global-set-key "\C-\\" 'find-file)

(global-set-key "\M--" "\C-a-  -  -  -  -  -  -  -\C-o\C-a\C-n")
(global-set-key (kbd "M-0") nil)

(global-set-key "\M-i" 'ucs-insert)

(global-set-key [C-return] 'dabbrev-expand)
(global-set-key (kbd "<tab>") 'dabbrev-expand)

;(global-set-key (kbd "M-<escape>") 'kmacro-start-macro-or-insert-counter)
;(global-set-key (kbd "<escape>") 'kmacro-end-call-mouse)
;(global-set-key "\C-<right>" 'other-window) ;TODO 'windmove-* maybe?
;(global-set-key "\C-<right>" 'BACKWARDS-other-window)

(global-set-key "\M-r" 'query-replace-regexp)
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)

(global-set-key "\M-z" 'undo)


;;;;;;;;;;;;;;; Macros ;;;;;;;;;;;;;;;;;;;;;;
; from

