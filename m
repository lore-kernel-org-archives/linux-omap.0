From: <aravind.boinpally@wipro.com>
Subject: Reg X-loader  compilation Problem
Date: Tue, 25 Sep 2007 13:55:24 +0530
Message-ID: <19B9278CA74D6D4B889A1687EE6392020EA47F@BLR-SGM-MSG01.wipro.com>
References: <19B9278CA74D6D4B889A1687EE639202079559@BLR-SGM-MSG01.wipro.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901FD3352@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901FD3352@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, kyungmin78@gmail.com
List-Id: linux-omap@vger.kernel.org

=20
Hi...

1)I removed the option -mapcs-32 in cpu/arm1136/config.mk file.But after
compiling I am getting the error as follows....But one thing I observed
is when I compiled the code with gcc 3.2.2(arm-linux) tool chain it is
compiled sucessfully but after porting binary file into ONENAND Flash, I
am not able to obeserve any console out put on Hyper-termianl=20


-bash-3.1# make ARCh=3Darm
CROSS_COMPILE=3D/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -Wa,-gstabs
-D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8
-D__KERNEL__ -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include
-fno-builtin -ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -c -o
cpu/arm1136/start.o /home/aravindb/x-load/cpu/arm1136/start.S
/home/aravindb/x-load/cpu/arm1136/start.S:0: warning: target CPU does
not support interworking
make -C `dirname board/omap2430sdp/libomap2430sdp.a`
make[1]: Entering directory `/home/aravindb/x-load/board/omap2430sdp'
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -M -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 platform.S
omap2430sdp.c > .depend
platform.S:0: warning: target CPU does not support interworking
omap2430sdp.c:0: warning: target CPU does not support interworking
make[1]: Leaving directory `/home/aravindb/x-load/board/omap2430sdp'
make[1]: Entering directory `/home/aravindb/x-load/board/omap2430sdp'
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o omap2430sdp.o omap2430sdp.c
omap2430sdp.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -Wa,-gstabs
-D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8
-D__KERNEL__ -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include
-fno-builtin -ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -c -o platform.o
/home/aravindb/x-load/board/omap2430sdp/platform.S
/home/aravindb/x-load/board/omap2430sdp/platform.S:0: warning: target
CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ar crv
libomap2430sdp.a omap2430sdp.o platform.o
a - omap2430sdp.o
a - platform.o
make[1]: Leaving directory `/home/aravindb/x-load/board/omap2430sdp'
make -C `dirname cpu/arm1136/libarm1136.a`
make[1]: Entering directory `/home/aravindb/x-load/cpu/arm1136'
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -M -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes start.S cpu.c > .depend
start.S:0: warning: target CPU does not support interworking
cpu.c:0: warning: target CPU does not support interworking
make[1]: Leaving directory `/home/aravindb/x-load/cpu/arm1136'
make[1]: Entering directory `/home/aravindb/x-load/cpu/arm1136'
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o cpu.o cpu.c
cpu.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ar crv libarm1136.a
cpu.o
a - cpu.o
make[1]: Leaving directory `/home/aravindb/x-load/cpu/arm1136'
make -C `dirname lib/libarm.a`
make[1]: Entering directory `/home/aravindb/x-load/lib'
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -M -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes _udivsi3.S _umodsi3.S board.c ecc.c printf.c >
.depend
_udivsi3.S:0: warning: target CPU does not support interworking
_umodsi3.S:0: warning: target CPU does not support interworking
board.c:0: warning: target CPU does not support interworking
ecc.c:0: warning: target CPU does not support interworking
printf.c:0: warning: target CPU does not support interworking
make[1]: Leaving directory `/home/aravindb/x-load/lib'
make[1]: Entering directory `/home/aravindb/x-load/lib'
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -Wa,-gstabs
-D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8
-D__KERNEL__ -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include
-fno-builtin -ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -c -o _udivsi3.o
/home/aravindb/x-load/lib/_udivsi3.S
/home/aravindb/x-load/lib/_udivsi3.S:0: warning: target CPU does not
support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -Wa,-gstabs
-D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8
-D__KERNEL__ -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include
-fno-builtin -ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -c -o _umodsi3.o
/home/aravindb/x-load/lib/_umodsi3.S
/home/aravindb/x-load/lib/_umodsi3.S:0: warning: target CPU does not
support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o board.o board.c
board.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o ecc.o ecc.c
ecc.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o printf.o printf.c
printf.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ar crv libarm.a
_udivsi3.o _umodsi3.o board.o ecc.o printf.o
a - _udivsi3.o
a - _umodsi3.o
a - board.o
a - ecc.o
a - printf.o
make[1]: Leaving directory `/home/aravindb/x-load/lib'
make -C `dirname drivers/libdrivers.a`
make[1]: Entering directory `/home/aravindb/x-load/drivers'
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -M -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes serial.c ns16550.c k9f5616.c k9k1216.c onenand.c >
.depend
serial.c:0: warning: target CPU does not support interworking
ns16550.c:0: warning: target CPU does not support interworking
k9f5616.c:0: warning: target CPU does not support interworking
k9k1216.c:0: warning: target CPU does not support interworking
onenand.c:0: warning: target CPU does not support interworking
make[1]: Leaving directory `/home/aravindb/x-load/drivers'
make[1]: Entering directory `/home/aravindb/x-load/drivers'
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o serial.o serial.c
serial.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o ns16550.o ns16550.c
ns16550.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o k9f5616.o k9f5616.c
k9f5616.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o k9k1216.o k9k1216.c
k9k1216.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
-Wstrict-prototypes -c -o onenand.o onenand.c
onenand.c:1: warning: target CPU does not support interworking
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ar crv libdrivers.a
serial.o ns16550.o k9f5616.o k9k1216.o onenand.o
a - serial.o
a - ns16550.o
a - k9f5616.o
a - k9k1216.o
a - onenand.o
make[1]: Leaving directory `/home/aravindb/x-load/drivers'
UNDEF_SYM=3D`/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-objdump=

-x board/omap2430sdp/libomap2430sdp.a cpu/arm1136/libarm1136.a
lib/libarm.a drivers/libdrivers.a |sed  -n -e
's/.*\(__u_boot_cmd_.*\)/-u\1/p'|sort|uniq`;\
                /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ld
-Bstatic -T /home/aravindb/x-load/board/omap2430sdp/x-load.lds -Ttext
0x80e80000  $UNDEF_SYM cpu/arm1136/start.o \
                        --start-group board/omap2430sdp/libomap2430sdp.a
cpu/arm1136/libarm1136.a lib/libarm.a drivers/libdrivers.a -L
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1
-lgcc --end-group \
                        -Map x-load.map -o x-load
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/li
bgcc.a(_dvmd_lnx.o): In function `__div0':
/scratch/paul/arm/src/gcc-2006q3/gcc/config/arm/lib1funcs.asm:(.text+0x8
): undefined reference to `raise'
make: *** [x-load] Error 1


2) I also tried with "-mabi=3Dapcs-gnu "option but with this option also =
I
am not able to compile the code .I am getting follwing output after
compilation.


/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ld: ERROR: Source
object
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/li
bgcc.a(_dvmd_lnx.o) has EABI version 4, but target x-load has EABI
version 0
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ld: failed to merge
target specific data of file
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/li
bgcc.a(_dvmd_lnx.o)
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/li
bgcc.a(_dvmd_lnx.o): In function `__div0':
/scratch/paul/arm/src/gcc-2006q3/gcc/config/arm/lib1funcs.asm:(.text+0x8
): undefined reference to `raise'
make: *** [x-load] Error 1


Can u please tell me what went wrong in compilation of x-loader module.

Thanking You.



-----Original Message-----
From: Woodruff, Richard [mailto:r-woodruff2@ti.com]=20
Sent: Sunday, September 23, 2007 6:41 AM
To: Aravind Kumar boinpally (WT01 - MCE-Mobile & Consumer Electronics);
linux-omap-open-source@linux.omap.com
Subject: RE: Reg X-loader compilation Problem

Remove that option from cpu/arm1136/config.mk its removed in that
version of gcc.  Its not needed for that.

Regards,
Richard W.

> -----Original Message-----
> From: =
linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.com
> =
[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.c
> om] On Behalf Of aravind.boinpally@wipro.com
> Sent: Friday, September 21, 2007 6:45 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Reg X-loader compilation Problem
>=20
> Hi all,
>=20
> I am facing compilation problem with X-loader.
>=20
> I have downloaded the X-loader from Linux.omap.com
""x-load_11SEP.tgz"".
>=20
> Then I have untarred it and changed the ""include/configs/om  file for

> ONENAND support.
>=20
> After this I tried to compile this using cross tool chain=20
> "arm-none-Linux-gnueabi-" ,but after doing this i am getting
>=20
> error like
>=20
> ""error: unrecognized command line option "-mapcs-32""".
>=20
> can some one suggest me what could be the problem.
>=20
> is it problem with tool chain.???
>=20
> I compiled this code using make3.80 tool.
>=20
> but when i compiled with make 3.81 also same problem ..
>=20
> and also version of gcc is 4.1.1
>=20
> Please give me some inputs
> thanking you.
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
