This is a helper for [Factorio](http://www.factorio.com/) mod makers.
It is a Makefile (tested only with GNU make) that automates the creation of mod
packages from source, including performing some simple keyword expansion (of
tokens like `{{VERSION}}`) in the `info.json` and `*.lua` files.


## Setup ##

To start using this makefile for your package, you'll need to create a few very
simple files:

- The file `PKG_NAME` should contain the name of your mod package. Create it
with something like `echo My-Awesome-Mod > PKG_NAME`.

- The file `VERSION` should contain your current package version. Create it
with something like `echo 1.0.0 > VERSION`.
    - Note: this file is optional. You can also supply the version at run-time,
    either by setting the environment variable VERSION, or by passing it as a
    `make` argument as in `make VERSION=1.0.2`.
    - Alternately, you can create the file `SHORT_VERSION`, which should
    contain a two-part version number (e.g., `0.6`) -- the third part will be
    filled in by appending the number of commits since the last tag matching
    the `v[0-9]*.[0-9]*` wildcard.

- The file `PKG_COPY` should contain a list of any files or folders that should
be directly copied to the output package, i.e., without any variable expansion.
Note that lua files are automatically included regardless of where they are in
the directory tree. Create it with something like `echo locale > PKG_COPY`.
    - Note: the file may contain the names separated by spaces or newlines --
    make doesn't care.
    - Further note: this file is also optional -- if left out, `info.json`,
    `*.md`, and `*.lua` files will be automatically included.


## Usage ##

Once your setup is completed, it should be as simple as typing `make` -- the
output package will be left in the `pkg` directory, which will be created if
necessary.

Should you wish it, you may invoke the specific target `make package`, and
there is also a `make clean` that will clean up the intermediate files, should
you wish to do a completely fresh repackaging.


## Keyword replacements ##

It is possible to insert some tags into your `info.json` or `*.lua` that will
get automatically replaced with the right values from your current
configuration.

At present, there are two possible tags (and they are case-sensitive):

- `{{MOD_NAME}}` (including the braces) will get replaced with the package
name, as set in the `PKG_NAME` file. So if your `info.json` says
`"name":"{{MOD_NAME}}"`, it will be replaced by `"name":"My-Awesome-Mod"`.

- `{{VERSION}}` (including the braces) will get replaced with the version,
given as explained above. Again, this is most useful for your `info.json`
-- `"version":"{{VERSION}}"` will become `"version":"1.0.2"`.

- `{{__FILE__}}` (including the braces and underscores) will get replaced by
the path of the file being processed, relative to the `make` working directory.
In most cases, this should be the plain filename, or something like
`subdir/file.lua`. This is occasionally useful (for, e.g., logging warnings).


## License ##

The source of **factorio-mod-makefile** is Copyright 2015 Octav "narc"
Sandulescu. It is licensed under the [MIT license][mit], available in this
package in the file [LICENSE.md](LICENSE.md).

[mit]: http://opensource.org/licenses/mit-license.html


## Statistics ##

12 'Stop' errors were encountered during the development of this tool. All of
them were terminated with extreme prejudice.
