all: lib_bozorth3 bozorth3

lib_bozorth3:
	# gcc -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__ -fPIC -I/home/jsteve22/rebuilding_bozorth/bozorth3/include -I/home/jsteve22/rebuilding_bozorth/exports/include -c -o obj/lib_bozorth3.o src/lib_bozorth3.c
	g++ -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__ -fpermissive -fPIC -I./include -c -o obj/lib_bozorth3.o src/lib_bozorth3.cpp
	g++ -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__ -fpermissive -fPIC -I./include -c -o obj/lib_bz_alloc.o src/lib_bz_alloc.cpp
	g++ -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__ -fpermissive -fPIC -I./include -c -o obj/lib_bz_drvrs.o src/lib_bz_drvrs.cpp
	g++ -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__ -fpermissive -fPIC -I./include -c -o obj/lib_bz_gbls.o src/lib_bz_gbls.cpp
	g++ -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__ -fpermissive -fPIC -I./include -c -o obj/lib_bz_io.o src/lib_bz_io.cpp
	g++ -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__ -fpermissive -fPIC -I./include -c -o obj/lib_bz_sort.o src/lib_bz_sort.cpp
	ar r obj/libbozorth3.a obj/lib_bozorth3.o obj/lib_bz_alloc.o obj/lib_bz_drvrs.o obj/lib_bz_gbls.o obj/lib_bz_io.o obj/lib_bz_sort.o 

bozorth3:
	g++ -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__  -fpermissive -fPIC -I./include -c -o obj/bozorth3.o src/bozorth3.cpp
	g++ -O2 -w -ansi -D_POSIX_SOURCE -D__NBISLE__  -fpermissive -fPIC -I./include -c -o obj/usage.o src/usage.cpp
	g++ -fPIC obj/bozorth3.o obj/usage.o obj/libbozorth3.a -lm -o bin/bozorth3

clean:
	rm -rf obj/*.o obj/*.a
