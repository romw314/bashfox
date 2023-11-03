# BashFOX
A small bash script builder/framework.

## Installation
### Using an install script (Recommended)
```bash
curl -L https://github.com/romw314/bashfox/raw/master/install.bash | bash
. ~/.bashrc
```
Please note that the install script modifies your `.bashrc`, which means that you need to use `. ~/.bashrc` in order to use BashFOX.

### Manually
```bash
git clone https://github.com/romw314/bashfox
cd bashfox
chmod 755 bashfox.bash
mkdir -p ~/.local/bin
cp bashfox.bash ~/.local/bin/bashfox
```
Please ensure that `~/.local/bin` is in your path after manual installation.

## Uninstallation
If you installed BashFOX with the install script uninstall it with:
```bash
curl -L https://github.com/romw314/bashfox/raw/master/uninstall.bash | bash
```

## Usage
Write your code to `main.bash`, for example:
```bash
debug  "This shows only if you use DEBUG=1"
notice "EXAMPLE notice"
info   "hello"
warn   "There is no useful code in this script"
if [ "$1" == "hello" ]; then
	fatal "The first argument shouldn't be 'hello'"
fi
error "Something went wrong"
```

Write your configuration to `bashfox.conf`, for example:
```
OUTPUT=outscript.bash # The output bash script
SOURCE=.              # The directory where main.bash is, for example, src
```

Compile it by running `bashfox`.

Run the compiled script. Example:
```
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
```
