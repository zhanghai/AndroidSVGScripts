#!/bin/bash
#
# shsvgdpi.sh: Script for generating image assets of different DPIs
# for Android from SHSVG source file, using Inkscape.
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

calc() {
    input="${@//pi/π}"
    # Round as in TypedValue.complexToDimensionPixelSize()
    # Not using `xargs printf '%.0f'` because
    # `echo 196.5 | xargs printf '%.0f'` gives 196 instead of 197 due
    # to floating point.
    echo -ne "${input}\nquit" | gcalccmd | sed 's:^> ::g' | xargs printf 'scale=0;(%s+0.5)/1\n' | bc
}
dp() {
    echo "(($@) * ${scale})"
}
export -f calc dp

usage() {
    local name
    name="$(basename "$0")"
    cat <<EOF
Usage: ${name} SHSVG_FILE [DIR_PREFIX [DIR_SUFFIX]]
EOF
}

gen-png() {

    local name
    name="$(basename -s.shsvg "$1")"
    local dir
    dir="$2"
    local scale
    scale="$3"

    mkdir -p "${dir}"

    bash <<EOF
scale="${scale}"

if [[ -e "$1.conf" ]]; then
    source "$1.conf"
fi

cat >"${dir}/${name}.svg" << EOF2
$(cat "$1")
EOF2
EOF

    inkscape --export-png="${dir}/${name}.png" "${dir}/${name}.svg"

    rm "${dir}/${name}.svg"
}

main() {

    if [[ "$#" -lt 1 ]]; then
        usage
        exit 1
    fi

    gen-png "$1" "drawable$2-mdpi$3" '1'
    gen-png "$1" "drawable$2-hdpi$3" '1.5'
    gen-png "$1" "drawable$2-xhdpi$3" '2'
    gen-png "$1" "drawable$2-xxhdpi$3" '3'
    gen-png "$1" "drawable$2-xxxhdpi$3" '4'
}

main "$@"
