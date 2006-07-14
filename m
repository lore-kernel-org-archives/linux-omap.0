From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Problems compiling gcc-4.1.0
Date: Fri, 14 Jul 2006 14:45:16 -0300
Message-ID: <ae36f8040607141045p5669198ci65d28617d466bbed@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi someone knows how to fix this:

/home/lvcargnini/puc/instramed/build/b-gcc/./gcc/xgcc
-B/home/lvcargnini/puc/instramed/build/b-gcc/./gcc/
-B/opt/arm-linux/arm-linux/bin/ -B/opt/arm-linux/arm-linux/lib/ -isystem
/opt/arm-linux/arm-linux/include -isystem
/opt/arm-linux/arm-linux/sys-include -O2 -O2 -g -O2  -DIN_GCC
-DCROSS_COMPILE   -W -Wall -Wwrite-strings -Wstrict-prototypes
-Wmissing-prototypes -Wold-style-definition  -isystem ./include  -I. -I.
-I../../gcc-4.1.0/gcc -I../../gcc-4.1.0/gcc/. -I../../gcc-4.1.0/gcc/../incl=
ude
-I../../gcc-4.1.0/gcc/../libcpp/include   -g0 -finhibit-size-directive
-fno-inline-functions -fno-exceptions -fno-zero-initialized-in-bss
-fno-unit-at-a-time   \
          -c ../../gcc-4.1.0/gcc/crtstuff.c -DCRT_BEGIN \
          -o crtbegin.o
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
make: *** [all] Error 2


i have modified ../gcc-4.1.0/gcc/config/arm/t-linux and added -Dinhibit_lib=
c
-D__gthr_posix_h
what should i do ???
I'm doing this because of the clock erros that are appearing on compiling
time with denx toolchain
Thanks for any help


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
