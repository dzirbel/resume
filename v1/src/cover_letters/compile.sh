#!/bin/bash

cd "$(dirname "$0")"
TITLE="Cover Letter | Dominic Zirbel"

printf "Compiling cover letters... "

RESUME_CSS=`lessc ../resume.less --clean-css="--s0 --advanced" | sed -f ../parse-apos.sed`
CONTAINER_CSS=`lessc ../container.less --clean-css="--s0 --advanced" | sed -f ../parse-apos.sed`
PDF_CSS=`lessc ../pdf.less --clean-css="-s0 --advanced" | sed -f ../parse-apos.sed`
COVER_LETTER_CSS=`lessc cover_letter.less --clean-css="-s0 --advanced" | sed -f ../parse-apos.sed`

for file in $1
do
    COVER_LETTER=`pug < "$file" | sed -f ../parse-apos.sed`
    filename=$(basename "$file")
    filename="${filename%.*}"

    pug --obj "{ 'css' : '$COVER_LETTER_CSS$RESUME_CSS$CONTAINER_CSS', 'content' : '$COVER_LETTER', 'container' : true,  'title' : '$TITLE' }" < ../container.jade > $filename.html
    pug --obj "{ 'css' : '$COVER_LETTER_CSS$RESUME_CSS$PDF_CSS',       'content' : '$COVER_LETTER', 'container' : false, 'title' : '$TITLE' }" < ../container.jade > pdf.html

    if hash wkhtmltopdf 2>/dev/null; then
        wkhtmltopdf -q --page-size Letter --dpi 96 --title "$TITLE" pdf.html $filename.pdf
    fi
    rm pdf.html
done

printf "done.\n"
