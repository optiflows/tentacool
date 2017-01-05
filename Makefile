BINDIR := $(DESTDIR)/usr/bin/


build:
	mv /tmp/tentacool tentacool

install: bindir
	install tentacool $(BINDIR)

bindir:
	mkdir -p $(BINDIR)

clean:
	rm -rf tentacool
