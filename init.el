;(cd "/Users/mac/")
;;(add-hook 'find-file-hook #'(lambda () (setq default-directory (expand-file-name "/Users/mac/"))))
;;(setenv "HOME" "~/")

;;(setq default-directory "/Users/mac/")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (htmlize ac-emacs-eclim)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;global set keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; set f1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "<f1>") 'list-buffers)

;; set f2 org-mode  C-c ' org-edit-special
(global-set-key (kbd "<f2>") 'org-edit-special)

(global-set-key (kbd "<f4>") 'org-edit-src-exit)

;; C-x C-f to ~/
;;(defun my-find-file ()
 ;; (interactive)
  ;;(let ((default-directory "/Users/mac/"))
   ;; (call-interactively #'find-file)))
;;(global-set-key (kbd "C-x C-f") 'my-find-file)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key (kbd "<f2>") 'save-buffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  f3 = eval-last-sexp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f3>") 'eval-last-sexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  f4 = dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-dired-mode()
;;   (interactive)
;;   (dired "~/emacs_lisp"))
;; (global-set-key (kbd "<f4>") 'org-edit-src-exit)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; f5 = open init.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun open-my-init-file()
 (interactive)
 (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f5>") 'open-my-init-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; f6 = auto-fill-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f6>") 'auto-fill-mode)
(setq default-fill-column 85)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; f7 = flyspell-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flyspell-mode
(setq ispell-program-name "/usr/local/bin/ispell")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f7>") 'flyspell-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f8>") 'eval-buffer)
(global-set-key (kbd "<f9>") 'eval-last-sexp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 滚动栏去掉
(scroll-bar-mode nil)
;; 行号
(setq line-number-mode t)
(setq column-number-mode t)
;; 设置缩进


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setq package-archives
;;      '(("gnu"    . "https://elpa.emacs-china.org/gnu/")
;;	("melpa"  . "https://elpa.emacs-china.org/melpa/")))


(setq package-archives
      '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
	("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))



(defun elisp-transcript ()
  "Make an Emacs Lisp interactive transcript.

In a new buffer, make a transcript of the Emacs Lisp code by
evaluating each line and printing the result under it (/a la/
`eval-print-last-sexp')."
  (interactive)
  (let ((eval-expression-print-length nil)
        (eval-expression-print-level nil)
        (input-buffer (current-buffer)))
    (set-buffer (get-buffer-create
                 (concat "*Transcript for "
                         (buffer-name input-buffer)
                         "*")))
    (lisp-interaction-mode)
    (delete-region (point-min) (point-max))
    (insert-buffer-substring input-buffer) ;; `slurp!'
    (goto-char (point-min))
    (forward-sexp 1)
    (while (> (point-max) (point))
      (condition-case err
          (eval-print-last-sexp)
        (error
         (insert (format "%s" err))
         (newline)))
      (forward-sexp 1))))
