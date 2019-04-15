(defpackage cl-mars-rover
  (:use :cl)
  (:export :init-rover
           :execute-cmds))
(in-package :cl-mars-rover)

(defparameter *coords* '(1 . 1))
(defparameter *heading* "N")

(defun init-rover (coords heading)
  (print "Initializing rover")
  (setf *coords* coords)
  (setf *heading* heading)
  (list *coords* *heading*))

(defun turn-left ()
  (print "turning left...")
  (cond
    ((equal *heading* "N") (setf *heading* "W"))
    ((equal *heading* "W") (setf *heading* "S"))
    ((equal *heading* "S") (setf *heading* "E"))
    ((equal *heading* "E") (setf *heading* "N"))
  ))

(defun turn-right ()
  (print "turning right...")
  (cond
    ((equal *heading* "N") (setf *heading* "E"))
    ((equal *heading* "W") (setf *heading* "N"))
    ((equal *heading* "S") (setf *heading* "W"))
    ((equal *heading* "E") (setf *heading* "S"))
  ))

(defun execute-cmds (cmds)
  (flet ((handle-cmd (cmd)
           (print cmd)
           (cond
             ((equal cmd "l") (turn-left))
             ((equal cmd "r") (turn-right))
             (t "bar"))))
    (mapc #'(lambda (cmd) (handle-cmd cmd)) cmds))
  (list *coords* *heading*))
