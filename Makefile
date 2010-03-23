#!/usr/bin/make

EXTENSION=zeropersonality

XPI_FILE=$(EXTENSION).xpi
XPI_DEV=$(EXTENSION)-dev.xpi
JAR_FILE=$(EXTENSION).jar

CONTENTS=content

XUL_CONTENTS=$(CONTENTS)/$(EXTENSION).xul
JS_CONTENTS=
LOCALES=

ROOT_CONTENTS=install.rdf chrome.manifest


xpi: jar install.rdf chrome.manifest-prod
	cp chrome.manifest-prod chrome.manifest
	zip $(XPI_FILE) $(ROOT_CONTENTS) $(JAR_FILE)

dev: jar_contents $(OTHER_CONTENTS) chrome.manifest-dev
	cp chrome.manifest-dev chrome.manifest
	zip -r $(XPI_DEV) $(ROOT_CONTENTS) $(LOCALES) $(XUL_CONTENTS) $(JS_CONTENTS) $(CSS_CONTENTS) $(OTHER_CONTENTS)

jar: jar_contents $(OTHER_CONTENTS)
	rm -f $(JAR_FILE)
	zip -r $(JAR_FILE) $(XUL_CONTENTS) $(LOCALES) $(JS_CONTENTS) $(CSS_CONTENTS) $(OTHER_CONTENTS)

jar_contents: $(JS_CONTENTS) $(LOCALES) xulcheck

jstest: $(JS_CONTENTS)
	@for JS in $(JS_CONTENTS); do \
	 	js -w -C -f $${JS}; \
	done;

xulcheck: $(XUL_CONTENTS)

clean:
	rm -f $(XPI_FILE)
	rm -f $(XPI_DEV)
	rm -f $(JAR_FILE)

