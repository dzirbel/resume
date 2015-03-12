#!/bin/bash

cd "$(dirname "$0")"

function compile {
    printf "Compiling resume... "

    CSS=`lessc -x main.less`
    jade resume.jade --out ".." --obj "{ 'css' : '$CSS' }" > /dev/null

    if hash wkhtmltopdf 2>/dev/null; then
        wkhtmltopdf -q ../resume.html ../resume.pdf
    fi

    printf "done.\n"
}

compile

if [ "$1" = "-w" ]; then
    printf "Watching for changes...\n"

    while true; do
        inotifywait -q -q -e close_write,moved_to,create *.jade *.less
        sleep 0.1s
        compile
    done
fi
