(cd "~/")
(set-language-environment "Japanese")
 
;; key-map change
(defun key-map-setting ()
  (define-key global-map "\C-\\" 'undo)
	;;(define-key global-map "\C-h" 'delete-backward-char)
	(global-set-key "\C-h" 'delete-backward-char))
 
 
;for scala
(defun scala-setting()
  (setq load-path 
	(cons "/opt/local/share/scala-2.8/misc/scala-tool-support/emacs" 
	      load-path))
  (require 'scala-mode-auto)
  (setq scala-interpreter "/opt/local/bin/scala-2.8"))

(defun haskell-setting ()
	;; work around for snow leopard
	(setq load-path (cons "~/Library/elisp/haskell-mode-2.8.0" load-path))
	(load "haskell-site-file")
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
  (add-hook 'haskell-mode-hook 'font-lock-mode)
  ;(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci))
)
 
;; for gforth
(defun gforth-setting()
	(add-to-list 'load-path "~/Library/elisp/others")
	(autoload 'forth-mode "gforth.el")
	(setq auto-mode-alist (cons '("\\.fs\\'" . forth-mode)
				    auto-mode-alist))
	(autoload 'forth-block-mode "gforth.el")
	(setq auto-mode-alist (cons '("\\.fb\\'" . forth-block-mode)
				    auto-mode-alist))
	(add-hook 'forth-mode-hook 
		  (function (lambda ()
			      ;; customize variables here:
			      (setq forth-indent-level 4)
			      (setq forth-minor-indent-level 2)
			      (setq forth-hilight-level 3)
			      ))))

;; for ruby
(defun ruby-setting ()
  (setq load-path (cons "~/Library/elisp/ruby-mode" load-path))
  (autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
  (setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
  (setq interpreter-mode-alist
  (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
  
  (autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
  (autoload 'inf-ruby-keys "inf-ruby"
    "Set local key defs for inf-ruby in ruby-mode")
  (add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))
  (setq ruby-program-name "irb1.9"))
  
  
 
;; for python
(defun python-setting ()
  ;(setq load-path (cons "~/lib/elisp/python" load-path))
  ;(autoload 'python-mode "python-mode" nil t)
  ;(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
  (add-hook 'python-mode-hook
      '(lambda()
         (setq indent-tabs-mode nil)
         (setq indent-level 2)
         (setq python-indent 2)
         (setq tab-width 2))))
  ;(add-hook 'python-mode-hook
  ;'(lambda() (require 'pycomplete) (setq indent-tabs-mode nil))))
 
(setq default-frame-alist
      (append (list '(foreground-color . "white")
     '(background-color . "black")
;     '(background-color . "LemonChiffon")
;     '(background-color . "Alice blue")
;     '(background-color . "gray")
     '(border-color . "black")
     '(mouse-color . "white")
     '(cursor-color . "black")
     '(width . 80)
     '(height . 70)
;     '(top . 100)
;     '(left . 100)
     )
   default-frame-alist))
 
;; howm
(defun howm-setting ()
  (add-to-list 'load-path "~/Library/elisp/howm-1.3.8/")
  (require 'howm)
  (setq howm-menu-lang 'ja)
  ;; タイトル色
  (set-face-foreground 'howm-mode-title-face "turquoise"))
  
 
;; psvn
(defun psvn-setting()
  (require 'psvn)
)
 
;
;(defun auto-save-setting ()
;  (require 'auto-save-buffers)
;  (run-with-idle-timer 0.5 t 'auto-save-buffers) )
 
(defun tuareg-mode-setting ()
  (add-to-list 'load-path "~/lib/elisp/tuareg/")
  (setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
  (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
  (autoload 'camldebug "camldebug" "Run the Caml debugger" t))
 
(defun scheme-setting ()
  (setq scheme-program-name "C:/bin/larceny/larceny.bat"))
 
;(defun slime-setting()
;  (add-to-list 'load-path "~/lib/elisp/slime/")
;  (setq inferior-lisp-program "sbcl")
;  (require 'slime)
;  (slime-setup))

(defun slime-setting () 
  (setq load-path (cons "/opt/local/share/emacs/site-lisp/slime" load-path))
  (require 'slime-autoloads)
  (setq slime-lisp-implementations
	`((sbcl ("/opt/local/bin/sbcl"))
	  (clisp ("/opt/local/bin/clisp"))))
  (add-hook 'lisp-mode-hook
	    (lambda ()
	      (cond ((not (featurep 'slime))
		     (require 'slime) 
		     (normal-mode)))))
  
  (eval-after-load "slime"
    '(slime-setup '(slime-fancy slime-banner))))

;; flymake-ruby

(defun flymake-ruby-setting()
  (require 'flymake)
  ;; Invoke ruby with '-c' to get syntax checking
  (defun flymake-ruby-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
			 'flymake-create-temp-inplace))
	   (local-file  (file-relative-name
			 temp-file
			 (file-name-directory buffer-file-name))))
      (list "ruby" (list "-c" local-file))))
  (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) 
	flymake-err-line-patterns)
  (add-hook
   'ruby-mode-hook
   '(lambda ()
      ;; Don't want flymake mode for ruby regions in rhtml files
      (if (not (null buffer-file-name)) (flymake-mode))
      ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
      (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))
  
  (defun credmp/flymake-display-err-minibuf ()
    "Displays the error/warning for the current line in the minibuffer"
    (interactive)
    (let* ((line-no             (flymake-current-line-no))
	   (line-err-info-list  
	    (nth 0 (flymake-find-err-info flymake-err-info line-no)))
	   (count               (length line-err-info-list)))
      (while (> count 0)
	(when line-err-info-list
	  (let* ((file       
		  (flymake-ler-file (nth (1- count) line-err-info-list)))
		 (full-file  
		  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
		 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
		 (line
		  (flymake-ler-line (nth (1- count) line-err-info-list))))
	    (message "[%s] %s" line text)))
	(setq count (1- count))))))

;; flymake-haskell
(defun flymake-haskell-setting ()
  (autoload 'flymake-mode "flymake" "" t)
  (eval-after-load "flymake"
    '(progn
       (defun flymake-hslint-init ()
	 (let* ((temp-file   (flymake-init-create-temp-buffer-copy
			      'flymake-create-temp-inplace))
		(local-file  (file-relative-name
			      temp-file
			      (file-name-directory buffer-file-name))))
	   (list "hslint" (list local-file))))
       (add-to-list 'flymake-allowed-file-name-masks
		    '("\\.l?hs\\'" flymake-hslint-init))))
  
  (defun credmp/flymake-display-err-minibuf ()
    "Displays the error/warning for the current line in the minibuffer"
    (interactive)
    (let* ((line-no             (flymake-current-line-no))
	   (line-err-info-list  
	    (nth 0 (flymake-find-err-info flymake-err-info line-no)))
	   (count
	    (length line-err-info-list)))

      (while (> count 0)
	(when line-err-info-list
	  (let* ((file       
		  (flymake-ler-file (nth (1- count) line-err-info-list)))
		 (full-file  
		  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
		 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
		 (line (flymake-ler-line (nth (1- count) line-err-info-list))))
	    (message "[%s] %s" line text)))
	(setq count (1- count)))))

  (add-hook
   'haskell-mode-hook
   '(lambda ()
      (define-key haskell-mode-map "\C-cd"
	'credmp/flymake-display-err-minibuf))))

(defun flymake-cpp-setting ()
	(require 'flymake)
;; 	(defun flymake-cc-init ()
;; 	  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;   'flymake-create-temp-inplace))
;;	 (local-file  (file-relative-name
;;   temp-file
;;  (file-name-directory buffer-file-name))))
;; (list "g++" (list "-Wall" "-Wextra" "-ansi" "-pedantic" 
;; "-fsyntax-only" local-file))))
;;  	(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
	(add-hook 'c++-mode-hook
		  '(lambda ()
		     (flymake-mode t)))
	
	(defun flymake-goto-next-error-msg ()
	  (interactive)
	  (flymake-goto-next-error)
	  (message (get-char-property (point) 'help-echo)))
	
	(defun flymake-goto-prev-error-msg ()
	  (interactive)
	  (flymake-goto-prev-error)
	  (message (get-char-property (point) 'help-echo)))
	
	;; エラー優先で、次のエラー/警告に飛んで、エラー内容をミニバッファに表示
	(global-set-key "\M-n" 'flymake-goto-next-error-msg)
	;; エラー優先で、前のエラー/警告に飛んで、エラー内容をミニバッファに表示
	(global-set-key "\M-p" 'flymake-goto-prev-error-msg)
	
	;; (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)
	(global-set-key "\C-cd" 'flymake-display-err-minibuf)

	(defun flymake-display-err-minibuf () ;;;; unused
	  "Displays the error/warning for the current line in the minibuffer"
	  (interactive)
	  (let* ((line-no 
		  (flymake-current-line-no))
		 (line-err-info-list  
		  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
		 (count (length line-err-info-list)))
	    (while (> count 0)
	      (when line-err-info-list
		(let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
		       (full-file 
			(flymake-ler-full-file (nth (1- count) line-err-info-list)))
		       (text (flymake-ler-text (nth (1- count) line-err-info-list)))
		       (line (flymake-ler-line (nth (1- count) line-err-info-list))))
		  (message "[%s] %s" line text)))
	      (setq count (1- count)))))
	)

(defun flymake-haskell-setting-ng ()
  (require 'flymake)
  (defun flymake-Haskell-init ()
    (flymake-simple-make-init-impl
     'flymake-create-temp-with-folder-structure nil nil
     (file-name-nondirectory buffer-file-name)
     'flymake-get-Haskell-cmdline))

  (defun flymake-get-Haskell-cmdline (source base-dir)
    (list "/usr/local/bin/flycheck_haskell.pl" (list source base-dir)))
  
  (push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
	flymake-allowed-file-name-masks)
  (push '(".+\\.lhs$" flymake-Haskell-init flymake-simple-java-cleanup)
	flymake-allowed-file-name-masks)
  (push
   '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
     1 2 3 4) flymake-err-line-patterns))

(defun go-mode-setting()
  (setq default-tab-width 2)
  (add-to-list 'load-path "~/Library/elisp/go" t)
  (require 'go-mode-load))

(defun js2-mode-setting()
	(add-to-list 'load-path "~/Library/elisp/js2-mode" t)
	(autoload 'js2-mode "js2" nil t)
	(when (load "js2" t)
	  (setq js2-cleanup-whitespace nil
		js2-mirror-mode nil
		js2-bounce-indent-p nil
		js2-basic-offset 4)
	  
	  (add-hook 'js2-mode-hook
		    (lambda ()
		      (setq indent-tabs-mode nil)))
	  
	  
	  (defun indent-and-back-to-indentation ()
	    (interactive)
	    (indent-for-tab-command)
	    (let ((point-of-indentation
		   (save-excursion
		     (back-to-indentation)
		     (point))))
	      (skip-chars-forward "\s\t " point-of-indentation)))
	  
	  (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
	  
	  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))
	)

(defun slime-setitng()
  (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/slime")
  (require 'slime-autoloads)
  (setq slime-lisp-implementations
	`((sbcl ("/opt/local/bin/sbcl"))
	  (abcl ("/opt/local/bin/abcl"))
	  (clisp ("/opt/local/bin/clisp"))))
  (add-hook 'lisp-mode-hook
	    (lambda ()
	      (cond ((not (featurep 'slime))
		     (require 'slime)
		     (normal-mode)))))
  
  (eval-after-load "slime"
    '(slime-setup '(slime-fancy slime-banner)))
  
  )


(defun closure-setting()
  (add-to-list 'load-path "~/Library/elisp/clojure" t)
  (require 'clojure-mode))

(defun nav-setting()
  (add-to-list 'load-path "~/Library/elisp/nav" t)
  (require 'nav))

(defun yasnippet-setting()
  ;; yasnippet
  (add-to-list 'load-path "~/Library/elisp/yasnippet")
  (require 'yasnippet)
  (setq yas/snippet-dirs "~/Library/elisp/yasnippet/snippets")
  (yas/initialize))

(yasnippet-setting)

(closure-setting)
;;(slime-setting)

;; my setting
(line-number-mode 1)
(column-number-mode 1)
(iswitchb-mode 1)

;; coding-setting
(prefer-coding-system 'utf-8)
;(font-setting-xp)
 
;(toggle-input-method nil)
(setq visible-bell t)
(global-font-lock-mode t)

;(scheme-setting)
;(scala-setting)



(howm-setting)
;(psvn-setting)
(haskell-setting)

;(flymake-haskell-setting)
;(auto-save-setting)
(ruby-setting)
;(flymake-ruby-setting)
;(flymake-cpp-setting)
;(tuareg-mode-setting)
(python-setting)
;(slime-setting)
;(go-mode-setting)
(js2-mode-setting)
;(gforth-setting)
(nav-setting)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 ;'(inferior-lisp-program "java -cp /opt/local/share/java/clojure/lib/clojure.jar clojure.main")
 '(inferior-lisp-program "clj -r")
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'downcase-region 'disabled nil)

(key-map-setting)
(setq indent-tabs-mode nil)