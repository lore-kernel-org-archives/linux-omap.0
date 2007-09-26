From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Reg X-loader  compilation Problem
Date: Wed, 26 Sep 2007 12:23:03 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290208C935@dlee13.ent.ti.com>
References: <19B9278CA74D6D4B889A1687EE6392020EA72D@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C80061.E5AACF3A"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <19B9278CA74D6D4B889A1687EE6392020EA72D@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: aravind.boinpally@wipro.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C80061.E5AACF3A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

It does work for me using the latest codesourery compiler and the =
current code.  I'm pretty sure I tried that compiler also.  Last =
December I did tweak that code structure to use newer compilers.  Others =
have also made some changes since then.  It might be you have an old =
version.

My build log attached.  You can likely look inside of this and fix local =
issues.  I don't recall them being so much.  And or check the website to =
see if there is a newer version about.

BTW, the proper build procedure is like u-boot.

	Make omap2430sdp_config
	Make.

Regards,
Richard W.

> Hi...
>=20
> 1)I removed the option -mapcs-32 in cpu/arm1136/config.mk file.But =
after
> compiling I am getting the error as follows....But one thing I =
observed
> is when I compiled the code with gcc 3.2.2(arm-linux) tool chain it is
> compiled sucessfully but after porting binary file into ONENAND Flash, =
I
> am not able to obeserve any console out put on Hyper-termianl
>=20
>=20
> -bash-3.1# make ARCh=3Darm
> CROSS_COMPILE=3D/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -Wa,-gstabs
> -D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8
> -D__KERNEL__ -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include
> -fno-builtin -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -c -o
> cpu/arm1136/start.o /home/aravindb/x-load/cpu/arm1136/start.S
> /home/aravindb/x-load/cpu/arm1136/start.S:0: warning: target CPU does
> not support interworking make -C `dirname
> board/omap2430sdp/libomap2430sdp.a`
> make[1]: Entering directory `/home/aravindb/x-load/board/omap2430sdp'
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -M -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 platform.S
> omap2430sdp.c > .depend
> platform.S:0: warning: target CPU does not support interworking
> omap2430sdp.c:0: warning: target CPU does not support interworking
> make[1]: Leaving directory `/home/aravindb/x-load/board/omap2430sdp'
> make[1]: Entering directory `/home/aravindb/x-load/board/omap2430sdp'
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o omap2430sdp.o omap2430sdp.c
> omap2430sdp.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -Wa,-gstabs
> -D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8
> -D__KERNEL__ -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include
> -fno-builtin -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -c -o platform.o
> /home/aravindb/x-load/board/omap2430sdp/platform.S
> /home/aravindb/x-load/board/omap2430sdp/platform.S:0: warning: target
> CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ar crv
> libomap2430sdp.a omap2430sdp.o platform.o a - omap2430sdp.o a -
> platform.o
> make[1]: Leaving directory `/home/aravindb/x-load/board/omap2430sdp'
> make -C `dirname cpu/arm1136/libarm1136.a`
> make[1]: Entering directory `/home/aravindb/x-load/cpu/arm1136'
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -M -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes start.S cpu.c > .depend
> start.S:0: warning: target CPU does not support interworking
> cpu.c:0: warning: target CPU does not support interworking
> make[1]: Leaving directory `/home/aravindb/x-load/cpu/arm1136'
> make[1]: Entering directory `/home/aravindb/x-load/cpu/arm1136'
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o cpu.o cpu.c
> cpu.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ar crv =
libarm1136.a
> cpu.o a - cpu.o
> make[1]: Leaving directory `/home/aravindb/x-load/cpu/arm1136'
> make -C `dirname lib/libarm.a`
> make[1]: Entering directory `/home/aravindb/x-load/lib'
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -M -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes _udivsi3.S _umodsi3.S board.c ecc.c printf.c >
> .depend
> _udivsi3.S:0: warning: target CPU does not support interworking
> _umodsi3.S:0: warning: target CPU does not support interworking
> board.c:0: warning: target CPU does not support interworking
> ecc.c:0: warning: target CPU does not support interworking
> printf.c:0: warning: target CPU does not support interworking
> make[1]: Leaving directory `/home/aravindb/x-load/lib'
> make[1]: Entering directory `/home/aravindb/x-load/lib'
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -Wa,-gstabs
> -D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8
> -D__KERNEL__ -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include
> -fno-builtin -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -c -o _udivsi3.o
> /home/aravindb/x-load/lib/_udivsi3.S
> /home/aravindb/x-load/lib/_udivsi3.S:0: warning: target CPU does not
> support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -Wa,-gstabs
> -D__ASSEMBLY__ -g  -Os   -fno-strict-aliasing  -fno-common -ffixed-r8
> -D__KERNEL__ -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include
> -fno-builtin -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -c -o _umodsi3.o
> /home/aravindb/x-load/lib/_umodsi3.S
> /home/aravindb/x-load/lib/_umodsi3.S:0: warning: target CPU does not
> support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o board.o board.c
> board.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o ecc.o ecc.c
> ecc.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o printf.o printf.c
> printf.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ar crv libarm.a
> _udivsi3.o _umodsi3.o board.o ecc.o printf.o a - _udivsi3.o a -
> _umodsi3.o a - board.o a - ecc.o a - printf.o
> make[1]: Leaving directory `/home/aravindb/x-load/lib'
> make -C `dirname drivers/libdrivers.a`
> make[1]: Entering directory `/home/aravindb/x-load/drivers'
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -M -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes serial.c ns16550.c k9f5616.c k9k1216.c onenand.c >
> .depend
> serial.c:0: warning: target CPU does not support interworking
> ns16550.c:0: warning: target CPU does not support interworking
> k9f5616.c:0: warning: target CPU does not support interworking
> k9k1216.c:0: warning: target CPU does not support interworking
> onenand.c:0: warning: target CPU does not support interworking
> make[1]: Leaving directory `/home/aravindb/x-load/drivers'
> make[1]: Entering directory `/home/aravindb/x-load/drivers'
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o serial.o serial.c
> serial.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o ns16550.o ns16550.c
> ns16550.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o k9f5616.o k9f5616.c
> k9f5616.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o k9k1216.o k9k1216.c
> k9k1216.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-gcc -g  -Os
> -fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
> -DTEXT_BASE=3D0x80e80000 -I/home/aravindb/x-load/include -fno-builtin
> -ffreestanding -nostdinc -isystem
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/in
> clude -pipe  -DCONFIG_ARM -D__ARM__ -march=3Darmv5 -Wall
> -Wstrict-prototypes -c -o onenand.o onenand.c
> onenand.c:1: warning: target CPU does not support interworking
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ar crv =
libdrivers.a
> serial.o ns16550.o k9f5616.o k9k1216.o onenand.o a - serial.o a -
> ns16550.o a - k9f5616.o a - k9k1216.o a - onenand.o
> make[1]: Leaving directory `/home/aravindb/x-load/drivers'
> =
UNDEF_SYM=3D`/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-objdump=

> -x board/omap2430sdp/libomap2430sdp.a cpu/arm1136/libarm1136.a
> lib/libarm.a drivers/libdrivers.a |sed  -n -e
> 's/.*\(__u_boot_cmd_.*\)/-u\1/p'|sort|uniq`;\
>                 =
/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ld
> -Bstatic -T /home/aravindb/x-load/board/omap2430sdp/x-load.lds -Ttext
> 0x80e80000  $UNDEF_SYM cpu/arm1136/start.o \
>                         --start-group =
board/omap2430sdp/libomap2430sdp.a
> cpu/arm1136/libarm1136.a lib/libarm.a drivers/libdrivers.a -L
> /usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1
> -lgcc --end-group \
>                         -Map x-load.map -o x-load
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/li
> bgcc.a(_dvmd_lnx.o): In function `__div0':
> =
/scratch/paul/arm/src/gcc-2006q3/gcc/config/arm/lib1funcs.asm:(.text+0x8
> ): undefined reference to `raise'
> make: *** [x-load] Error 1
>=20
>=20
> 2) I also tried with "-mabi=3Dapcs-gnu "option but with this option =
also I
> am not able to compile the code .I am getting follwing output after
> compilation.
>=20
>=20
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ld: ERROR: Source
> object
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/li
> bgcc.a(_dvmd_lnx.o) has EABI version 4, but target x-load has EABI
> version 0
> /usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-ld: failed to =
merge
> target specific data of file
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/li
> bgcc.a(_dvmd_lnx.o)
> =
/usr/local/arm/arm-2006q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.1.1/li
> bgcc.a(_dvmd_lnx.o): In function `__div0':
> =
/scratch/paul/arm/src/gcc-2006q3/gcc/config/arm/lib1funcs.asm:(.text+0x8
> ): undefined reference to `raise'
> make: *** [x-load] Error 1
>=20
>=20
> Can u please tell me what went wrong in compilation of x-loader =
module.
>=20
> Thanking You.
>=20
>=20
>=20
> -----Original Message-----
> From: Woodruff, Richard [mailto:r-woodruff2@ti.com]
> Sent: Sunday, September 23, 2007 6:41 AM
> To: Aravind Kumar boinpally (WT01 - MCE-Mobile & Consumer =
Electronics);
> linux-omap-open-source@linux.omap.com
> Subject: RE: Reg X-loader compilation Problem
>=20
> Remove that option from cpu/arm1136/config.mk its removed in that
> version of gcc.  Its not needed for that.
>=20
> Regards,
> Richard W.
>=20
> > -----Original Message-----
> > From: =
linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.com
> > =
[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.c
> > om] On Behalf Of aravind.boinpally@wipro.com
> > Sent: Friday, September 21, 2007 6:45 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: Reg X-loader compilation Problem
> >
> > Hi all,
> >
> > I am facing compilation problem with X-loader.
> >
> > I have downloaded the X-loader from Linux.omap.com
> ""x-load_11SEP.tgz"".
> >
> > Then I have untarred it and changed the ""include/configs/om  file =
for
>=20
> > ONENAND support.
> >
> > After this I tried to compile this using cross tool chain
> > "arm-none-Linux-gnueabi-" ,but after doing this i am getting
> >
> > error like
> >
> > ""error: unrecognized command line option "-mapcs-32""".
> >
> > can some one suggest me what could be the problem.
> >
> > is it problem with tool chain.???
> >
> > I compiled this code using make3.80 tool.
> >
> > but when i compiled with make 3.81 also same problem ..
> >
> > and also version of gcc is 4.1.1
> >
> > Please give me some inputs
> > thanking you.
> >
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

------_=_NextPart_001_01C80061.E5AACF3A
Content-Type: text/plain;
	name="buildlog.txt"
Content-Transfer-Encoding: base64
Content-Description: buildlog.txt
Content-Disposition: attachment;
	filename="buildlog.txt"

bWFrZSAtQyBgZGlybmFtZSBib2FyZC9vbWFwMjQzMHNkcC9saWJvbWFwMjQzMHNkcC5hYAptYWtl
WzFdOiBFbnRlcmluZyBkaXJlY3RvcnkgYC9ob21lL2EwMzg0ODY0L3d0YnUvbG9hZGVyL3dha2V1
cC94LWxvYWQvYm9hcmQvb21hcDI0MzBzZHAnCmFybS1ub25lLWxpbnV4LWdudWVhYmktZ2NjIC1n
ICAtT3MgICAtZm5vLXN0cmljdC1hbGlhc2luZyAgLWZuby1jb21tb24gLWZmaXhlZC1yOCAgLURf
X0tFUk5FTF9fIC1EVEVYVF9CQVNFPTB4ODBlODAwMDAgLUkvaG9tZS9hMDM4NDg2NC9sZHIvd2Fr
ZXVwL3gtbG9hZC9pbmNsdWRlIC1mbm8tYnVpbHRpbiAtZmZyZWVzdGFuZGluZyAtbm9zdGRpbmMg
LWlzeXN0ZW0gL3Rvb2xzL2djYy00LjIvYmluLy4uL2xpYi9nY2MvYXJtLW5vbmUtbGludXgtZ251
ZWFiaS80LjIuMC9pbmNsdWRlIC1waXBlICAtRENPTkZJR19BUk0gLURfX0FSTV9fIC1tYXJjaD1h
cm12NSAtbWFiaT1hcGNzLWdudSAtV2FsbCAtV3N0cmljdC1wcm90b3R5cGVzIC1jIC1vIG9tYXAy
NDMwc2RwLm8gb21hcDI0MzBzZHAuYwphcm0tbm9uZS1saW51eC1nbnVlYWJpLWdjYyAtV2EsLWdz
dGFicyAtRF9fQVNTRU1CTFlfXyAtZyAgLU9zICAgLWZuby1zdHJpY3QtYWxpYXNpbmcgIC1mbm8t
Y29tbW9uIC1mZml4ZWQtcjggIC1EX19LRVJORUxfXyAtRFRFWFRfQkFTRT0weDgwZTgwMDAwIC1J
L2hvbWUvYTAzODQ4NjQvbGRyL3dha2V1cC94LWxvYWQvaW5jbHVkZSAtZm5vLWJ1aWx0aW4gLWZm
cmVlc3RhbmRpbmcgLW5vc3RkaW5jIC1pc3lzdGVtIC90b29scy9nY2MtNC4yL2Jpbi8uLi9saWIv
Z2NjL2FybS1ub25lLWxpbnV4LWdudWVhYmkvNC4yLjAvaW5jbHVkZSAtcGlwZSAgLURDT05GSUdf
QVJNIC1EX19BUk1fXyAtbWFyY2g9YXJtdjUgLW1hYmk9YXBjcy1nbnUgLWMgLW8gcGxhdGZvcm0u
byAvaG9tZS9hMDM4NDg2NC93dGJ1L2xvYWRlci93YWtldXAveC1sb2FkL2JvYXJkL29tYXAyNDMw
c2RwL3BsYXRmb3JtLlMKYXJtLW5vbmUtbGludXgtZ251ZWFiaS1hciBjcnYgbGlib21hcDI0MzBz
ZHAuYSBvbWFwMjQzMHNkcC5vIHBsYXRmb3JtLm8KciAtIG9tYXAyNDMwc2RwLm8KciAtIHBsYXRm
b3JtLm8KbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC9ob21lL2EwMzg0ODY0L3d0YnUvbG9h
ZGVyL3dha2V1cC94LWxvYWQvYm9hcmQvb21hcDI0MzBzZHAnCm1ha2UgLUMgYGRpcm5hbWUgY3B1
L2FybTExMzYvbGliYXJtMTEzNi5hYAptYWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkgYC9ob21l
L2EwMzg0ODY0L3d0YnUvbG9hZGVyL3dha2V1cC94LWxvYWQvY3B1L2FybTExMzYnCmFybS1ub25l
LWxpbnV4LWdudWVhYmktZ2NjIC1XYSwtZ3N0YWJzIC1EX19BU1NFTUJMWV9fIC1nICAtT3MgICAt
Zm5vLXN0cmljdC1hbGlhc2luZyAgLWZuby1jb21tb24gLWZmaXhlZC1yOCAgLURfX0tFUk5FTF9f
IC1EVEVYVF9CQVNFPTB4ODBlODAwMDAgLUkvaG9tZS9hMDM4NDg2NC9sZHIvd2FrZXVwL3gtbG9h
ZC9pbmNsdWRlIC1mbm8tYnVpbHRpbiAtZmZyZWVzdGFuZGluZyAtbm9zdGRpbmMgLWlzeXN0ZW0g
L3Rvb2xzL2djYy00LjIvYmluLy4uL2xpYi9nY2MvYXJtLW5vbmUtbGludXgtZ251ZWFiaS80LjIu
MC9pbmNsdWRlIC1waXBlICAtRENPTkZJR19BUk0gLURfX0FSTV9fIC1tYXJjaD1hcm12NSAtbWFi
aT1hcGNzLWdudSAtYyAtbyBzdGFydC5vIC9ob21lL2EwMzg0ODY0L3d0YnUvbG9hZGVyL3dha2V1
cC94LWxvYWQvY3B1L2FybTExMzYvc3RhcnQuUwphcm0tbm9uZS1saW51eC1nbnVlYWJpLWdjYyAt
ZyAgLU9zICAgLWZuby1zdHJpY3QtYWxpYXNpbmcgIC1mbm8tY29tbW9uIC1mZml4ZWQtcjggIC1E
X19LRVJORUxfXyAtRFRFWFRfQkFTRT0weDgwZTgwMDAwIC1JL2hvbWUvYTAzODQ4NjQvbGRyL3dh
a2V1cC94LWxvYWQvaW5jbHVkZSAtZm5vLWJ1aWx0aW4gLWZmcmVlc3RhbmRpbmcgLW5vc3RkaW5j
IC1pc3lzdGVtIC90b29scy9nY2MtNC4yL2Jpbi8uLi9saWIvZ2NjL2FybS1ub25lLWxpbnV4LWdu
dWVhYmkvNC4yLjAvaW5jbHVkZSAtcGlwZSAgLURDT05GSUdfQVJNIC1EX19BUk1fXyAtbWFyY2g9
YXJtdjUgLW1hYmk9YXBjcy1nbnUgLVdhbGwgLVdzdHJpY3QtcHJvdG90eXBlcyAtYyAtbyBjcHUu
byBjcHUuYwphcm0tbm9uZS1saW51eC1nbnVlYWJpLWFyIGNydiBsaWJhcm0xMTM2LmEgY3B1Lm8K
ciAtIGNwdS5vCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvaG9tZS9hMDM4NDg2NC93dGJ1
L2xvYWRlci93YWtldXAveC1sb2FkL2NwdS9hcm0xMTM2JwptYWtlIC1DIGBkaXJuYW1lIGxpYi9s
aWJhcm0uYWAKbWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvaG9tZS9hMDM4NDg2NC93dGJ1
L2xvYWRlci93YWtldXAveC1sb2FkL2xpYicKYXJtLW5vbmUtbGludXgtZ251ZWFiaS1nY2MgLWcg
IC1PcyAgIC1mbm8tc3RyaWN0LWFsaWFzaW5nICAtZm5vLWNvbW1vbiAtZmZpeGVkLXI4ICAtRF9f
S0VSTkVMX18gLURURVhUX0JBU0U9MHg4MGU4MDAwMCAtSS9ob21lL2EwMzg0ODY0L2xkci93YWtl
dXAveC1sb2FkL2luY2x1ZGUgLWZuby1idWlsdGluIC1mZnJlZXN0YW5kaW5nIC1ub3N0ZGluYyAt
aXN5c3RlbSAvdG9vbHMvZ2NjLTQuMi9iaW4vLi4vbGliL2djYy9hcm0tbm9uZS1saW51eC1nbnVl
YWJpLzQuMi4wL2luY2x1ZGUgLXBpcGUgIC1EQ09ORklHX0FSTSAtRF9fQVJNX18gLW1hcmNoPWFy
bXY1IC1tYWJpPWFwY3MtZ251IC1XYWxsIC1Xc3RyaWN0LXByb3RvdHlwZXMgLWMgLW8gYm9hcmQu
byBib2FyZC5jCmFybS1ub25lLWxpbnV4LWdudWVhYmktZ2NjIC1nICAtT3MgICAtZm5vLXN0cmlj
dC1hbGlhc2luZyAgLWZuby1jb21tb24gLWZmaXhlZC1yOCAgLURfX0tFUk5FTF9fIC1EVEVYVF9C
QVNFPTB4ODBlODAwMDAgLUkvaG9tZS9hMDM4NDg2NC9sZHIvd2FrZXVwL3gtbG9hZC9pbmNsdWRl
IC1mbm8tYnVpbHRpbiAtZmZyZWVzdGFuZGluZyAtbm9zdGRpbmMgLWlzeXN0ZW0gL3Rvb2xzL2dj
Yy00LjIvYmluLy4uL2xpYi9nY2MvYXJtLW5vbmUtbGludXgtZ251ZWFiaS80LjIuMC9pbmNsdWRl
IC1waXBlICAtRENPTkZJR19BUk0gLURfX0FSTV9fIC1tYXJjaD1hcm12NSAtbWFiaT1hcGNzLWdu
dSAtV2FsbCAtV3N0cmljdC1wcm90b3R5cGVzIC1jIC1vIGVjYy5vIGVjYy5jCmFybS1ub25lLWxp
bnV4LWdudWVhYmktZ2NjIC1nICAtT3MgICAtZm5vLXN0cmljdC1hbGlhc2luZyAgLWZuby1jb21t
b24gLWZmaXhlZC1yOCAgLURfX0tFUk5FTF9fIC1EVEVYVF9CQVNFPTB4ODBlODAwMDAgLUkvaG9t
ZS9hMDM4NDg2NC9sZHIvd2FrZXVwL3gtbG9hZC9pbmNsdWRlIC1mbm8tYnVpbHRpbiAtZmZyZWVz
dGFuZGluZyAtbm9zdGRpbmMgLWlzeXN0ZW0gL3Rvb2xzL2djYy00LjIvYmluLy4uL2xpYi9nY2Mv
YXJtLW5vbmUtbGludXgtZ251ZWFiaS80LjIuMC9pbmNsdWRlIC1waXBlICAtRENPTkZJR19BUk0g
LURfX0FSTV9fIC1tYXJjaD1hcm12NSAtbWFiaT1hcGNzLWdudSAtV2FsbCAtV3N0cmljdC1wcm90
b3R5cGVzIC1jIC1vIHByaW50Zi5vIHByaW50Zi5jCmFybS1ub25lLWxpbnV4LWdudWVhYmktYXIg
Y3J2IGxpYmFybS5hIF91ZGl2c2kzLm8gX3Vtb2RzaTMubyBib2FyZC5vIGVjYy5vIHByaW50Zi5v
IGRpdjAubyAKciAtIF91ZGl2c2kzLm8KciAtIF91bW9kc2kzLm8KciAtIGJvYXJkLm8KciAtIGVj
Yy5vCnIgLSBwcmludGYubwpyIC0gZGl2MC5vCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
aG9tZS9hMDM4NDg2NC93dGJ1L2xvYWRlci93YWtldXAveC1sb2FkL2xpYicKbWFrZSAtQyBgZGly
bmFtZSBkcml2ZXJzL2xpYmRyaXZlcnMuYWAKbWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0b3J5IGAv
aG9tZS9hMDM4NDg2NC93dGJ1L2xvYWRlci93YWtldXAveC1sb2FkL2RyaXZlcnMnCmFybS1ub25l
LWxpbnV4LWdudWVhYmktZ2NjIC1nICAtT3MgICAtZm5vLXN0cmljdC1hbGlhc2luZyAgLWZuby1j
b21tb24gLWZmaXhlZC1yOCAgLURfX0tFUk5FTF9fIC1EVEVYVF9CQVNFPTB4ODBlODAwMDAgLUkv
aG9tZS9hMDM4NDg2NC9sZHIvd2FrZXVwL3gtbG9hZC9pbmNsdWRlIC1mbm8tYnVpbHRpbiAtZmZy
ZWVzdGFuZGluZyAtbm9zdGRpbmMgLWlzeXN0ZW0gL3Rvb2xzL2djYy00LjIvYmluLy4uL2xpYi9n
Y2MvYXJtLW5vbmUtbGludXgtZ251ZWFiaS80LjIuMC9pbmNsdWRlIC1waXBlICAtRENPTkZJR19B
Uk0gLURfX0FSTV9fIC1tYXJjaD1hcm12NSAtbWFiaT1hcGNzLWdudSAtV2FsbCAtV3N0cmljdC1w
cm90b3R5cGVzIC1jIC1vIHNlcmlhbC5vIHNlcmlhbC5jCmFybS1ub25lLWxpbnV4LWdudWVhYmkt
Z2NjIC1nICAtT3MgICAtZm5vLXN0cmljdC1hbGlhc2luZyAgLWZuby1jb21tb24gLWZmaXhlZC1y
OCAgLURfX0tFUk5FTF9fIC1EVEVYVF9CQVNFPTB4ODBlODAwMDAgLUkvaG9tZS9hMDM4NDg2NC9s
ZHIvd2FrZXVwL3gtbG9hZC9pbmNsdWRlIC1mbm8tYnVpbHRpbiAtZmZyZWVzdGFuZGluZyAtbm9z
dGRpbmMgLWlzeXN0ZW0gL3Rvb2xzL2djYy00LjIvYmluLy4uL2xpYi9nY2MvYXJtLW5vbmUtbGlu
dXgtZ251ZWFiaS80LjIuMC9pbmNsdWRlIC1waXBlICAtRENPTkZJR19BUk0gLURfX0FSTV9fIC1t
YXJjaD1hcm12NSAtbWFiaT1hcGNzLWdudSAtV2FsbCAtV3N0cmljdC1wcm90b3R5cGVzIC1jIC1v
IG5zMTY1NTAubyBuczE2NTUwLmMKYXJtLW5vbmUtbGludXgtZ251ZWFiaS1nY2MgLWcgIC1PcyAg
IC1mbm8tc3RyaWN0LWFsaWFzaW5nICAtZm5vLWNvbW1vbiAtZmZpeGVkLXI4ICAtRF9fS0VSTkVM
X18gLURURVhUX0JBU0U9MHg4MGU4MDAwMCAtSS9ob21lL2EwMzg0ODY0L2xkci93YWtldXAveC1s
b2FkL2luY2x1ZGUgLWZuby1idWlsdGluIC1mZnJlZXN0YW5kaW5nIC1ub3N0ZGluYyAtaXN5c3Rl
bSAvdG9vbHMvZ2NjLTQuMi9iaW4vLi4vbGliL2djYy9hcm0tbm9uZS1saW51eC1nbnVlYWJpLzQu
Mi4wL2luY2x1ZGUgLXBpcGUgIC1EQ09ORklHX0FSTSAtRF9fQVJNX18gLW1hcmNoPWFybXY1IC1t
YWJpPWFwY3MtZ251IC1XYWxsIC1Xc3RyaWN0LXByb3RvdHlwZXMgLWMgLW8gazlmNTYxNi5vIGs5
ZjU2MTYuYwphcm0tbm9uZS1saW51eC1nbnVlYWJpLWdjYyAtZyAgLU9zICAgLWZuby1zdHJpY3Qt
YWxpYXNpbmcgIC1mbm8tY29tbW9uIC1mZml4ZWQtcjggIC1EX19LRVJORUxfXyAtRFRFWFRfQkFT
RT0weDgwZTgwMDAwIC1JL2hvbWUvYTAzODQ4NjQvbGRyL3dha2V1cC94LWxvYWQvaW5jbHVkZSAt
Zm5vLWJ1aWx0aW4gLWZmcmVlc3RhbmRpbmcgLW5vc3RkaW5jIC1pc3lzdGVtIC90b29scy9nY2Mt
NC4yL2Jpbi8uLi9saWIvZ2NjL2FybS1ub25lLWxpbnV4LWdudWVhYmkvNC4yLjAvaW5jbHVkZSAt
cGlwZSAgLURDT05GSUdfQVJNIC1EX19BUk1fXyAtbWFyY2g9YXJtdjUgLW1hYmk9YXBjcy1nbnUg
LVdhbGwgLVdzdHJpY3QtcHJvdG90eXBlcyAtYyAtbyBrOWsxMjE2Lm8gazlrMTIxNi5jCmFybS1u
b25lLWxpbnV4LWdudWVhYmktZ2NjIC1nICAtT3MgICAtZm5vLXN0cmljdC1hbGlhc2luZyAgLWZu
by1jb21tb24gLWZmaXhlZC1yOCAgLURfX0tFUk5FTF9fIC1EVEVYVF9CQVNFPTB4ODBlODAwMDAg
LUkvaG9tZS9hMDM4NDg2NC9sZHIvd2FrZXVwL3gtbG9hZC9pbmNsdWRlIC1mbm8tYnVpbHRpbiAt
ZmZyZWVzdGFuZGluZyAtbm9zdGRpbmMgLWlzeXN0ZW0gL3Rvb2xzL2djYy00LjIvYmluLy4uL2xp
Yi9nY2MvYXJtLW5vbmUtbGludXgtZ251ZWFiaS80LjIuMC9pbmNsdWRlIC1waXBlICAtRENPTkZJ
R19BUk0gLURfX0FSTV9fIC1tYXJjaD1hcm12NSAtbWFiaT1hcGNzLWdudSAtV2FsbCAtV3N0cmlj
dC1wcm90b3R5cGVzIC1jIC1vIG9uZW5hbmQubyBvbmVuYW5kLmMKYXJtLW5vbmUtbGludXgtZ251
ZWFiaS1nY2MgLWcgIC1PcyAgIC1mbm8tc3RyaWN0LWFsaWFzaW5nICAtZm5vLWNvbW1vbiAtZmZp
eGVkLXI4ICAtRF9fS0VSTkVMX18gLURURVhUX0JBU0U9MHg4MGU4MDAwMCAtSS9ob21lL2EwMzg0
ODY0L2xkci93YWtldXAveC1sb2FkL2luY2x1ZGUgLWZuby1idWlsdGluIC1mZnJlZXN0YW5kaW5n
IC1ub3N0ZGluYyAtaXN5c3RlbSAvdG9vbHMvZ2NjLTQuMi9iaW4vLi4vbGliL2djYy9hcm0tbm9u
ZS1saW51eC1nbnVlYWJpLzQuMi4wL2luY2x1ZGUgLXBpcGUgIC1EQ09ORklHX0FSTSAtRF9fQVJN
X18gLW1hcmNoPWFybXY1IC1tYWJpPWFwY3MtZ251IC1XYWxsIC1Xc3RyaWN0LXByb3RvdHlwZXMg
LWMgLW8gazlmMWcwOHIwYS5vIGs5ZjFnMDhyMGEuYwphcm0tbm9uZS1saW51eC1nbnVlYWJpLWFy
IGNydiBsaWJkcml2ZXJzLmEgc2VyaWFsLm8gbnMxNjU1MC5vIGs5ZjU2MTYubyBrOWsxMjE2Lm8g
b25lbmFuZC5vIGs5ZjFnMDhyMGEubwpyIC0gc2VyaWFsLm8KciAtIG5zMTY1NTAubwpyIC0gazlm
NTYxNi5vCnIgLSBrOWsxMjE2Lm8KciAtIG9uZW5hbmQubwpyIC0gazlmMWcwOHIwYS5vCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvaG9tZS9hMDM4NDg2NC93dGJ1L2xvYWRlci93YWtldXAv
eC1sb2FkL2RyaXZlcnMnClVOREVGX1NZTT1gYXJtLW5vbmUtbGludXgtZ251ZWFiaS1vYmpkdW1w
IC14IGJvYXJkL29tYXAyNDMwc2RwL2xpYm9tYXAyNDMwc2RwLmEgY3B1L2FybTExMzYvbGliYXJt
MTEzNi5hIGxpYi9saWJhcm0uYSBkcml2ZXJzL2xpYmRyaXZlcnMuYSB8c2VkICAtbiAtZSAncy8u
KlwoX191X2Jvb3RfY21kXy4qXCkvLXVcMS9wJ3xzb3J0fHVuaXFgO1wKIAkJYXJtLW5vbmUtbGlu
dXgtZ251ZWFiaS1sZCAtQnN0YXRpYyAtVCAvaG9tZS9hMDM4NDg2NC9sZHIvd2FrZXVwL3gtbG9h
ZC9ib2FyZC9vbWFwMjQzMHNkcC94LWxvYWQubGRzIC1UdGV4dCAweDgwZTgwMDAwICAkVU5ERUZf
U1lNIGNwdS9hcm0xMTM2L3N0YXJ0Lm8gXAoJCQktLXN0YXJ0LWdyb3VwIGJvYXJkL29tYXAyNDMw
c2RwL2xpYm9tYXAyNDMwc2RwLmEgY3B1L2FybTExMzYvbGliYXJtMTEzNi5hIGxpYi9saWJhcm0u
YSBkcml2ZXJzL2xpYmRyaXZlcnMuYSAtLWVuZC1ncm91cCAtTCAvdG9vbHMvZ2NjLTQuMi9iaW4v
Li4vbGliL2djYy9hcm0tbm9uZS1saW51eC1nbnVlYWJpLzQuMi4wIC1sZ2NjIFwKCQkJLU1hcCB4
LWxvYWQubWFwIC1vIHgtbG9hZAphcm0tbm9uZS1saW51eC1nbnVlYWJpLW9iamNvcHkgLS1nYXAt
ZmlsbD0weGZmIC1PIGJpbmFyeSB4LWxvYWQgeC1sb2FkLmJpbgo=

------_=_NextPart_001_01C80061.E5AACF3A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C80061.E5AACF3A--
