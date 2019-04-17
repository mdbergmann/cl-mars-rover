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
  (is (eq (car (init-rover '(1 . 1) "N" '(10 . 10) nil)) '(1 . 1)))
  (is (eq (car (init-rover '(1 . 2) "N" '(10 . 10) nil)) '(1 . 2)))
  (is (equal (cadr (init-rover '(1 . 1) "N" '(10 . 10) nil)) "N"))
  (is (equal (cadr (init-rover '(1 . 1) "S" '(10 . 10) nil)) "S")))

(defun default-init-rover (heading)
  (init-rover '(1 . 1) heading '(10 . 10) '((1 . 4))))

(test turn-rover
  "Tests for turning the rover with changing it's heading"
  (default-init-rover "N")
  (is (equal (cadr (execute-cmds '("l"))) "W"))
  (default-init-rover "N")
  (is (equal (cadr (execute-cmds '("l" "l"))) "S"))
  (default-init-rover "N")
  (is (equal (cadr (execute-cmds '("l" "l" "l"))) "E"))
  (default-init-rover "N")
  (is (equal (cadr (execute-cmds '("l" "l" "l" "l"))) "N"))
  (default-init-rover "N")
  (is (equal (cadr (execute-cmds '("r"))) "E"))
  (default-init-rover "N")
  (is (equal (cadr (execute-cmds '("r" "r"))) "S"))
  (default-init-rover "N")
  (is (equal (cadr (execute-cmds '("r" "r" "r"))) "W"))
  (default-init-rover "N")
  (is (equal (cadr (execute-cmds '("r" "r" "r" "r"))) "N"))
  )

(test move-rover
  "Tests for moving the rover forward/backward"
  ;; forward
  (default-init-rover "N")
  (is (= (cdr (car (execute-cmds '("f" "f")))) 3))
  (default-init-rover "E")
  (is (= (car (car (execute-cmds '("f" "f")))) 3))
  (default-init-rover "S")
  (is (= (cdr (car (execute-cmds '("f" "f")))) 9))
  (default-init-rover "W")
  (is (= (car (car (execute-cmds '("f" "f")))) 9))
  ;; back
  (default-init-rover "N")
  (is (= (cdr (car (execute-cmds '("b" "b")))) 9))
  (default-init-rover "E")
  (is (= (car (car (execute-cmds '("b" "b")))) 9))
  (default-init-rover "S")
  (is (= (cdr (car (execute-cmds '("b" "b")))) 3))
  (default-init-rover "W")
  (is (= (car (car (execute-cmds '("b" "b")))) 3))
  )

(test detect-obstacle
  "Detect obstacles on the way of the rover"
  (default-init-rover "N")
  ;; third f is obstacle
  (is (= (car (car (execute-cmds '("f" "f" "f")))) 1))
  (is (= (cdr (car (execute-cmds '("f" "f" "f")))) 3))
  (is (equal (caddr (execute-cmds '("f" "f" "f"))) "f"))

  (init-rover '(1 . 4) "N" '(10 . 10) '((1 . 1)))
  (is (= (car (car (execute-cmds '("b" "b" "b")))) 1))
  (is (= (cdr (car (execute-cmds '("b" "b" "b")))) 2))
  (is (equal (caddr (execute-cmds '("b" "b" "b"))) "b"))
  
  )

(run! 'init-rover)
(run! 'turn-rover)
(run! 'move-rover)
(run! 'detect-obstacle)
