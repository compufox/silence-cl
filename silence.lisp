;;;; silence.lisp

(in-package #:silence)

(defvar *domain-cache* nil)
(defvar *client* nil)
(defvar *fediverse-gab-link*
  "https://fediverse.network/mastodon?age=created&build=gab")
(defvar *config-store*
  #+Unix "~/.cache/silence/"
  #+Win32 (let ((p (uiop:getenv "APPDATA")))
	    (concatenate 'string p "/silence/")))

;; ensure cache directories exist
;; (creating if needed) read file and parse contents
;; create ui
;; fill in fields with config data (if existed)
;; get links (on button click)
;; show if a link has been blocked already with some gui thing
;; block links (on click)
(defun main ()
  (ensure-directories-exist *config-store*)
  (handler-case (with-user-abort
		  (build-ui))
    (user-abort () (uiop:quit 1))))

(defun get-unblocked-domains (domains)
  "goes through DOMAINS and returns the ones that havent been blocked"
  (let ((blocked (tooter:blocked-domains *client*)))
    (remove-if (lambda (d) (member d blocked)) domains)))

(defun get-domains ()
  "fetches and parses the domains, returning them as a list"
  (unless *domain-cache*
    (setf *domain-cache* (loop for element across (select "a.gablink"
							  (parse (get *fediverse-gab-link*)))
			    collect (plump:text (plump:last-child element)))))
  *domain-cache*)

(defun make-client (instance &key key secret access-token)
  "creates a client object for INSTANCE"
  (declare (inline make-client) (optimize (speed 3)))
  (setf *client* (make-instance 'tooter:client
				:base (urlify instance)
				:key key
				:secret secret
				:access-token access-token
				:name "silence-cl"
				:scopes '("write:blocks" "read:blocks")
				:website "https://github.com/theZacAttacks/silence-cl")))

;; with tooter library:
;; (file does not exist) get instance from ui, authorize, save token
;; (file exists) get data from file
;; create client
;;  (multiple-values-bind (idk auth-url) (authorize *client*))
;; block domains
;;  (blocked-domains *client*)
;;  (block "mastodon.social")

;; to save
;;  save key, secret, access-token, instance url
;;
;; (with-open-file (config :direction :out
;;                         :if-exists :overwrite)
;;   )
;;  something like that
