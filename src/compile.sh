#!/bin/bash

cd "$(dirname "$0")"

function compile {
    printf "Compiling resume... "

    RESUME_CSS=`lessc -x resume.less`
    CONTAINER_CSS=`lessc -x container.less`
    RESUME=`jade < resume.jade`

    jade --obj "{ 'css' : '$RESUME_CSS$CONTAINER_CSS', 'resume' : '$RESUME' }" < container.jade > ../resume.html

    jade --obj "{ 'css' : '$RESUME_CSS' }" < resume.jade > ../embed.html
    echo $RESUME_CSS > ../embed.css

    if hash wkhtmltopdf 2>/dev/null; then
        wkhtmltopdf -q ../embed.html ../resume.pdf
    fi

    echo $RESUME > ../embed.html

    printf "done.\n"
}

compile

if [ "$1" = "-w" ]; then
    while true; do
        inotifywait -q -q -e close_write,moved_to,create *.jade *.less
        sleep 0.1s
        compile
    done
fi
