MAKE_SLIDES = elm-make Slides.elm --output dist/slides.js

slides:
	$(MAKE_SLIDES)

watch:
	hobbes Slides.elm | xargs -I {} $(MAKE_SLIDES)

pack:
	tar -cf dist/buffer.tar *.html static/*
