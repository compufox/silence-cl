;;;; silence.lisp

(in-package #:silence)

(defvar *client* nil)
(defvar *fediverse-gab-link*
  "https://fediverse.network/mastodon?age=created&build=gab")
(defvar *config-store*
  #+Unix '"~/.cache/silence/"
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
  (with-ui 
    ))

(defmacro with-ui (&body body)
  "sets up our ui and executes our body in that context"
  `(with-ltk ()
     (let* (())
       ,@body)))

(defun get-unblocked-domains (domains)
  "goes through DOMAINS and returns the ones that havent been blocked"
  (let ((blocked (blocked-domains *client*)))
    (remove-if (lambda (d) (member d blocked)) domains)))

(defun get-domains ()
  "fetches and parses the domains, returning them as a list"
  (loop for element across (select "a.gablink"
			     (parse (get *fediverse-gab-link*)))
     collect (text (last-child element))))


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
;;   (format config "key=~A~%secret=~A~%token=~A~%"
;;                  (key *client*)
;;                  (secret *client*)
;;                  (access-token *client*)))
;;  something like that
