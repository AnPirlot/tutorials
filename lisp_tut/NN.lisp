;;;; A one node network which gets an input array and an output and calculates a weight accordingly


(defstruct node
	weight
)

(format t "~%Starting..")

(defvar *input* '(1 2 3))
(defvar *output* '(0 0 1))

(defvar *nodes* (make-array 3 :initial-element (make-node :weight (random 1.0))))


;;; Updating the weight using one input output tuple
(defun train (input output)
	(when (not(eq output (evaluate input)))
		(map 'array #'update-weight *nodes*)
		(loop for node across *nodes*
			do (format t "~%the new weights: ~a" (node-weight node)))))

;;; The function to be used to update a nodes' weight
(defun update-weight (node)
	(setf (node-weight node) (random 1.0)))

;;; Calculate the output using an input array and the current weight. weight*SUM(input)
(defun evaluate (input)
	(map 'array #'(lambda(x) (evaluate-node input x)) *nodes*))

;;; Calculate the output using an input array and the current weight for one node. weight*SUM(input)
(defun evaluate-node (input node)
	(format t "~%the evaluated output for node ~a: ~a" node (* (node-weight node) (reduce #'+ input)))
	(* (node-weight node) (reduce #'+ input)))

;;; Calculate the error between a value and it's approximation
(defun error-margin (value approximation)
	(map 'array #'abs (map 'array #'- value approximation)))

;;; Check if the error margin is small enough
(defun error-margin-ok (value approximation)
	(let ((margin (error-margin value approximation)))
		(format t "~%the error margin for ~a: ~a" margin (reduce #'+ margin))
		(if (< (reduce #'+ margin) 3.0) t nil)))

;;; Keep on training until the error margin is small enough
(defun train-until-convergence ()
	(loop
		(format t "~% Still training..")
		(train *input* *output*)
		(let ((approximation (evaluate *input*)))
			(when (error-margin-ok *output* approximation)
				(return *nodes*))))
	(format t "~%Done training"))

(train-until-convergence)
(format t "~%~%The converged nodes are: ~a" *nodes*)

