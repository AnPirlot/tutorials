;;;; A one node network which gets an input array and an output and calculates a weight accordingly


(defstruct node
	weight
)

(format t "~%Starting..")

(defvar *input* '(1 1 2))
(defvar *output* '(0 0 1))

(defvar *nodes* (make-array 3 :initial-element (make-node :weight (random 1.0))))

(defun copy-nodes (nodes)
  (setf copy (make-array (car (array-dimensions nodes))))
  (dotimes (i (car (array-dimensions nodes)))
    (setf (aref copy i) (copy-node (aref nodes i))))
  (return-from copy-nodes copy))


;;; Using an array of inputs and an array of outputs to train an array of nodes. This returns a copy of the array of nodes with updated weights.
(defun train (input output nodes)
  "Using an array of inputs and an array of outputs to train an array of nodes. This returns a copy of the array of nodes with updated weights."
  (map 'array #'update-weight-of-node nodes))

;;; The function to be used to update a nodes' weight.
(defun update-weight-of-node (node)
  "Updating the weight of the node."
  (return-from update-weight-of-node (make-node :weight (random 1.0))))

;;; Calculate the output using an input array and an array of nodes.
(defun evaluate (input nodes)
  "Evalute the given input using the given nodes."
	(map 'array #'(lambda(x) (evaluate-node input x)) nodes))

;;; Calculate the output using an input array and the current weight of one node. weight*SUM(input).
(defun evaluate-node (input node)
  "Evaluate to output of one node given an input."
	(* (node-weight node) (reduce #'+ input)))

;;; Check if every error margin in an array is small enough.
(defun error-margin-okp (value approximation)
  "Check if every error margin in the array is acceptable."
	(let ((margin (error-margin value approximation)))
		(format t "~%the error margin: ~a" margin)
		(recursive-error-margin-okp margin (- (car (array-dimensions margin)) 1) t)))

;;; Calculate the error between a value and it's approximation.
(defun error-margin (value approximation)
  "Calculate the error margin for every value and its approximation."
  (map 'array #'abs (map 'array #'- value approximation)))

;;; Checks for an arry if the multiple error margins are small enoughresult starts as true.
(defun recursive-error-margin-okp (margin i result)
  "Checks multiple error margins that all margins are small enough, result starts as true."
  (if (>= i 0)
    (if (> (aref margin i) 0.5) 
      (recursive-error-margin-okp margin (- i 1) (and nil result)) 
      (recursive-error-margin-okp margin (- i 1) (and t result)))
    result))

;;; Keep on training until the error margin is small enough.
(defun train-until-convergence (input output nodes)
  "Keep on training the given nodes using an input and output until there weights converge."
    (format t "~% Still training..")
    (let ((approximation (evaluate input nodes)))
      (format t "~%approximation: ~a" approximation)
      (if (error-margin-okp output approximation)
        (return-from train-until-convergence nodes)
        (train-until-convergence input output (train input output nodes)))))

(setf calc-nodes (train-until-convergence *input* *output* *nodes*))
(format t "~%~%The converged nodes are: ~a" calc-nodes)
(format t "~%~%Which gives us output approximation ~a for input ~a and output ~a" (Evaluate *input* calc-nodes) *input* *output*)

