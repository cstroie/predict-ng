VERSION  := $(shell cat .version)
CC       ?= cc
PREFIX   ?= /usr/local
DATADIR   = $(PREFIX)/share/predict/

CFLAGS   = -Wall -O3 -s -fomit-frame-pointer \
           -DVERSION='"$(VERSION)"' \
           -DDATADIR='"$(DATADIR)"' \
           -DSOUNDCARD=$(SOUNDCARD)
LIBS     = -lm -lncurses -lpthread

# Vocalizer: build with  make VOCALIZER=1
# Requires /dev/dsp (OSS soundcard)
ifdef VOCALIZER
  ifneq ($(wildcard /dev/dsp),)
    SOUNDCARD       = 1
    VOCALIZER_BIN   = vocalizer
    VOCALIZER_CFLAGS = -DVOCALIZERDIR='"$(DATADIR)sounds/"'
  else
    $(warning /dev/dsp not found — vocalizer will not be built)
    SOUNDCARD = 0
  endif
else
  SOUNDCARD = 0
endif

.PHONY: all install uninstall clean

all: predict predict.1 $(VOCALIZER_BIN)

predict: predict.c
	$(CC) $(CFLAGS) predict.c $(LIBS) -o predict

predict.1: predict.man
	groff -T ascii -man predict.man > predict.1

vocalizer: vocalizer.c
	$(CC) $(CFLAGS) $(VOCALIZER_CFLAGS) vocalizer.c -o vocalizer

install: all
	install -d $(PREFIX)/bin
	install -m 755 predict $(PREFIX)/bin/predict
	install -m 755 kepupdate $(PREFIX)/bin/kepupdate
	install -d $(PREFIX)/share/man/man1
	install -m 644 predict.man $(PREFIX)/share/man/man1/predict.1
	install -d $(DATADIR)
	install -m 644 default/predict.tle $(DATADIR)
	install -m 644 default/predict.db $(DATADIR)
	install -m 644 default/predict.qth $(DATADIR)
ifdef VOCALIZER_BIN
	install -m 755 vocalizer $(PREFIX)/bin/vocalizer
	install -d $(DATADIR)sounds
	install -m 644 sounds/*.wav $(DATADIR)sounds/
endif

uninstall:
	rm -f $(PREFIX)/bin/predict
	rm -f $(PREFIX)/bin/kepupdate
	rm -f $(PREFIX)/bin/kep_update
	rm -f $(PREFIX)/bin/earthtrack
	rm -f $(PREFIX)/bin/earthtrack2
	rm -f $(PREFIX)/bin/geosat
	rm -f $(PREFIX)/bin/map
	rm -f $(PREFIX)/share/man/man1/predict.1
	rm -rf $(DATADIR)
ifdef VOCALIZER_BIN
	rm -f $(PREFIX)/bin/vocalizer
endif

clean:
	rm -f predict predict.1
	[ ! -f vocalizer ] || rm -f vocalizer
