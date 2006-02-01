From: =?ISO-8859-1?Q?Lu=EDs_Cargnini?= <lvcargnini@gmail.com>
Subject: Re: Howto build a gcc 4.0 toolchain for ARM?
Date: Wed, 1 Feb 2006 18:17:27 -0200
Message-ID: <ae36f8040602011217l55172309r@mail.gmail.com>
References: <43D746D5.80202@freescale.com>
	<1138346601.2518.9.camel@meenakshi.linux>
	<ae36f8040601270748j6117dcf3w@mail.gmail.com>
	<1138679218.2553.2.camel@meenakshi.linux>
	<ae36f8040601311057t2967cb33h@mail.gmail.com>
	<1138786038.2892.1.camel@meenakshi.linux>
	<ae36f8040602011154p6f088bfcl@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040602011154p6f088bfcl@mail.gmail.com>
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
To: Vineet Tuli <vineet@cybernetra.com>
Cc: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

hi thanks it worked for glibc

now the last problem is with compialtion of gcc with glibc


because during compilation of new gcc (with glibc) it happened:

make[2]: Entering directory
`/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc'
/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc/xgcc
-B/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc/
-B/opt/arm-linux/arm-linux/bin/ -B/opt/arm-linux/arm-linux/lib/ -isystem
/opt/arm-linux/arm-linux/include -isystem
/opt/arm-linux/arm-linux/sys-include -O2  -DIN_GCC -DCROSS_COMPILE   -W
-Wall -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes
-Wold-style-definition  -isystem ./include  -fomit-frame-pointer -fPIC -g0
-DHAVE_GTHR_DEFAULT -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc -I=
.
-I. -I../../gcc- 4.0.2/gcc -I../../gcc-4.0.2/gcc/.
-I../../gcc-4.0.2/gcc/../include
-I../../gcc-4.0.2/gcc/../libcpp/include  -fvisibility=3Dhidden -DHIDE_EXPOR=
TS
-fexceptions -c ../../gcc-4.0.2/gcc/unwind-dw2.c -o libgcc/./unwind-dw2.o
In file included from ./gthr- default.h:1,
                 from ../../gcc-4.0.2/gcc/gthr.h:114,
                 from ../../gcc-4.0.2/gcc/unwind-dw2.c:42:
../../gcc-4.0.2/gcc/gthr-posix.h:43:21: error: pthread.h: No such file or
directory
../../gcc-4.0.2/gcc/gthr-posix.h:44:20: error: unistd.h: No such file or
directory

just this it is simple i know that i could add the path but exist a way to
fix this ?? this little problem is known ?
i tried adding -I/opt/arm-linux/include on Makefile it compiled but after
some compiling time i received the following:

/opt/arm-linux/arm-linux/bin/ld: crti.o: No such file: No such file or
directory
collect2: ld returned 1 exit status
make[2]: *** [libgcc_s.so] Error 1
make[2]: Leaving directory
`/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory
`/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc'
make: *** [all-gcc] Error 2


--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
