(defpackage cl-mars-rover-tests
  (:use :cl
        :cl-mars-rover
        :fiveam)
  (:export #:run!
           #:all-tests
           #:nil))
(in-package :cl-mars-rover-tests)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-mars-rover)' in your Lisp.


(test rover-init
  "Tests for initializing the rover"
  (is (eq (car (rover-init '(1 . 1) 'North)) '(1 . 1)))
  (is (eq (car (rover-init '(1 . 2) 'North)) '(1 . 2)))
  (is (eq (cadr (rover-init '(1 . 1) 'North)) 'North))
  (is (eq (cadr (rover-init '(1 . 1) 'South)) 'South)))

(run! 'rover-init)
