(write-line "Hello World!")
(write-line "These are my first lines of lisp")

(write-line "Let's start with a question.")
(write-line "What is your name?")
(defvar *name* (read)) ;*name* is a global variable

(defun hello-you (name) ;name is a local variable
	(format t "Hello ~a! ~%" name))
(setq *print-case* :capitalize)

(hello-you *name*)

(write-line "What is your last name?")
(defvar *lastname* (read))
(hello-you (concatenate 'string (string *name*) " " (string *lastname*)))