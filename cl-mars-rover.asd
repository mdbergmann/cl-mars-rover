(defsystem "cl-mars-rover"
  :version "0.1.0"
  :author "Manfred"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "cl-mars-rover/tests"))))

(defsystem "cl-mars-rover/tests"
  :author "Manfred"
  :license ""
  :depends-on ("cl-mars-rover"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cl-mars-rover"

  :perform (test-op (op c) (symbol-call :rove :run c)))
