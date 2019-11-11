;;;; package.lisp

(defpackage :silence
  (:use :cl :ltk)
  (:import-from :tooter
		:client
		:authorize
		:block
		:blocked-domains)
  (:import-from :plump
		:parse
		:serialize)
  (:import-from :clss
		:select)
  (:shadowing-import-from :dex
			  :get))
