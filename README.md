
# Build Kit

  This repository regroup script and config that I use every day to develop.


### Git hooks

  - Ensure that your file doesn't contain blank end line and use Unix EOL.
    (carefull about markdown files)


### Makefile

  __INCOMPLETE__

  This makefile require the binaries: ```binutils pkg-config check valgrind 
  gcov cppcheck rats and sonar-runner```.  Alls are however not mandatory to 
  compile binaries.

  This makefile doesn't allow to specify different flags for two deliveries of 
  the same mode.

  All the rules can be launch from the same script, this is not a recursive
  make script.


>  __```make everything```__
>
> Generate all debug binaries
> Generate all release binaries
> Generate all test binaries
> Launch all unit-tests
> Build HTML coverage report
> Generate XML reports form valgrind
> Generate XML reports form gcov
> Generate XML reports form cppcheck 
> Generate XML reports form rats
> Build the package name-build-v0.0.tar.gz with release binaries
> Build the package name-devel-v0.0.tar.gz with debug binary and headers
> Build the package name-reports-v0.0.tar.gz with all quality report
> Will run sonar check script


### Copyright

  All this scripts are from my own making, even if I get my inspiration from 
  various source on internet or somewhere else.
  There is no copyright on this repository. Feel free to copy, modify and share
  this work. Quote your source is appreciate, but not mandatory as you will 
  probably just take small part of this repository.

>  This program is distributed in the hope that it will be useful,
>  but WITHOUT ANY WARRANTY; without even the implied warranty of
>  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.



