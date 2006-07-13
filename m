From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Git tree
Date: Thu, 13 Jul 2006 19:41:12 -0300
Message-ID: <ae36f8040607131541v5b969500mfa5c98bd3b8d719a@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Please whose git tree i must use the git tree provided bit mvist or
kernel.org ??
the problem compiling the source from kernel.org:

 CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/compile.h
  CC      arch/arm/plat-omap/clock.o
arch/arm/plat-omap/clock.c:31: error: static declaration of 'clocks' follow=
s
non-static declaration
include/asm/arch/clock.h:19: error: previous declaration of 'clocks' was
here
arch/arm/plat-omap/clock.c:33: error: static declaration of 'clockfw_lock'
follows non-static declaration
include/asm/arch/clock.h:20: error: previous declaration of 'clockfw_lock'
was here
make[1]: *** [arch/arm/plat-omap/clock.o] Error 1
make: *** [arch/arm/plat-omap] Error 2

persist.
How could i fix this ?
someone mentioned a patch where i found this patch for gcc ?
i'm using the denx toolchain, but thinking im recreate my own toolchain,
someone using 4.1.0 ??
and have a howto or quick-setup ?

compiling gcc.4.1.0 i founded the following:
In file included from ../../gcc-4.1.0/gcc/crtstuff.c:68:
../../gcc-4.1.0/gcc/tsystem.h:90:19: error: stdio.h: No such file or
directory
../../gcc-4.1.0/gcc/tsystem.h:93:23: error: sys/types.h: No such file or
directory
../../gcc-4.1.0/gcc/tsystem.h:96:19: error: errno.h: No such file or
directory
../../gcc-4.1.0/gcc/tsystem.h:103:20: error: string.h: No such file or
directory
../../gcc-4.1.0/gcc/tsystem.h:104:20: error: stdlib.h: No such file or
directory
../../gcc-4.1.0/gcc/tsystem.h:105:20: error: unistd.h: No such file or
directory
../../gcc-4.1.0/gcc/tsystem.h:111:18: error: time.h: No such file or
directory
make[2]: *** [crtbegin.o] Error 1
make[2]: Leaving directory `/home/lvcargnini/puc/instramed/build/b-gcc/gcc'
make[1]: *** [all-gcc] Error 2
make[1]: Leaving directory `/home/lvcargnini/puc/instramed/build/b-gcc'


but
../gcc-4.1.0/gcc/config/arm/t-linux
....
TARGET_LIBGCC2_CFLAGS =3D -fomit-frame-pointer -fPIC -Dinhibit_libc
-D__gthr_posix_h
....
 and my configure line is
../gcc-4.1.0/configure --prefix=3D/opt/arm-linux --target=3Darm-linux
--with-float=3Dsoft --with-cpu=3Darm9tdmi --disable-shared --disable-thread=
s
--with-headers=3D/opt/arm-linux/arm-linux/include --enable-languages=3Dc


thanks for any help.

--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
