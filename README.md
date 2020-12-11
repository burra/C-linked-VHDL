# Example how to link C code and VHDL code with GHDL

Create vhdl package and define the functions like in math.vhd. Use those functions in some entity code, like math_tb.vhd. Create a source and header c files, business as usual, example, divide.c, divide.h
pay attention to data types as mentioned in ghdl documentation(a copy at the end of this document)

compile own executables(divide.o):
$ gcc -o divide.o -c divide.c

for multiple executables, in one command:
$ gcc -c *.c

create library archive (.a), it includes all compiled executables the name must start with lib!
$ ar rv libsimLibrary.a *.o /*removed u from ruv*/

you can also add a standard c library such as libm,a (math library)
to locate where is this LIBRARY
locate libm.a => in ubuntu:/usr/lib/x86_64-linux-gnu/libm.a
notice that there are many .so(shared or dynamically linked) libraries there

* to add it:

$ ar rv libsimLibrary.a *.o /usr/lib/x86_64-linux-gnu/libm.a

 (path to libm.a varies between distros arch uses: /usr/lib/libm.a)

* to index the library (speeds up finding symbols)
$ ranlib libsimLibrary.a

If we want to see the contents of our library, we can use the ar option -t.
$ ar -t libholberton.a //libsimLibrary.a

analyze the package with GHDL
$ ghdl -a math.vhd // --std=08 did not work

analyze the entity file with GHDL
$ ghdl -a math_tb.vhd //--std=08 did not work

to use static linking (library will become part of the compiled vhdl file)
$ ghdl -e -Wl,-L. -Wl,-lsimLibrary math_tb

notice -Wl repeated before every linking command
-L. is the path, . since the library is in same directory
-lsimLibrary, notice that we removed 'lib' from the library file name

run it!
$ ghdl -r entity_name //entity_name = math_tb

to use dynamic linking:
$ gcc -shared -o libdivide.so -fPIC divide.c

libm.so is already in the $PATH and will be linked automatically when
running the compiled entity

but for our library, we need to add it to the path!
$ export LD_LIBRARY_PATH=/home/vhdl/vhdltool-atom/vhpi/:$LD_LIBRARY_PATH /*can we give it the path*/

https://medium.com/@meghamohan/all-about-static-libraries-in-c-cea57990c495

static vs dynamic linking:
http://www.cs-fundamentals.com/tech-interview/c/difference-between-static-and-dynamic-linking.php
