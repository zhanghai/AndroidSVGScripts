# Android SVG Scripts

Bash scripts to automate and extend the process of using SVG as Android image asset.

This project is also used by [DreaminginCodeZH/MaterialColdStart](https://github.com/DreaminginCodeZH/MaterialColdStart).

## Dependencies

- inkscape: For PNG genration
- gcalccmd (shsvgdpi.sh): For (friendly) mathematical calculation.

## svgdpi.sh

```
Usage: svgdpi.sh SVG_FILE [DIR_PREFIX [DIR_SUFFIX]]
```

This script can automatically generate PNG asset of different Dips from SVG arranged properly for direct usage in Android application.

For instance:

```
./svgdpi.sh path/to/your/file.avg
```

Will output the following files:

```
drawable-mdpi/file.png
drawable-hdpi/file.png
drawable-xhdpi/file.png
drawable-xxhdpi/file.png
drawable-xxxhdpi/file.png
```

You can also add prefix and suffix to the drawable directory name with command line arguments. See the script source for more detail.

## shsvgdpi.sh

```
Usage: shsvgdpi.sh SHSVG_FILE [DIR_PREFIX [DIR_SUFFIX]]
```

This script implemented a powerful new file format called ShellSVG (`.shsvg`), which allows you to embed any shell command/parameter substitution inside your SVG file.

`dp` (Device-independent Pixel) is supported as an exported function `dp()`, and mathematical expression is supported as an exported function `calc()`. You need to wrap `dp()` inside a `calc()` if it is used.

This makes drawing Nine-patch bitmaps where the surrounding lines are always `1px` while the content must be drawn in `dp` easy.

What's more, you can now use parameters inside your SVG, a dimension, a color, a filter, everything is OK. Just do it as in shell, for instance `${SOME_PARAMETER}`. Parameter definitions can be written in a `.conf` file which will be `source`-ed before generation of a standard SVG file, which means this file can have all the shell semantics apart from regular key-value pair, such as `source`-ing another `.conf`.

This script has taken rounding on HDPI (with scaling factor 1.5) into account, so that nine-patch bitmaps won't have an anti-aliased border. It is recommended that you call `dp()` for every single `dp` dimension separately to avoid accumulated rounding inconsistency.

The usage of this script is just like `svgdpi.sh`.

For a detailed example, see the [sample/](sample/) directory.

## License

```
Copyright (c) 2015 Zhang Hai <Dreaming.in.Code.ZH@Gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see
<http://www.gnu.org/licenses/>.
```
