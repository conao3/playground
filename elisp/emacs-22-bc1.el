;; Emacs-22においてdeclare-function絡みの実行エラー
;; バイトコンパイルするときだけ表面化する？？

;; [解決済み] emacs-22-bc1-autoload.el 参照のこと

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

(unless (fboundp 'declare-function)
  (defmacro declare-function (_fn _file &rest _args)
    "Tell the byte-compiler that function FN is defined, in FILE."
    nil))

(declare-function package-install "package")

(defvar leaf-backend/:ensure nil)

(defun leaf-handler/:ensure (name)
  (if leaf-backend/:ensure
      (package-install name)))

(defun test ()
  (leaf-handler/:ensure 'foo)
  (princ "test ok."))
