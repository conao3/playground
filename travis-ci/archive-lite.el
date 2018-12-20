(require 'json)
(setq json-object-type 'hash-table)
(setq json-key-type    'keyword)

(let* ((current-dir (file-name-directory
                     (directory-file-name load-file-name)))
       (write-file  (concat current-dir "archive-lite-sexp.el"))
       (read-file   (concat current-dir "archive-lite.json"))
       (contents))
  (if (and (file-writable-p write-file)
           (file-readable-p read-file))
      (with-temp-file write-file
        (setq contents  (prin1-to-string (json-read-file read-file)))
        (insert contents)
        (insert "\n"))
    (error "File open error")))

(princ "Process completed!!")
