;;;; silence.asd

(asdf:defsystem #:silence
  :description "block gab fediverse instances"
  :author "ava fox"
  :license  "NPLv1+"
  :version "0.0.1"
  :serial t
  :depends-on (#:ltk #:dexador #:plump
	       #:clss #:tooter #:with-user-abort
	       #:cl-cwd #:trivial-open-browser
	       #:str)
  :components ((:file "package")
	       (:file "ui")
	       (:file "util")
               (:file "silence"))
  :build-operation "program-op"
  :build-pathname "bin/silence"
  :entry-point "silence::main")


#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c) :executable t :compression t))
