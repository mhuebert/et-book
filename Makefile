ALL_OTFS = $(patsubst sfd/%.sfd,otf/%.otf,$(wildcard sfd/*.sfd))
ALL_WOFFS = $(patsubst sfd/%.sfd,woff/%.woff,$(wildcard sfd/*.sfd))
.PHONY: all woff-fonts otf-fonts specimen archive clean

all: woff-fonts otf-fonts specimen archive

otf-fonts: ${ALL_OTFS} | otf
woff-fonts: woff ${ALL_WOFFS} | woff

specimen: specimen/specimen.pdf
archive: build/ETBookOT-otf.tar.gz build/ETBookOT-woff.tar.gz

otf:
	mkdir -p otf
woff:
	mkdir -p woff
build:
	mkdir -p build

otf/%.otf: sfd/%.sfd | otf
	./generatefont.py $< $@
woff/%.woff: sfd/%.sfd | woff
	./generatefont.py $< $@

specimen/specimen.pdf: ${ALL_OTFS} specimen/specimen.tex
	lualatex --output-directory=specimen --halt-on-error specimen/specimen.tex > /dev/null

build/ETBookOT-otf.tar.gz: ${ALL_OTFS} | build
	find otf -name \*.otf | pax -w -s '/^/\ETBookOT-/' | gzip > $@
build/ETBookOT-woff.tar.gz: ${ALL_WOFFS} | build
	find woff -name \*.woff | pax -w -s '/^/\ETBookOT-/' | gzip > $@

clean:
	rm -rf otf woff build specimen/specimen.{log,pdf,aux}
