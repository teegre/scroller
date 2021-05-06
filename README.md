```
  @@@@@@  @@@@@@@ @@@@@@@   @@@@@@  @@@      @@@      @@@@@@@@ @@@@@@@
 !@@     !@@      @@!  @@@ @@!  @@@ @@!      @@!      @@!      @@!  @@@
  !@@!!  !@!      @!@!!@!  @!@  !@! @!!      @!!      @!!!:!   @!@!!@!
     !:! :!!      !!: :!!  !!:  !!! !!:      !!:      !!:      !!: :!!
 ::.: :   :: :: :  :   : :  : :. :  : ::.: : : ::.: : : :: ::   :   : :
```

# scroller

## Description

**scroller** is a command line utility that scrolls a line of text.

## Dependencies

bash

## Install

Clone this repository:

`git clone https://gitlab.com/teegre/scroller.git`

Then:

`make install`

## Uninstall

`make uninstall`

## Usage

`scroller -h`  
`scroller -v`  
`scroller [-l <length>] [-d <delay>] [-b <text>] [-e <text>] [-s <separator>] -t <text>`

## Options

*  -h display help screen and exit.
*  -v display program version info and exit.
*  -l maximum text length (default is 45 characters).
*  -d scrolling speed in seconds (default is 0.3 seconds.)
*  -b fixed text at the beginning.
*  -e fixed test at the end.
*  -s separator between start and end of scrolling text (default is " -- ").
*  -t text to scroll.

