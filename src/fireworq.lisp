(in-package :cl-fireworq)

(define-condition fireworq-error (error)
    ((error :initform nil
            :initarg :error
            :reader fireworq-error-error)
     (message :initform nil
              :initarg :message
              :reader fireworq-error-message))
  (:report (lambda (e stream)
             (format stream
                     "Fireworq error: ~A~:[~;~2&~:*~A~]"
                     (fireworq-error-error e)
                     (fireworq-error-message e))))
  (:documentation "Any fireworq-related error."))

(define-condition fireworq-error-reply (fireworq-error)
  ()
  (:documentation "Error reply is received from fireworq server."))


(defparameter *cmd-prefix* 'fwq
  "Prefix for functions names that implement fireworq commands.")

;; TODO: cl-jsonがfoo-bar形式のキーを勝手にfooBarに置換しないようにする
;; TODO: 省略可能オプションを実装する

(defmacro def-cmd (cmd (&rest pathparams) (&rest args) method path docstring)
  "Define and export a function with the name <*CMD-REDIX*>-<CMD> for
processing a fireworq command CMD."
  (let ((cmd-name (intern (fmt "~:@(~A-~A~)" *cmd-prefix* cmd))))
    `(eval-always
       (defun ,cmd ,(concatenate 'list pathparams args)
         ,docstring
         (cl-json:decode-json
          (flet ((args-to-content (actual-args) (with-output-to-string (s) (cl-json:encode-json-alist (mapcar #'cons ',args actual-args) s))))
            ,(ecase method
               (:get
                `(dex:get
                  (quri:make-uri
                   :scheme "http"
                   :host (conn-host *connection*)
                   :port (conn-port *connection*)
                   :path ,(concatenate 'list `(format nil ,path) pathparams))
                  :headers '(("Content-Type" . "application/json"))
                  :want-stream t
                  :basic-auth (conn-auth *connection*)))
               (:post
                `(dex:post
                  (quri:make-uri
                   :scheme "http"
                   :host (conn-host *connection*)
                   :port (conn-port *connection*)
                   :path ,(concatenate 'list `(format nil ,path) pathparams))
                  :headers '(("Content-Type" . "application/json"))
                  :content (args-to-content (list ,@args))
                  :want-stream t
                  :basic-auth (conn-auth *connection*)))
               (:put
                `(dex:put
                  (quri:make-uri
                   :scheme "http"
                   :host (conn-host *connection*)
                   :port (conn-port *connection*)
                   :path ,(concatenate 'list `(format nil ,path) pathparams))
                  :headers '(("Content-Type" . "application/json"))
                  :content (args-to-content (list ,@args))
                  :want-stream t
                  :basic-auth (conn-auth *connection*)))
               (:delete
                `(dex:delete
                  (quri:make-uri
                   :scheme "http"
                   :host (conn-host *connection*)
                   :port (conn-port *connection*)
                   :path ,(concatenate 'list `(format nil ,path) pathparams))
                  :headers '(("Content-Type" . "application/json"))
                  :want-stream t
                  :basic-auth (conn-auth *connection*)))))))
       (abbr ,cmd-name ,cmd)
       (export ',cmd-name '#:cl-fireworq)
       (import ',cmd '#:fwq)
       (export ',cmd '#:fwq))))
