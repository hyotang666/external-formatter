(in-package :trivial-formatter-user)

(deformatter sxql create-table (stream exp)
  (format stream "~:<~W~1I ~@_~^~W~^~@:_~:<~@{~W~^~:@_~}~:>~^ ~:_~@{~W~^ ~:_~}~:>"
          exp))

(deformatter sxql set= (stream exp)
  (pprint-fun-call stream exp))

(deformatter sxql where (stream exp)
  (let ((*print-pprint-dispatch* (copy-pprint-dispatch)))
    (set-pprint-dispatch '(cons (member :and :or)) 'pprint-linear-elt)
    (pprint-fun-call stream exp)))

(deformatter caveman2 defroute (stream exp)
  (funcall (pprint-dispatch '(defun) nil) stream exp))

(deformatter envy defconfig (stream exp)
  (funcall (pprint-dispatch '(defparameter) nil) stream exp))

(deformatter hermetic setup (stream exp)
  (pprint-fun-call stream exp t))

(deformatter hermetic auth (stream exp)
  (format stream "~:<~W~^~1I ~@_~W~^~:@_~@{~W~^~_~}~:>" exp))

(deformatter hermetic login (stream exp)
  (funcall (pprint-dispatch '(block) nil) stream exp))

(deformatter ceramic define-entry-point (stream exp)
  (funcall (pprint-dispatch '(defun) nil) stream exp))

(deformatter clim define-application-frame (stream exp)
  (funcall (pprint-dispatch '(defun) nil) stream exp))

(deformatter c2mop set-funcallable-instance-function (stream exp)
  (funcall (pprint-dispatch '(progn) nil) stream exp))

(deformatter uiop define-package (stream exp)
  (funcall (pprint-dispatch '(defpackage) nil) stream exp))

(deformatter translate add-translations (stream exp)
  (funcall (formatter "~:<~W~^ ~1I~@_~W~^ ~_~@{~W~^ ~3I~@_~W~^ ~1I~_~}~:>")
           stream exp))

(deformatter charms with-curses (stream exp)
  (funcall (formatter "~:<~W~^ ~@_~:<~^~@{~W~^ ~:_~}~:>~^ ~1I~_~@{~W~^ ~_~}~:>")
           stream exp))

(deformatter sdl2 with-event-loop (stream exp)
  (trivial-formatter::pprint-handler-case stream exp))

(deformatter sdl2 with-window (stream exp)
  (funcall (formatter "~:<~W~^~1I ~@_~/trivial-formatter:pprint-fun-call/~^ ~_~@{~W~^ ~_~}~:>")
           stream exp))

(deformatter life defresource (stream exp)
  (trivial-formatter::pprint-define-condition  stream exp))

(deformatter uiop nest (stream exp)
  (funcall (formatter "~:<~1I~@{~W~^ ~_~}~:>")
           stream exp))
