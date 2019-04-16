(defpackage cl-mars-rover
  (:use :cl)
  (:export :init-rover
           :execute-cmds))
(in-package :cl-mars-rover)

(defparameter *coords* '(1 . 1))
(defparameter *heading* "N")
(defparameter *grid* '(10 . 10))

(defun init-rover (coords heading grid)
  (print "Initializing rover")
  (setf *coords* coords)
  (setf *heading* heading)
  (setf *grid* grid)
  (list *coords* *heading*))

(defun set-heading-north ()
  (setf *heading* "N"))
(defun set-heading-south ()
  (setf *heading* "S"))
(defun set-heading-west ()
  (setf *heading* "W"))
(defun set-heading-east ()
  (setf *heading* "E"))

(defun turn-rover (direction)
  (format t "turning rover ~A" direction)
  (cond
    ((equal *heading* "N") (if (eq direction 'Left) (set-heading-west) (set-heading-east)))
    ((equal *heading* "W") (if (eq direction 'Left) (set-heading-south) (set-heading-north)))
    ((equal *heading* "S") (if (eq direction 'Left) (set-heading-east) (set-heading-west)))
    ((equal *heading* "E") (if (eq direction 'Left) (set-heading-north) (set-heading-south)))
  ))

(defun inc-y-coord ()
  (setf *coords* (cons (car *coords*) (+ (cdr *coords*) 1)))
  (if (= (cdr *coords*) (cdr *grid*)) (setf *coords* (cons (car *coords*) 1))))
(defun inc-x-coord ()
  (setf *coords* (cons (+ (car *coords*) 1) (cdr *coords*)))
  (if (= (car *coords*) (car *grid*)) (setf *coords* (cons 1 (cdr *coords*)))))
(defun dec-y-coord ()
  (setf *coords* (cons (car *coords*) (- (cdr *coords*) 1)))
  (if (= (cdr *coords*) 0) (setf *coords* (cons (car *coords*) (cdr *grid*)))))
(defun dec-x-coord ()
  (setf *coords* (cons (- (car *coords*) 1) (cdr *coords*)))
  (if (= (car *coords*) 0) (setf *coords* (cons (car *grid*) (cdr *coords*)))))

(defun move-rover (direction)
  (format t "move rover ~A" direction)
  (cond
    ((equal *heading* "N") (if (eq direction 'Forward) (inc-y-coord) (dec-y-coord)))
    ((equal *heading* "S") (if (eq direction 'Forward) (dec-y-coord) (inc-y-coord)))
    ((equal *heading* "E") (if (eq direction 'Forward) (inc-x-coord) (dec-x-coord)))
    ((equal *heading* "W") (if (eq direction 'Forward) (dec-x-coord) (inc-x-coord)))
    )
  )

(defun execute-cmds (cmds)
  (flet ((handle-cmd (cmd)
           (print cmd)
           (cond
             ((equal cmd "l") (turn-rover 'Left))
             ((equal cmd "r") (turn-rover 'Right))
             ((equal cmd "f") (move-rover 'Forward))
             ((equal cmd "b") (move-rover 'Backward))
             (t "bar"))))
    (mapc #'(lambda (cmd) (handle-cmd cmd)) cmds))
  (list *coords* *heading*))
