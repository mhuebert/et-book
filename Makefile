.PHONY: all dirs woff otf

all: woff otf

otf: dirs $(patsubst sfd/%.sfd,otf/%.otf,$(wildcard sfd/*.sfd))
woff: dirs $(patsubst sfd/%.sfd,woff/%.woff,$(wildcard sfd/*.sfd))

dirs:
	mkdir -p otf
	mkdir -p woff

otf/%.otf: sfd/%.sfd
	./generatefont.py $< $@
woff/%.woff: sfd/%.sfd
	./generatefont.py $< $@
