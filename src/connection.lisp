(in-package :cl-fireworq)

(defvar *connection* nil "The current fireworq connection.")

(defclass fireworq-connection ()
  ((host
    :initarg  :host
    :initform "127.0.0.1"
    :reader   conn-host)
   (port
    :initarg  :port
    :initform 8080
    :reader   conn-port)
   (auth
    :initarg  :auth
    :initform nil
    :reader conn-auth))
  (:documentation "Representation of a Fireworq connection."))

(defun connected-p ()
  "Is there a current connection?"
  *connection*)

(defun connect (&key (host "127.0.0.1") (port 8080) auth)
  "Connect to fireworq server."
  (when (connected-p)
    (restart-case (error 'fireworq-error :error "A connection to foreworq server is already established.")
      (:leave ()
       :report "Leave it."
        (return-from connect))
      (:replace ()
       :report "Replace it with a new connection."
        (disconnect))))
  (setf *connection* (make-instance 'fireworq-connection
                                    :host host
                                    :port port
                                    :auth auth)))

(defun disconnect ()
  "Disconnect from fireworq server."
  (when *connection*
    (setf *connection* nil)))

(defmacro with-connection ((&key (host "127.0.0.1") (port 8080) auth)
                           &body body)
  "Evaluate BODY with the current connection bound to a new connection specified by the given HOST and PORT"
  `(let* ((*connection* (make-instance 'fireworq-connection :host ,host :port ,port :auth ,auth)))
     (unwind-protect
          (progn @,body)
       (disconnect))))
