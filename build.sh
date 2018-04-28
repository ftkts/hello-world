#!/bin/sh
set -eu
as -o gen.o gen.s #-a=gen.lst
ld -o gen gen.o
./gen 3>hello
chmod +x hello
./hello
