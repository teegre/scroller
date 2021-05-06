#! /usr/bin/env bash

#  @@@@@@  @@@@@@@ @@@@@@@   @@@@@@  @@@      @@@      @@@@@@@@ @@@@@@@
# !@@     !@@      @@!  @@@ @@!  @@@ @@!      @@!      @@!      @@!  @@@
#  !@@!!  !@!      @!@!!@!  @!@  !@! @!!      @!!      @!!!:!   @!@!!@!
#     !:! :!!      !!: :!!  !!:  !!! !!:      !!:      !!:      !!: :!!
# ::.: :   :: :: :  :   : :  : :. :  : ::.: : : ::.: : : :: ::   :   : :
#
# Copyright (C) 2021, Stéphane MEYER <Teegre>.
#
# Scroller is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>
#
# SCROLLER
# C : N/A
# M : 2021/05/06
# D : Text scrolling.

usage() {
cat << EOB
Usage:
  scroller -h
  scroller -v
  scroller [-l <length>] [-d <delay>] [-b <text>] [-e <text>] [-s <separator>] -t <text>

Options:
  -h display help screen and exit.
  -v display program version info and exit.
  -l maximum text length (default is 45 characters).
  -d scrolling delay in seconds (default is 0.3 seconds.)
  -b fixed text at the beginning.
  -e fixed test at the end.
  -s separator between start and end of scrolling text (default is " -- ").
  -t text to scroll

EOB
}

declare __version="1.0.1"

exit_abnormal() {
  usage
  exit 1
}

version() {
  echo "scroller version ${__version} (c) 2021 copyright teegre"
  echo "This is free software with ABSOLUTELY NO WARRANTY."
}

while getopts "l:d:b:e:s:t:hv" opt; do
  case "$opt" in
  l)
    MAXLEN=$OPTARG
    if ! [[ "$MAXLEN" =~ ^[0-9]+$ ]]; then
       echo "${0##*/}: length must be an integer."
       exit 1
    elif [[ "$MAXLEN" -le 0 ]]; then
      echo "${0##*/}: length must be greater than 0."
      exit 1
    fi
    ;;
  d)
    DELAY=$OPTARG
    if ! [[ "$DELAY" =~ ^[0-9]+\.[0-9]+$|^[0-9]+$ ]]; then
      echo "${0##*/}: delay must be a number."
      exit 1
    elif [[ "$DELAY" == "0" ]]; then
      echo "${0##*/}: delay must be greater than 0."
      exit 1
    fi
    ;;
  b)
    BEGIN_TEXT=$OPTARG
    ;;
  e)
    END_TEXT=$OPTARG
    ;;
  s)
    SEPARATOR=$OPTARG
    ;;
  t)
    TEXT=$OPTARG
    ;;
  h)
    usage
    exit 0
    ;;
  v)
    version
    exit 0
    ;;
  :)
    echo "${0##*/}: -$OPTARG requires an argument."
    exit_abnormal
    ;;
  *)
    echo "${0##*/}: unknown option -$OPTARG"
    exit_abnormal
  esac
done

if [[ -z "$TEXT" ]]; then
  >&2 echo "scroller: no text to display!"
  exit 1
fi

if [[ -t 0 && -t 1 ]] || [[ $TERM != "linux" ]]; then
  clear
fi

BEGIN_TEXT=${BEGIN_TEXT:-}
END_TEXT=${END_TEXT:-}
SEPARATOR=${SEPARATOR:-" -- "}
MAXLEN=${MAXLEN:-45}
DELAY="${DELAY:-0.3}"
substring="$TEXT"
endstring="${SEPARATOR}${TEXT}"
((LEN=${#TEXT}))
INDEX=0
START=0
END=0

while :; do
  if ((LEN > MAXLEN)); then
    if [[ "$INDEX" -ge "((LEN-MAXLEN))" ]]; then
      substring="${TEXT:$INDEX:$MAXLEN}${endstring:$START:$END}"
      if ((INDEX < LEN)); then
        ((INDEX++))
      else
        ((START++))
        ((END=MAXLEN-1))
      fi
      ((END++))
      [[ "$substring" == "${TEXT:0:$MAXLEN}" ]] && {
      INDEX=0
      continue
      }
    else
      substring="${TEXT:$INDEX:$MAXLEN}"
      ((INDEX++))
      START=0
      END=0
    fi
  fi
  if ((LEN <= MAXLEN)); then
    printf "%s %-${MAXLEN}s %s\n" "$BEGIN_TEXT" "$substring" "$END_TEXT"
    exit 0
  else
    if [[ -t 0 && -t 1 ]] || [[ $TERM != "linux" ]]; then
      printf "\033[0;0f"
    fi
    echo "$BEGIN_TEXT $substring $END_TEXT"
    sleep "$DELAY"
  fi
done
