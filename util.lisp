(in-package :silence)

(defun open-auth-url ()
  "opens the account authorization url for the mastodon client"
  (declare (inline open-auth-url) (optimize (speed 3)))
  (multiple-value-bind (idk auth-url) (tooter:authorize *client*)
    (declare (ignore idk))
    (handler-case (open-browser auth-url)
      (uiop:subprocess-error ()))))

(defun urlify (text)
  "adds https scheme to TEXT if it needs it"
  (if (str:starts-with-p "https://" text)
      text
      (str:concat "https://" text)))

(defun save-credentials-for-instance (instance)
  "saves a cache of credentails for INSTANCE"
  (with-open-file (config (merge-pathnames (pathname (str:replace-all "https://" "" instance))
					   *config-store*)
			  :if-exists :overwrite
			  :if-does-not-exist :create
			  :direction :output)
    (format config "key=~A~%secret=~A~%token=~A~%"
                  (tooter:key *client*)
                  (tooter:secret *client*)
                  (tooter:access-token *client*))))

(defun read-credentials-for-instance (instance)
  "reads in a config store and returns them"
  (with-open-file (config (merge-pathnames (pathname (str:replace-all "https://" "" instance))
					   *config-store*)
			  :if-does-not-exist nil
			  :direction :input)
    (when config
      (let ((vals (loop for line = (read-line config nil)
		     while line
		     collect (cadr (str:split #\= line)))))
	(values (car vals)
		(cadr vals)
		(caddr vals))))))


(defun load-domains-into (widget)
  "loads the list of unblocked gab domains into WIDGET"
  (declare (inline load-domains-into))
  (loop for d in (get-unblocked-domains (get-domains))
     do (listbox-insert widget 0 d)))

(defun block-domain (domain)
  "blocks DOMAIN"
  (declare (inline block-domain))
  (tooter:block *client* domain))
