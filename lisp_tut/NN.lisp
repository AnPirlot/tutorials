;;;; A one node network which gets an input array and an output and calculates a weight accordingly

(defstruct node
	weight
)

(format t "~%Starting..")

(defvar *input* '(1 2 3))
(defvar *output* 5)
(defvar node1 (make-node :weight 1.0))

;;; Updating the weight using one input output tuple
(defun train (input output)
	(when (not(= output (evaluate input)))
		(setf (node-weight node1) (random 1.0))
		(format t "~%the new weight: ~a" (node-weight node1))))

;;; Calculate the output using an input array and the current weight. weight*SUM(input)
(defun evaluate (input)
	(format t "~%the evaluated output: ~a" (* (node-weight node1) (reduce #'+ input)))
	(* (node-weight node1) (reduce #'+ input)))

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
			(return (node-weight node1)))))
	(format t "~%Done training"))

(train-until-convergence)
(format t "~%~%The converged weight is: ~a" (node-weight node1))

