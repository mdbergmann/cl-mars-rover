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
  (is (eq (car (init-rover '(1 . 1) "N")) '(1 . 1)))
  (is (eq (car (init-rover '(1 . 2) "N")) '(1 . 2)))
  (is (equal (cadr (init-rover '(1 . 1) "N")) "N"))
  (is (equal (cadr (init-rover '(1 . 1) "S")) "S")))

(test turn-rover-left
  "Tests for turning the rover left with changing it's heading"
  (init-rover '(1 . 1) "N")
  (is (equal (cadr (execute-cmds '("l"))) "W"))
  (init-rover '(1 . 1) "N")
  (is (equal (cadr (execute-cmds '("l" "l"))) "S"))
  (init-rover '(1 . 1) "N")
  (is (equal (cadr (execute-cmds '("l" "l" "l"))) "E"))
  (init-rover '(1 . 1) "N")
  (is (equal (cadr (execute-cmds '("l" "l" "l" "l"))) "N"))
  )

(test turn-rover-right
  "Tests for turning the rover right with changing it's heading"
  (init-rover '(1 . 1) "N")
  (is (equal (cadr (execute-cmds '("r"))) "E"))
  (init-rover '(1 . 1) "N")
  (is (equal (cadr (execute-cmds '("r" "r"))) "S"))
  (init-rover '(1 . 1) "N")
  (is (equal (cadr (execute-cmds '("r" "r" "r"))) "W"))
  (init-rover '(1 . 1) "N")
  (is (equal (cadr (execute-cmds '("r" "r" "r" "r"))) "N"))
  )

(run! 'init-rover)
(run! 'turn-rover-left)
(run! 'turn-rover-right)
