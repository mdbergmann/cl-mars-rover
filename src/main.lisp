(defpackage cl-mars-rover
  (:use :cl)
  (:export :rover-init))
(in-package :cl-mars-rover)

(defparameter *coords* '(1 . 1))
(defparameter *heading* 'North)

(defun rover-init (coords heading)
  (progn
    (setf *coords* coords)
    (setf *heading* heading))
  (list *coords* *heading*))

