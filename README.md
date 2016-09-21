## Dominic Zirbel's Resume ([View as HTML](http://djynth.github.io/resume) | [Download PDF](http://djynth.github.io/resume/resume.pdf))

A complete resume designed to present a showcase of my experience and skills. This resume is built with HTML and CSS, compiled into a standalone HTML file (`resume.html`) that is ideal for digital viewing, a PDF file (`resume.pdf`) designed to be printable, and an embeddable HTML file (`embed.html`) used to include the resume in other pages. The `index.html` file is a duplicate of `resume.html` to simplify hosting on GitHub Pages. I designed this resume to fulfill the purpose of a traditional resume; in particular, and despite its form, it is _not_ a "virtual tour" or "interactive experience".

Last updated September 2016. References and official transcripts are available on request.

#### Building

To compile the resume from the source, run `src/compile.sh`. Requires [Pug](https://github.com/pugjs/pug) (formerly Jade), [Less](http://lesscss.org/), and [less-plugin-clean-css](https://github.com/less/less-plugin-clean-css). Optionally, [wkhtmltopdf](http://wkhtmltopdf.org/) is required to generate PDF files; make sure to use a version with a patched build of qt and due to issues with the `--dpi` option, use of version 0.12.1 or earlier is recommended on X11 systems. Installing the font files in `src/fonts` is also recommended.

#### License

The source code for this project is free to view and use as inspiration for other projects, but direct modification is not allowed. Copying and distributing unmodified code in this project is allowed as long as attribution to the original author is given.
