# BashFOX
A small bash script builder/framework.

## Installation
### Using an install script (Recommended)
By this way, you will need Bash, cURL, Perl, and coreutils installed. You will not need Git.
```bash
curl -L https://github.com/romw314/bashfox/raw/master/install.bash | bash
. ~/.bashrc
```
Please note that the install script modifies your `.bashrc`, which means that you need to use `. ~/.bashrc` in order to use BashFOX.

### Manually
This way you will need Git and coreutils installed.
```bash
git clone https://github.com/romw314/bashfox
cd bashfox
chmod 755 bashfox.bash
mkdir -p ~/.local/bin
cp bashfox.bash ~/.local/bin/bashfox
```
Please ensure that `~/.local/bin` is in your path after manual installation.

## Uninstallation
You will need Bash, cURL, Perl, and coreutils installed. You will not need Git.
If you installed BashFOX with the install script uninstall it with:
```bash
curl -L https://github.com/romw314/bashfox/raw/master/uninstall.bash | bash
```

Elsewhere, simply remove the symlink from `~/.local/bin`:
```bash
rm ~/.local/bin/bashfox
```

## Usage
Write your code to `.bash` files. See the examples for more information.

Write your entry code to `main.bash`.

Write your configuration to `bashfox.conf` (see the examples).

Compile it using `bashfox`.

## Example

### `src/main.bash`
```bash
# It's important not to place comments on the same line as `import`, `debug`, `warn`, or any other BashFOX command.
# `import` imports a script without building it (useful for importing libraries that are already built, see lib/lib.bash)
import ../lib/lib.bash
debug  "This shows only if you use DEBUG=1"
notice "EXAMPLE notice"
info   "hello"
warn   "There is no useful code in this script"
if [ "$1" == "hello" ]; then
	fatal "The first argument shouldn't be 'hello'"
fi
# Include is the same as `import`, but builds the script.
# Script imported by `include` can contain BashFOX commands.
include extras/help.bash
error "Something went wrong"
```

### `src/extras/help.bash`
```bash
# lib.bash is imported only once because of the _LIB_BASH variable.
import ../../lib/lib.bash

if [ "$1" == "help" ]; then
	info "USAGE:"
	info "$0 $(lib.wrap_in_brackets help) ..."
	info "Don't pass 'hello' to the first argument!"
	exit
fi
```

### `lib/lib.bash`
```bash
# Here we can't use BashFOX commands.

if [ -z "$_LIB_BASH" ]; then
	_LIB_BASH= # We don't export this, because we want to re-import the library in scripts executed (not imported) from main.bash.

	# This library is named 'lib'. We don't have namespaces in bash, but we can declare functions with a dot.
	lib.wrap_in_brackets() {
		declare result='' # Declare uses local variables unless -g is passed, so it is right here.
		while (( "$#" )); do
			result="$result $1"
			shift
		done
		echo "${result:1}"
	}
fi
```

### `bashfox.conf`
```
OUTPUT=outscript.bash # The output bash script
SOURCE=src            # The directory where main.bash is
```

### Compilation and running
```bash
$ bashfox
BashFOX by romw314
SUCCESS
$ ./outscript.bash
[NOTICE] EXAMPLE notice
[ INFO ] hello
[ WARN ] There is no useful code in this script
[  ERR ] Something went wrong
$ ./outscript.bash hello
[NOTICE] EXAMPLE notice
[ INFO ] hello
[ WARN ] There is no useful code in this script
[ FATAL] The first argument shouldn't be 'hello'
$ ./outscript.bash help
[NOTICE] EXAMPLE notice
[ INFO ] hello
[ WARN ] There is no useful code in this script
[ INFO ] USAGE:
[ INFO ] ./outscript.bash [help] ...
[ INFO ] Don't pass 'hello' to the first argument!
```
