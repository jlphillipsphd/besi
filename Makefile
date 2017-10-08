BASENAME = Morton-Phillips_Computational_Advances
MAINPROG = pdflatex --shell-escape

main: pdftex

dvi:
	$(MAINPROG) --output-format dvi $(BASENAME).tex
	bibtex ${BASENAME}.aux
	$(MAINPROG) --output-format dvi $(BASENAME).tex
	$(MAINPROG) --output-format dvi $(BASENAME).tex

pdf: ps
	ps2pdf $(BASENAME).ps

ps: dvi
	dvips -t letter -Ppdf -G0 $(BASENAME).dvi

pdftex:
	$(MAINPROG) $(BASENAME).tex
	# bibtex ${BASENAME}.aux
	$(MAINPROG) $(BASENAME).tex
	$(MAINPROG) $(BASENAME).tex

supp:
	$(MAINPROG) $(BASENAME)-supp.tex
	bibtex ${BASENAME}-supp.aux
	$(MAINPROG) $(BASENAME)-supp.tex
	$(MAINPROG) $(BASENAME)-supp.tex

clean:
	rm $(BASENAME).bbl $(BASENAME).blg $(BASENAME).log *.aux $(BASENAME).lof $(BASENAME).toc $(BASENAME).lot $(BASENAME).out $(BASENAME)-supp.log

update: updatepdf

updatepdf: updatelatex
	dvipdf $(BASENAME)-update.dvi

updatelatex:
	latex $(BASENAME)-update.tex
	bibtex ${BASENAME}.aux
	latex $(BASENAME)-update.tex
	latex $(BASENAME)-update.tex

cleanupdate:
	rm $(BASENAME)-update.bbl $(BASENAME)-update.blg $(BASENAME)-update.log *.aux $(BASENAME)-update.lof $(BASENAME)-update.toc $(BASENAME)-update.lot $(BASENAME)-update.out $(BASENAME)-supp.log
