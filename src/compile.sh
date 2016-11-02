#!/bin/bash

cd "$(dirname "$0")"
TITLE1="Dominic Zirbel\\'s Resume"
TITLE2="Dominic Zirbel's Resume"

function compile {
    printf "Compiling resume... "

    RESUME_CSS=`lessc resume.less --clean-css="--s0 --advanced" | sed -f parse-apos.sed`
    CONTAINER_CSS=`lessc container.less --clean-css="--s0 --advanced" | sed -f parse-apos.sed`
    PDF_CSS=`lessc pdf.less --clean-css="-s0 --advanced" | sed -f parse-apos.sed`
    RESUME=`pug --obj timeline.json < resume.jade | sed -f parse-apos.sed`

    pug --obj "{ 'css' : '$RESUME_CSS$CONTAINER_CSS', 'content' : '$RESUME', 'container' : true,  'title' : '$TITLE1' }" < container.jade > ../resume.html
    pug --obj "{ 'css' : '$RESUME_CSS',               'content' : '$RESUME', 'container' : false, 'title' : '$TITLE1' }" < container.jade > ../embed.html
    pug --obj "{ 'css' : '$RESUME_CSS$PDF_CSS',       'content' : '$RESUME', 'container' : false, 'title' : '$TITLE1' }" < container.jade > ../pdf.html

    cat ../resume.html > ../index.html
    if hash wkhtmltopdf 2>/dev/null; then
        wkhtmltopdf -q --page-size Letter --dpi 96 --title "$TITLE2" ../pdf.html ../resume.pdf
    fi
    rm ../pdf.html

    printf "done.\n"
}

compile

if [ "$1" = "-w" ]; then
    while true; do
        inotifywait -q -q -e close_write,moved_to,create *.jade *.less *.json
        sleep 0.1s
        compile
    done
fi
