#! /bin/bash

## Shrinkwrap: a companion to Flashbake
## by Sputnik Stardust <caffeineandstarstuff@gmail.com>
## Licensed under GNU GPL3 (see LICENSE for details)
## For usage/notes see README


touch .wcCurrent
touch .wordCountLog

cat folders | while read LINE
do
  cd $LINE
  echo "Running shrinkwrap on $LINE..."
## get last word count
  CURRENT=$(cat .wcCurrent)
## get new word count by separating output from wc
  COUNT=$(wc -w * | grep "total")
  set -- $COUNT
  echo $1 > .wcCurrent
## print date and word count to logfile, then run flashbake on folder
  date >> .wordCountLog
  echo $1 >> .wordCountLog
  echo "##" >> .wordCountLog
  flashbake $LINE
  git push origin master
done

## get the total amount of words written since last check and print to stdout
TOTAL=$((COUNT - CURRENT))
echo "Your total since last check is:"
echo $TOTAL

exit
