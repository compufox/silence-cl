LISPS = sbcl ros clisp cmucl ccl

ifeq ($(OS),Windows_NT)
	WHERE = where
else
	WHERE = which
endif

ifeq ($(OS),Windows_NT)
	NULL = >NUL
else
	NULL = 2>/dev/null
endif

CMDS = --load silence.asd --eval '(ql:quickload :silence)' --eval '(asdf:make :silence)'  --eval '(quit)'

# this doesnt seem to work in windows?
LISP := $(foreach lisp,$(LISPS), \
	$(if $(findstring $(lisp),"$(shell $(WHERE) $(lisp) $(NULL))"), $(strip $(lisp)),))

ifeq ($(LISP),)
	$(error "No lisps found")
endif

build:
	$(LISP) $(CMDS)
