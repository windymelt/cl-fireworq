#|
  This file is a part of cl-fireworq project.
  Copyright (c) 2019 Windymelt
|#

(defsystem "cl-fireworq-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Windymelt"
  :license "Apache License 2"
  :depends-on ("cl-fireworq"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "cl-fireworq"))))
  :description "Test system for cl-fireworq"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
