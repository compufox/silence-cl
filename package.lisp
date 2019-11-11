;;;; package.lisp

(defpackage :silence
  (:use :cl :ltk :with-user-abort)
  (:import-from :plump
		:parse
		:serialize)
  (:import-from :trivial-open-browser
		:open-browser)
  (:import-from :clss
		:select)
  (:shadowing-import-from :dex
			  :get))
(in-package :silence)
