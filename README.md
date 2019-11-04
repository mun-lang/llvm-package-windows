# LLVM packages for Windows

The official LLVM binaries only contain a small number of binaries and required files to be able to
compiled Mun. This repo contains the scripts required to compile a binary package that can be used
to compile Mun on windows. We compile LLVM as a separate step because it takes a very long time to
compile and we want quick turnarounds on our tests. Other platforms do contain fully featured LLVM
binaries so we can use those there.

## Dependencies

- A version of Visual Studio 2017 and Visual Studio 2019 must be installed
- cmake
- 7z

The build script uses [Scoop](https://scoop.sh/) to install some required dependencies. If you
already have these dependencies scoop will not overwrite them.

## Build

To build the binary package of LLVM run:

```powershell
$ .\build.ps1
```

The script will build and package LLVM.
