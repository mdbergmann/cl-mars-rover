(defpackage cl-mars-rover-tests
  (:use :cl
        :cl-mars-rover
        :fiveam)
  (:export #:run!
           #:all-tests
           #:nil))
(in-package :cl-mars-rover-tests)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-mars-rover)' in your Lisp.


(test init-rover
  "Tests for initializing the rover"
  (is (eq (car (init-rover '(1 . 1) "N" '(10 . 10))) '(1 . 1)))
  (is (eq (car (init-rover '(1 . 2) "N" '(10 . 10))) '(1 . 2)))
  (is (equal (cadr (init-rover '(1 . 1) "N" '(10 . 10))) "N"))
  (is (equal (cadr (init-rover '(1 . 1) "S" '(10 . 10))) "S")))

(defun default-init-rover (heading)
  (init-rover '(1 . 1) heading '(10 . 10)))

(test turn-rover
  "Tests for turning the rover with changing it's heading"
  (default-init-rover)
  (is (equal (cadr (execute-cmds '("l"))) "W"))
  (default-init-rover)
  (is (equal (cadr (execute-cmds '("l" "l"))) "S"))
  (default-init-rover)
  (is (equal (cadr (execute-cmds '("l" "l" "l"))) "E"))
  (default-init-rover)
  (is (equal (cadr (execute-cmds '("l" "l" "l" "l"))) "N"))
  (default-init-rover)
  (is (equal (cadr (execute-cmds '("r"))) "E"))
  (default-init-rover)
  (is (equal (cadr (execute-cmds '("r" "r"))) "S"))
  (default-init-rover)
  (is (equal (cadr (execute-cmds '("r" "r" "r"))) "W"))
  (default-init-rover)
  (is (equal (cadr (execute-cmds '("r" "r" "r" "r"))) "N"))
  )

(test move-rover
  "Tests for moving the rover forward/backward"
  ;; forward
  (default-init-rover "N")
  (is (equal (cdr (car (execute-cmds '("f" "f")))) 3))
  (default-init-rover "E")
  (is (equal (car (car (execute-cmds '("f" "f")))) 3))
  (default-init-rover "S")
  (is (equal (cdr (car (execute-cmds '("f" "f")))) 9))
  (default-init-rover "W")
  (is (equal (car (car (execute-cmds '("f" "f")))) 9))
  ;; back
  (default-init-rover "N")
  (is (equal (cdr (car (execute-cmds '("b" "b")))) 9))
  (default-init-rover "E")
  (is (equal (car (car (execute-cmds '("b" "b")))) 9))
  (default-init-rover "S")
  (is (equal (cdr (car (execute-cmds '("b" "b")))) 3))
  (default-init-rover "W")
  (is (equal (car (car (execute-cmds '("b" "b")))) 3))
  )

(run! 'init-rover)
(run! 'turn-rover)
(run! 'move-rover)
