
;;; Warning, do NOT edit this file with the
;;; standard Zaurus text editor!  Please
;;; use your favorite text editor such as
;;; vi, MinIDE, uemacs, opie-textedit, etc.


;;; socket-repl.scm
;;; Sample usage of TinyScheme Extensions
;;; This program provides a socket-based
;;; read-eval-print-loop.

;;; It uses the following TinyScheme 
;;; Extension functions:
;;;   make-server-socket
;;;     used to create server socket on 
;;;     port 9000
;;;   accept
;;;     used to accept client requests for
;;;     connection
;;;   recv-new-string
;;;     used to receive user's requests
;;;   send
;;;     used to send evaluation results
;;;   close-socket
;;;     used to free socket at the end

; check that string ports are available...
(if (not (defined? 'open-output-string))
  (begin
    (display "We need string ports!! Recompile TinyScheme with string ports,")
    (display " if you want to run this sample...")
    (quit)))

; load TinyScheme Extensions
(load-extension "tsx")

(display "Now telnet into port 9000 on this machine!\n")

; create server socket on port 9000
(define server-socket (make-server-socket 9000))

; wait for client requests
(define connected-socket (accept server-socket))

; send welcome message
(send connected-socket "Welcome to TinyScheme Extensions socket-REPL!\n")

; define auxiliary variables
(define command '())
(define command-port '())
(define result '())
(define result-port '())
(define to-eval '())

(define extenv (current-environment))
(let repl ()
  (send connected-socket "> ")
  (set! command (recv-new-string connected-socket))
  (set! command-port (open-input-string command))
  (set! to-eval (read command-port))
  (set! result (make-string 250))
  (set! result-port (open-output-string result))
  (display (eval to-eval) result-port)
  (send connected-socket result)
  (send connected-socket "\n")
  (close-input-port command-port)
  (close-output-port result-port)
  (repl)
)
