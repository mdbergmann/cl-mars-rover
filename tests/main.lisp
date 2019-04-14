(defpackage cl-mars-rover/tests/main
  (:use :cl
        :cl-mars-rover
        :rove))
(in-package :cl-mars-rover/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-mars-rover)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
