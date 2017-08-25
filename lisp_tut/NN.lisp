;;;; A one node network which gets an input and output and calculates a weight accordingly

(format t "~%Starting..")

(defvar *input* 6)
(defvar *output* 5)
(defvar *weight* 1.0)

;;; Updating the weight using one input output tuple
(defun train (input output)
	(when (not(= output (evaluate input)))
		(setf *weight* (random 1.0))
		(format t "~%the new weight: ~a" *weight*)))

;;; Calculate the output using an input and the current weight
(defun evaluate (input)
	(format t "~%the evaluated output: ~a" (* *weight* input))
	(* *weight* input))

;;; Calculate the error between a value and it's approximation
(defun error-margin (value approximation)
	(abs(- value approximation)))

;;; Check if the error margin is small enough
(defun error-margin-ok (value approximation)
	(let ((margin (error-margin value approximation)))
	(format t "~%the error margin: ~a" margin)
	(if (< margin 0.05) t nil)))

;;; Keep on training until the error margin is small enough
(defun train-until-convergence ()
	(loop
		(format t "~% Still training..")
		(train *input* *output*)
		(let ((approximation (evaluate *input*)))
		(when (error-margin-ok *output* approximation)
			(return *weight*))))
	(format t "~%Done training"))

(train-until-convergence)
(format t "~%~%The converged weight is: ~a" *weight*)

