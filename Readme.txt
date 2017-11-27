apt-get install ddd
ddd --debugger arm-none-eabi-gdb
===================================

Method #1
install arm-none-eabi-gcc and arm-none-eabi-gdb tools
write small asm program, for ex
=====================
.text
.global _start
_start:
	mov r0, #1
	b _start
=====================

$ arm-none-eabi-as empty_1.s -g -o empty.o
$ arm-none-eabi-ld empty.o -o empty

to run binary
$ qemu-arm -singlestep -g 1234 empty

it waits at first instruction

run arm-none-eabi-gdb tool from other session and supply below cmds to gdb
$ arm-none-eabi-gdb
GNU gdb (GDB) 7.9.1
Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later > <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=x86_64-unknown-linux-gnu --target=arm-none-eabi".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word".
(gdb) file empty
Reading symbols from empty...done.
(gdb) target remote localhost:1234
Remote debugging using localhost:1234
_start () at empty.s:4
4	    mov r0, #1
(gdb)

(gdb) quit

We first load the debugging symbols using the file command, then we connect to our remote target.

Crash course on GDB The TUI provided by GDB is good enough to debug simple (and complex) programs: press Ctrl+x and then A to active it: above your usual GDB command prompt, you will see the source being debugged. Enter this command to have a good view of the registers.

(gdb) layout regs 
-------------------------------------------------------------

