;;;; package.lisp

(defpackage :silence
  (:use :cl :ltk)
  (:import-from :plump
		:parse
		:serialize)
  (:import-from :clss
		:select)
  (:shadowing-import-from :dex
			  :get))
(in-package :silence)

#+Win32
(progn
  (setf (uiop:getenv "PATH")
	(concatenate 'string
		     (uiop:getenv "PATH")
		     ";"
		     (format nil "~a" (merge-pathnames #P"dist/bin/"
						       (cl-cwd:get-cwd))))))
