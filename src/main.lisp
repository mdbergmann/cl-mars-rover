(defpackage cl-mars-rover
  (:use :cl)
  (:export :init-rover
           :execute-cmds))
(in-package :cl-mars-rover)

(defparameter *coords* '(1 . 1))
(defparameter *heading* "N")
(defparameter *grid* '(10 . 10))
(defparameter *obstacles* nil)

(defun init-rover (coords heading grid obstacles)
  (print "Initializing rover")
  (setf *coords* coords)
  (setf *heading* heading)
  (setf *grid* grid)
  (setf *obstacles* obstacles)
  (list *coords* *heading*))


(defun turn-rover (direction)
  (format t "turning rover ~A" direction)
  (cond
    ((equal *heading* "N") (if (eq direction 'Left) "W" "E"))
    ((equal *heading* "W") (if (eq direction 'Left) "S" "N"))
    ((equal *heading* "S") (if (eq direction 'Left) "E" "W"))
    ((equal *heading* "E") (if (eq direction 'Left) "N" "S"))
  ))

(defun inc-y-coord ()
  (let ((new-coords (cons (car *coords*) (1+ (cdr *coords*)))))
    (if (= (cdr new-coords) (cdr *grid*)) (cons (car new-coords) 1) new-coords)))
(defun inc-x-coord ()
  (let ((new-coords (cons (1+ (car *coords*)) (cdr *coords*))))
    (if (= (car new-coords) (car *grid*)) (cons 1 (cdr new-coords)) new-coords)))
(defun dec-y-coord ()
  (let ((new-coords (cons (car *coords*) (1- (cdr *coords*)))))
    (if (= (cdr new-coords) 0) (cons (car new-coords) (cdr *grid*)) new-coords)))
(defun dec-x-coord ()
  (let ((new-coords (cons (1- (car *coords*)) (cdr *coords*))))
    (if (= (car new-coords) 0) (cons (car *grid*) (cdr new-coords)) new-coords)))

(defun move-rover (direction)
  (format t "move rover ~A" direction)
  (let ((new-coords
         (cond
           ((equal *heading* "N") (if (eq direction 'Forward) (inc-y-coord) (dec-y-coord)))
           ((equal *heading* "S") (if (eq direction 'Forward) (dec-y-coord) (inc-y-coord)))
           ((equal *heading* "E") (if (eq direction 'Forward) (inc-x-coord) (dec-x-coord)))
           ((equal *heading* "W") (if (eq direction 'Forward) (dec-x-coord) (inc-x-coord)))
           )))
    ;; list with obstacles in the way, nil if no obstacle
    (if (eq nil (remove-if-not #'(lambda (obstacle)
                                   (if
                                    (and (= (car obstacle) (car new-coords))
                                         (= (cdr obstacle) (cdr new-coords)))
                                    t
                                    nil)) *obstacles*))
        new-coords
        nil)
    ))

(defun execute-cmds (cmds)
  (let ((obstacle-detect nil))
    (flet ((handle-cmd (cmd)
             (cond
               ;; if obstacle-detect has been set bail out here
               ((not (eq obstacle-detect nil)) t)
               ((equal cmd "l") (setf *heading* (turn-rover 'Left)))
               ((equal cmd "r") (setf *heading* (turn-rover 'Right)))
               ((equal cmd "f")
                (let ((new-coords (move-rover 'Forward)))
                  (if (eq nil new-coords)
                      (setf obstacle-detect cmd)
                      (setf *coords* new-coords))))
               ((equal cmd "b")
                (let ((new-coords (move-rover 'Backward)))
                  (if (eq nil new-coords)
                      (setf obstacle-detect cmd)
                      (setf *coords* new-coords))))
               (t "bar"))))
      (mapc #'(lambda (cmd) (handle-cmd cmd)) cmds))
    (list *coords* *heading* obstacle-detect)))
