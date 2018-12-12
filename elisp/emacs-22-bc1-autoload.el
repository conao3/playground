;; Emacs-22においてdeclare-function絡みの実行エラー
;; バイトコンパイルするときだけ表面化する？？

;; $ /usr/bin/emacs -Q --batch -L ./ -f batch-byte-compile emacs-22-bc1.el
;; In toplevel form:
;; emacs-22-bc1.el:9:19:Warning: reference to free variable `package-install'
;; 
;; In end of data:
;; emacs-22-bc1.el:20:1:Warning: the following functions are not known to be
;;     defined: declare-function, package-install
;; Wrote /Users/conao/Develop/git/playground/elisp/emacs-22-bc1.elc
;; 
;; $ /usr/bin/emacs -Q --batch -L ./ -l emacs-22-bc1.elc -f test
;; Symbol's value as variable is void: package-install
;; 
;; $ /usr/bin/emacs -Q --batch -L ./ -l emacs-22-bc1.el -f test
;; test ok.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs-22においてdeclare-function絡みの実行エラー
;; => autoloadを使うことにより解決！！

;; $ /usr/bin/emacs -Q --batch -L ./ -f batch-byte-compile emacs-22-bc1-autoload.el
;; In end of data:
;; emacs-22-bc1-autoload.el:32:1:Warning: the function `package-install' is not
;;     known to be defined.
;; Wrote /Users/conao/Develop/git/playground/elisp/emacs-22-bc1-autoload.elc
;; 
;; $ /usr/bin/emacs -Q --batch -L ./ -l emacs-22-bc1-autoload.elc -f test
;; test ok.
;; $ /usr/bin/emacs -Q --batch -L ./ -l emacs-22-bc1-autoload.el -f test
;; test ok.
;;
;; $ rm emacs-22-bc1-autoload.elc
;; $ emacs-26.1 -Q --batch -L ./ -f batch-byte-compile emacs-22-bc1-autoload.el
;; $ emacs-26.1 -Q --batch -L ./ -l emacs-22-bc1-autoload.elc -f test
;; test ok.
;; $ emacs-26.1 -Q --batch -L ./ -l emacs-22-bc1-autoload.el -f test
;; test ok.

(eval-when-compile
  (autoload 'pacakge-install "package"))

(defvar leaf-backend/:ensure nil)

(defun leaf-handler/:ensure (name)
  (if leaf-backend/:ensure
      (package-install name)))

(defun test ()
  (leaf-handler/:ensure 'foo)
  (princ "test ok."))
