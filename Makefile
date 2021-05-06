PROGNAME  ?= scroller
PREFIX    ?= /usr
BINDIR    ?= $(PREFIX)/bin
SHAREDIR  ?= $(PREFIX)/share

.PHONY: install
install: $(PROGNAME).sh
	install -d  $(DESTDIR)$(BINDIR)

	install -m755  $(PROGNAME).sh $(DESTDIR)$(BINDIR)/$(PROGNAME)
	
	install -Dm644 LICENSE -t $(DESTDIR)$(SHAREDIR)/licenses/$(PROGNAME)

.PHONY: uninstall
uninstall:
	rm $(DESTDIR)$(BINDIR)/$(PROGNAME)
	rm -rf $(DESTDIR)$(SHAREDIR)/licenses/$(PROGNAME)
