#!/bin/bash
#
# svgdpi.sh: Script for generating image assets of different DPIs for
# Android from SVG source file, using Inkscape.
#
# Copyright (c) 2015 Zhang Hai <Dreaming.in.Code.ZH@Gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see
# <http://www.gnu.org/licenses/>.
#

usage() {
    local name
    name="$(basename "$0")"
    cat <<EOF
Usage: ${name} SVG_FILE [DIR_PREFIX [DIR_SUFFIX]]
EOF
}

gen-png() {
    local name
    name="$(basename -s.svg $1).png"
    mkdir -p "$3"
    inkscape --export-dpi="$2" --export-png="./$3/$4" "$1"
}

main () {

    if [[ "$#" -lt 1 ]]; then
        usage
        exit 1
    fi

    gen-png "$1" "drawable$2-mdpi$3" '90'
    gen-png "$1" "drawable$2-hdpi$3" '135'
    gen-png "$1" "drawable$2-xhdpi$3" '180'
    gen-png "$1" "drawable$2-xxhdpi$3" '270'
    gen-png "$1" "drawable$2-xxxhdpi$3" '360'
}

main "$@"
