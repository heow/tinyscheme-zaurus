; listhome.scm
; Sample usage of TinyScheme Extension
; This simple program lists the directory entries on the
; user's home directory.

; It uses the following TinyScheme Extension functions:
;    getenv
;      Used to get HOME environment variable.
;    open-dir-stream
;      Used to open directory stream.
;    read-dir-entry
;      Used to read directory entries.
;    close-dir-entry
;      Used at the end, to close directory stream when done.

; load TinyScheme extension
(load-extension "tsx")

; get user's home dir from HOME environment var
(define homedir (getenv "HOME"))
(display "Listing contents of ") (display homedir) (newline)

; create directory stream to read dir entries
(define dirstream (open-dir-stream homedir))
(if (not dirstream)
  (begin
    (display "Unable to open home directory!! Check value of HOME environment var.")
    (quit)))

(let listentry ((entry (read-dir-entry dirstream)))
  (if (eof-object? entry)
    #t
    (begin
      (display entry)
      (newline)
      (listentry (read-dir-entry dirstream)))))

(close-dir-stream dirstream)

(sleep 4)