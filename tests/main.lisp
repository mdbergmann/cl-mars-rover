(defpackage cl-mars-rover-tests
  (:use :cl
        :cl-mars-rover
        :fiveam)
  (:export #:run!
           #:all-tests
           #:nil))
(in-package :cl-mars-rover-tests)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-mars-rover)' in your Lisp.
(test trivial
  "Trivial test"
  (is (= 1 1)))

(run! 'trivial)
