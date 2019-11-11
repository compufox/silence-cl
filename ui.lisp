(in-package :silence)


(defun set-entry-placeholder (widget text)
  "sets WIDGET (entry) placeholder TEXT and sets up
bindings for clearing/etc"
  (declare (inline set-entry-placeholder) (optimize (speed 3)))
  (setf (text widget) text)
  (bind widget "<FocusIn>"
	(lambda (evt)
	  (declare (ignore evt))
	  (unless (string= (cget widget :state) "readonly")
	    (setf (text widget) ""))))
  (bind widget "<FocusOut>"
	(lambda (evt)
	  (declare (ignore evt))
	  (when (str:emptyp (text widget))
	    (setf (text widget) text)))))


(defmacro on-click (widget &body body)
  "executes BODY when WIDGET gets the <ButtonPress-1> signal"
  `(bind ,widget "<ButtonPress-1>"
	 (lambda (evt)
	   (declare (ignore evt))
	   ,@body)))

(defun build-ui ()
  "builds our ui and blocks until window is closed"
  (with-ltk ()
    (let* ((frame (make-instance 'frame :master nil
				 :borderwidth 3 :relief :sunken))
	   (instance-entry (make-instance 'entry :master frame :text "instance url"))
	   (login-btn (make-instance 'button :master frame :text "login"))
	   (code-entry (make-instance 'entry :master frame)))
      (pack frame)
      (pack instance-entry)
      (pack login-btn)

      ;; sets up handling our click on the login button
      (on-click login-btn
	(unless (str:emptyp (text instance-entry))
	  (make-client (text instance-entry))
	  (open-auth-url)
	  (configure instance-entry :state "readonly")
	  (pack-forget login-btn)
	  (pack code-entry)
	  (pack login-btn)
	  (on-click login-btn
	    (unless (str:emptyp (text code-entry))
	      (tooter:authorize *client* (text code-entry))
	      (save-credentials-for-instance (text instance-entry))))))

      ;; sets up the placeholders for our entries
      (set-entry-placeholder instance-entry "instance url")
      (set-entry-placeholder code-entry "auth code"))))
