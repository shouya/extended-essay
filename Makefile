TEX := latex
DVI2PDF := dvipdf
MKIDX := makeindex
PDFTEX := pdflatex

SOURCES = $(wildcard *.tex)
TEXFILE = ee.tex

IDXFILE = $(TEXFILE:.tex=.idx)
DVIFILE = $(TEXFILE:.tex=.dvi)
PDFFILE = $(TEXFILE:.tex=.pdf)

all: $(PDFFILE)


.PHONY : $(DVIFILE)
$(DVIFILE): $(TEXFILE) $(SOURCES)
	$(TEX) $(TEXFILE)

directPDF: $(TEXFILE)
	$(PDFTEX) $<

$(PDFFILE): $(DVIFILE)
	$(DVI2PDF) $<

full: $(DVIFILE) index $(DVIFILE) $(PDFFILE)


index: $(IDXFILE)
	$(MKIDX) $<

view: $(PDFFILE)
	evince $<


.PHONY : clean
.SILENCE : clean
clean:
	/bin/rm -f  *.dvi *.log *.aux *~ *.fdb_latexmk \
                    *.pdf *.toc *.ind *.idx *.ilg *.lof *.lot \
                    *.xdv *.blg *.bbl *.out

