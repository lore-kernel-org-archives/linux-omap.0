From: "mohammed shareef" <mdshareef@gmail.com>
Subject: compiling X11 fails at makekeys
Date: Tue, 10 Jun 2008 12:24:40 +0530
Message-ID: <a1d91fa0806092354n11e686d4ocaf1c73b85ab40d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-newbie-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-newbie-owner@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>, linux-newbie@vger.kernel.org, linux-x11@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Dear All,

I am trying to compile X for omap5912-osk. i am following the steps given in:

http://oskfordummies.hp.infoseek.co.jp/howto/x-window.html

all the xlib- libraries are compiling till i reach the X11 library. i
am struck at this point for a month now. some one please help me out.

am attaching the build log (error at the last line):

====================
== Building X11  ==
====================
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal
autoreconf: configure.ac: tracing
autoreconf: running: libtoolize --copy
libtoolize: `config.guess' exists: use `--force' to overwrite
libtoolize: `config.sub' exists: use `--force' to overwrite
libtoolize: `ltmain.sh' exists: use `--force' to overwrite
autoreconf: running: /usr/bin/autoconf
autoreconf: running: /usr/bin/autoheader
autoreconf: running: automake --add-missing --copy --no-force
nls/C/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/C/Makefile.am:1: (probably a GNU make extension)
nls/armscii-8/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/armscii-8/Makefile.am:1: (probably a GNU make extension)
nls/en_US.UTF-8/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/en_US.UTF-8/Makefile.am:1: (probably a GNU make extension)
nls/georgian-academy/Makefile.am:1: shell basename `pwd`: non-POSIX
variable name
nls/georgian-academy/Makefile.am:1: (probably a GNU make extension)
nls/georgian-ps/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/georgian-ps/Makefile.am:1: (probably a GNU make extension)
nls/ibm-cp1133/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ibm-cp1133/Makefile.am:1: (probably a GNU make extension)
nls/iscii-dev/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iscii-dev/Makefile.am:1: (probably a GNU make extension)
nls/isiri-3342/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/isiri-3342/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-1/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-1/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-10/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-10/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-11/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-11/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-13/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-13/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-14/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-14/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-15/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-15/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-2/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-2/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-3/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-3/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-4/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-4/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-5/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-5/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-6/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-6/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-7/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-7/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-8/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-8/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-9/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-9/Makefile.am:1: (probably a GNU make extension)
nls/iso8859-9e/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/iso8859-9e/Makefile.am:1: (probably a GNU make extension)
nls/ja.JIS/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ja.JIS/Makefile.am:1: (probably a GNU make extension)
nls/ja.S90/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ja.S90/Makefile.am:1: (probably a GNU make extension)
nls/ja.SJIS/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ja.SJIS/Makefile.am:1: (probably a GNU make extension)
nls/ja.U90/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ja.U90/Makefile.am:1: (probably a GNU make extension)
nls/ja/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ja/Makefile.am:1: (probably a GNU make extension)
nls/ja_JP.UTF-8/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ja_JP.UTF-8/Makefile.am:1: (probably a GNU make extension)
nls/ko/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ko/Makefile.am:1: (probably a GNU make extension)
nls/ko_KR.UTF-8/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/ko_KR.UTF-8/Makefile.am:1: (probably a GNU make extension)
nls/koi8-c/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/koi8-c/Makefile.am:1: (probably a GNU make extension)
nls/koi8-r/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/koi8-r/Makefile.am:1: (probably a GNU make extension)
nls/koi8-u/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/koi8-u/Makefile.am:1: (probably a GNU make extension)
nls/microsoft-cp1251/Makefile.am:1: shell basename `pwd`: non-POSIX
variable name
nls/microsoft-cp1251/Makefile.am:1: (probably a GNU make extension)
nls/microsoft-cp1255/Makefile.am:1: shell basename `pwd`: non-POSIX
variable name
nls/microsoft-cp1255/Makefile.am:1: (probably a GNU make extension)
nls/microsoft-cp1256/Makefile.am:1: shell basename `pwd`: non-POSIX
variable name
nls/microsoft-cp1256/Makefile.am:1: (probably a GNU make extension)
nls/mulelao-1/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/mulelao-1/Makefile.am:1: (probably a GNU make extension)
nls/nokhchi-1/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/nokhchi-1/Makefile.am:1: (probably a GNU make extension)
nls/tatar-cyr/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/tatar-cyr/Makefile.am:1: (probably a GNU make extension)
nls/th_TH.UTF-8/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/th_TH.UTF-8/Makefile.am:1: (probably a GNU make extension)
nls/th_TH/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/th_TH/Makefile.am:1: (probably a GNU make extension)
nls/tscii-0/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/tscii-0/Makefile.am:1: (probably a GNU make extension)
nls/vi_VN.tcvn/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/vi_VN.tcvn/Makefile.am:1: (probably a GNU make extension)
nls/vi_VN.viscii/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/vi_VN.viscii/Makefile.am:1: (probably a GNU make extension)
nls/zh_CN.UTF-8/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/zh_CN.UTF-8/Makefile.am:1: (probably a GNU make extension)
nls/zh_CN.gbk/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/zh_CN.gbk/Makefile.am:1: (probably a GNU make extension)
nls/zh_CN/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/zh_CN/Makefile.am:1: (probably a GNU make extension)
nls/zh_HK.big5/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/zh_HK.big5/Makefile.am:1: (probably a GNU make extension)
nls/zh_HK.big5hkscs/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/zh_HK.big5hkscs/Makefile.am:1: (probably a GNU make extension)
nls/zh_TW.UTF-8/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/zh_TW.UTF-8/Makefile.am:1: (probably a GNU make extension)
nls/zh_TW.big5/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/zh_TW.big5/Makefile.am:1: (probably a GNU make extension)
nls/zh_TW/Makefile.am:1: shell basename `pwd`: non-POSIX variable name
nls/zh_TW/Makefile.am:1: (probably a GNU make extension)
src/Makefile.am:547: patsubst %.c,%.ii,$(libX11_la_SOURCES: non-POSIX
variable name
src/Makefile.am:547: (probably a GNU make extension)
automake: compiling `makekeys.c' with per-target flags requires
`AM_PROG_CC_C_O' in `configure.ac'
src/util/Makefile.am:1:   while processing program `makekeys'
autoreconf: Leaving directory `.'
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for arm-linux-gnu-strip... no
checking for strip... strip
checking whether to enable maintainer-specific portions of Makefiles... yes
checking build system type... i686-pc-linux-gnu
checking host system type... arm-unknown-linux-gnu
checking for style of include used by make... GNU
checking for arm-linux-gnu-gcc... arm-linux-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gcc accepts -g... yes
checking for arm-linux-gcc option to accept ISO C89... none needed
checking dependency style of arm-linux-gcc... gcc3
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for ld used by arm-linux-gcc... /usr/local/arm/3.4.1/arm-linux/bin/ld
checking if the linker (/usr/local/arm/3.4.1/arm-linux/bin/ld) is GNU ld... yes
checking for /usr/local/arm/3.4.1/arm-linux/bin/ld option to reload
object files... -r
checking for BSD-compatible nm... nm
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... arm-linux-gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking for arm-linux-gnu-g++... no
checking for arm-linux-gnu-c++... no
checking for arm-linux-gnu-gpp... no
checking for arm-linux-gnu-aCC... no
checking for arm-linux-gnu-CC... no
checking for arm-linux-gnu-cxx... no
checking for arm-linux-gnu-cc++... no
checking for arm-linux-gnu-cl.exe... no
checking for arm-linux-gnu-FCC... no
checking for arm-linux-gnu-KCC... no
checking for arm-linux-gnu-RCC... no
checking for arm-linux-gnu-xlC_r... no
checking for arm-linux-gnu-xlC... no
checking for g++... g++
configure: WARNING: In the future, Autoconf will not detect cross-tools
whose name does not start with the host triplet.  If you think this
configuration is useful to you, please write to autoconf@gnu.org.
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking dependency style of g++... gcc3
checking how to run the C++ preprocessor... g++ -E
checking for arm-linux-gnu-g77... no
checking for arm-linux-gnu-xlf... no
checking for arm-linux-gnu-f77... no
checking for arm-linux-gnu-frt... no
checking for arm-linux-gnu-pgf77... no
checking for arm-linux-gnu-cf77... no
checking for arm-linux-gnu-fort77... no
checking for arm-linux-gnu-fl32... no
checking for arm-linux-gnu-af77... no
checking for arm-linux-gnu-xlf90... no
checking for arm-linux-gnu-f90... no
checking for arm-linux-gnu-pgf90... no
checking for arm-linux-gnu-pghpf... no
checking for arm-linux-gnu-epcf90... no
checking for arm-linux-gnu-gfortran... no
checking for arm-linux-gnu-g95... no
checking for arm-linux-gnu-xlf95... no
checking for arm-linux-gnu-f95... no
checking for arm-linux-gnu-fort... no
checking for arm-linux-gnu-ifort... no
checking for arm-linux-gnu-ifc... no
checking for arm-linux-gnu-efc... no
checking for arm-linux-gnu-pgf95... no
checking for arm-linux-gnu-lf95... no
checking for arm-linux-gnu-ftn... no
checking for g77... no
checking for xlf... no
checking for f77... no
checking for frt... no
checking for pgf77... no
checking for cf77... no
checking for fort77... no
checking for fl32... no
checking for af77... no
checking for xlf90... no
checking for f90... no
checking for pgf90... no
checking for pghpf... no
checking for epcf90... no
checking for gfortran... gfortran
checking whether we are using the GNU Fortran 77 compiler... yes
checking whether gfortran accepts -g... yes
checking the maximum length of command line arguments... 32768
checking command to parse nm output from arm-linux-gcc object... ok
checking for objdir... .libs
checking for arm-linux-gnu-ar... no
checking for ar... ar
checking for arm-linux-gnu-ranlib... no
checking for ranlib... ranlib
checking for arm-linux-gnu-strip... strip
checking if arm-linux-gcc supports -fno-rtti -fno-exceptions... no
checking for arm-linux-gcc option to produce PIC... -fPIC
checking if arm-linux-gcc PIC flag -fPIC works... yes
checking if arm-linux-gcc static flag -static works... yes
checking if arm-linux-gcc supports -c -o file.o... yes
checking whether the arm-linux-gcc linker
(/usr/local/arm/3.4.1/arm-linux/bin/ld) supports shared libraries...
yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
configure: creating libtool
appending configuration tag "CXX" to libtool
checking for ld used by g++... /usr/local/arm/3.4.1/arm-linux/bin/ld
checking if the linker (/usr/local/arm/3.4.1/arm-linux/bin/ld) is GNU ld... yes
checking whether the g++ linker
(/usr/local/arm/3.4.1/arm-linux/bin/ld) supports shared libraries...
yes
checking for g++ option to produce PIC... -fPIC
checking if g++ PIC flag -fPIC works... yes
checking if g++ static flag -static works... yes
checking if g++ supports -c -o file.o... yes
checking whether the g++ linker
(/usr/local/arm/3.4.1/arm-linux/bin/ld) supports shared libraries...
yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
appending configuration tag "F77" to libtool
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for gfortran option to produce PIC... -fPIC
checking if gfortran PIC flag -fPIC works... yes
checking if gfortran static flag -static works... yes
checking if gfortran supports -c -o file.o... yes
checking whether the gfortran linker
(/usr/local/arm/3.4.1/arm-linux/bin/ld) supports shared libraries...
yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking for arm-linux-gnu-gcc... (cached) arm-linux-gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether arm-linux-gcc accepts -g... (cached) yes
checking for arm-linux-gcc option to accept ISO C89... (cached) none needed
checking dependency style of arm-linux-gcc... (cached) gcc3
checking whether to use XCB... (cached) no
checking for arm-linux-gnu-pkg-config... no
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for XPROTO... yes
checking for X11... yes
checking for XDMCP... yes
checking for library containing dlopen... -ldl
checking for dlfcn.h... (cached) yes
checking for ANSI C header files... (cached) yes
checking for strtol... yes
checking for XdmcpWrap in -lXdmcp... yes
checking for poll... yes
checking keysymdef.h... /usr/include/X11/keysymdef.h
configure: creating ./config.status
config.status: creating Makefile
config.status: creating include/Makefile
config.status: creating include/X11/Xlibint.h
config.status: creating man/Makefile
config.status: creating src/Makefile
config.status: creating src/util/Makefile
config.status: creating nls/Makefile
config.status: creating nls/C/Makefile
config.status: creating nls/armscii-8/Makefile
config.status: creating nls/en_US.UTF-8/Makefile
config.status: creating nls/georgian-academy/Makefile
config.status: creating nls/georgian-ps/Makefile
config.status: creating nls/ibm-cp1133/Makefile
config.status: creating nls/iscii-dev/Makefile
config.status: creating nls/isiri-3342/Makefile
config.status: creating nls/iso8859-1/Makefile
config.status: creating nls/iso8859-10/Makefile
config.status: creating nls/iso8859-11/Makefile
config.status: creating nls/iso8859-13/Makefile
config.status: creating nls/iso8859-14/Makefile
config.status: creating nls/iso8859-15/Makefile
config.status: creating nls/iso8859-2/Makefile
config.status: creating nls/iso8859-3/Makefile
config.status: creating nls/iso8859-4/Makefile
config.status: creating nls/iso8859-5/Makefile
config.status: creating nls/iso8859-6/Makefile
config.status: creating nls/iso8859-7/Makefile
config.status: creating nls/iso8859-8/Makefile
config.status: creating nls/iso8859-9/Makefile
config.status: creating nls/iso8859-9e/Makefile
config.status: creating nls/ja/Makefile
config.status: creating nls/ja.JIS/Makefile
config.status: creating nls/ja.S90/Makefile
config.status: creating nls/ja.SJIS/Makefile
config.status: creating nls/ja.U90/Makefile
config.status: creating nls/ja_JP.UTF-8/Makefile
config.status: creating nls/ko/Makefile
config.status: creating nls/ko_KR.UTF-8/Makefile
config.status: creating nls/koi8-c/Makefile
config.status: creating nls/koi8-r/Makefile
config.status: creating nls/koi8-u/Makefile
config.status: creating nls/microsoft-cp1251/Makefile
config.status: creating nls/microsoft-cp1255/Makefile
config.status: creating nls/microsoft-cp1256/Makefile
config.status: creating nls/mulelao-1/Makefile
config.status: creating nls/nokhchi-1/Makefile
config.status: creating nls/tatar-cyr/Makefile
config.status: creating nls/th_TH/Makefile
config.status: creating nls/th_TH.UTF-8/Makefile
config.status: creating nls/tscii-0/Makefile
config.status: creating nls/vi_VN.tcvn/Makefile
config.status: creating nls/vi_VN.viscii/Makefile
config.status: creating nls/zh_CN/Makefile
config.status: creating nls/zh_CN.UTF-8/Makefile
config.status: creating nls/zh_CN.gbk/Makefile
config.status: creating nls/zh_HK.big5/Makefile
config.status: creating nls/zh_HK.big5hkscs/Makefile
config.status: creating nls/zh_TW/Makefile
config.status: creating nls/zh_TW.UTF-8/Makefile
config.status: creating nls/zh_TW.big5/Makefile
config.status: creating x11.pc
config.status: creating src/config.h
config.status: src/config.h is unchanged
config.status: executing depfiles commands
Making install in include
make[1]: Entering directory `/root/omap5912/xwin_snapshot/xlibs/X11/include'
make[2]: Entering directory `/root/omap5912/xwin_snapshot/xlibs/X11/include'
make[2]: Nothing to be done for `install-exec-am'.
test -z "/root/omap5912/xwin_snapshot/build/include/X11" || /bin/mkdir
-p "/root/omap5912/xwin_snapshot/build/include/X11"
 /usr/bin/install -c -m 644 'X11/XKBlib.h'
'/root/omap5912/xwin_snapshot/build/include/X11/XKBlib.h'
 /usr/bin/install -c -m 644 'X11/Xcms.h'
'/root/omap5912/xwin_snapshot/build/include/X11/Xcms.h'
 /usr/bin/install -c -m 644 'X11/Xlib.h'
'/root/omap5912/xwin_snapshot/build/include/X11/Xlib.h'
 /usr/bin/install -c -m 644 'X11/Xlibint.h'
'/root/omap5912/xwin_snapshot/build/include/X11/Xlibint.h'
 /usr/bin/install -c -m 644 'X11/Xlocale.h'
'/root/omap5912/xwin_snapshot/build/include/X11/Xlocale.h'
 /usr/bin/install -c -m 644 'X11/Xresource.h'
'/root/omap5912/xwin_snapshot/build/include/X11/Xresource.h'
 /usr/bin/install -c -m 644 'X11/Xutil.h'
'/root/omap5912/xwin_snapshot/build/include/X11/Xutil.h'
 /usr/bin/install -c -m 644 'X11/cursorfont.h'
'/root/omap5912/xwin_snapshot/build/include/X11/cursorfont.h'
 /usr/bin/install -c -m 644 'X11/region.h'
'/root/omap5912/xwin_snapshot/build/include/X11/region.h'
make[2]: Leaving directory `/root/omap5912/xwin_snapshot/xlibs/X11/include'
make[1]: Leaving directory `/root/omap5912/xwin_snapshot/xlibs/X11/include'
Making install in src
make[1]: Entering directory `/root/omap5912/xwin_snapshot/xlibs/X11/src'
cd util; make
make[2]: Entering directory `/root/omap5912/xwin_snapshot/xlibs/X11/src/util'
gcc -DHAVE_CONFIG_H -I. -I../../src    -Wall -Wpointer-arith
-Wstrict-prototypes        -Wmissing-prototypes -Wmissing-declarations
    -Wnested-externs -fno-strict-aliasing -D_BSD_SOURCE
-D_XOPEN_SOURCE=500   -g -O2 -MT makekeys-makekeys.o -MD -MP -MF
.deps/makekeys-makekeys.Tpo -c -o makekeys-makekeys.o `test -f
'makekeys.c' || echo './'`makekeys.c
mv -f .deps/makekeys-makekeys.Tpo .deps/makekeys-makekeys.Po
/bin/sh ../../libtool --tag=CC   --mode=link gcc -Wall -Wpointer-arith
-Wstrict-prototypes      -Wmissing-prototypes -Wmissing-declarations
  -Wnested-externs -fno-strict-aliasing -D_BSD_SOURCE
-D_XOPEN_SOURCE=500   -g -O2  -L/root/omap5912/xwin_snapshot/build/lib
 -o makekeys makekeys-makekeys.o  -ldl
gcc -Wall -Wpointer-arith -Wstrict-prototypes -Wmissing-prototypes
-Wmissing-declarations -Wnested-externs -fno-strict-aliasing
-D_BSD_SOURCE -D_XOPEN_SOURCE=500 -g -O2 -o makekeys
makekeys-makekeys.o  -L/root/omap5912/xwin_snapshot/build/lib -ldl
make[2]: Leaving directory `/root/omap5912/xwin_snapshot/xlibs/X11/src/util'
../src/util/makekeys < /usr/include/X11/keysymdef.h > ks_tables_h
/bin/sh: line 1: 10412 Floating point exception../src/util/makekeys <
/usr/include/X11/keysymdef.h > ks_tables_h
make[1]: *** [ks_tables.h] Error 136
make[1]: Leaving directory `/root/omap5912/xwin_snapshot/xlibs/X11/src'
make: *** [install-recursive] Error 1
[root@localhost xwin_snapshot]#

could someone please help me.

Thank you,
Shareef
--
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
