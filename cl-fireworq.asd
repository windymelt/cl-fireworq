#|
  This file is a part of cl-fireworq project.
  Copyright (c) 2019 Windymelt
|#

#|
  Author: Windymelt
|#

(defsystem "cl-fireworq"
  :version "0.1.0"
  :author "Windymelt"
  :license "Apache License 2"
  :depends-on ()
  :serial t
  :components ((:module "src"
                :components
                ((:file "package"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "cl-fireworq-test"))))
