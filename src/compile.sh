#!/bin/bash

cd "$(dirname "$0")"

function compile {
    printf "Compiling resume... "

    RESUME_CSS=`lessc resume.less --clean-css="--s0 --advanced" | sed -f parse-apos.sed`
    CONTAINER_CSS=`lessc container.less --clean-css="--s0 --advanced" | sed -f parse-apos.sed`
    RESUME=`jade --obj timeline.json < resume.jade | sed -f parse-apos.sed`

    jade --obj "{ 'css' : '$RESUME_CSS$CONTAINER_CSS', 'resume' : '$RESUME', 'container' : true  }" < container.jade > ../resume.html
    jade --obj "{ 'css' : '$RESUME_CSS',               'resume' : '$RESUME', 'container' : false }" < container.jade > ../embed.html

    cat ../resume.html > ../index.html
    if hash wkhtmltopdf 2>/dev/null; then
        wkhtmltopdf -q ../embed.html ../resume.pdf
    fi

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
