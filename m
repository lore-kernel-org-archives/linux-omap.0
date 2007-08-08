From: =?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@gmail.com>
Subject: Re: Compiling an image for OMAP
Date: Wed, 08 Aug 2007 15:19:33 -0300
Message-ID: <46BA0935.7010807@gmail.com>
References: <600adaf50708080613q3a85196cq56fbbcc139fd990f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <600adaf50708080613q3a85196cq56fbbcc139fd990f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tiago Maluta <tiago.maluta@gmail.com>, omap <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear fellow,

Which is your toolchain ?

try make help and look for which config best fit your initial needs



Tiago Maluta wrote:
> Hi,
>=20
> I'm trying to compile a kernel image for OMAP platform.
>=20
> I'm using the sources from kernel.org and from documentation, I put in =
a
> Makefile:
>=20
> #--------------------------------------------
> ARCH =3D arm
> CROSS_COMPILE =3D arm-none-linux-gnueabi-
> #--------------------------------------------
>=20
>=20
> linux-2.6.22.1 # make
>=20
> scripts/kconfig/conf -s arch/arm/Kconfig
>   CHK     include/linux/version.h
>   SYMLINK include/asm-arm/arch -> include/asm-arm/arch-omap
> make[1]: `include/asm-arm/mach-types.h' est=E1 atualizado.
>   CHK     include/linux/utsrelease.h
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/irqflags.h:46,
>                  from include/asm/system.h:78,
>                  from include/asm/bitops.h:23,
>                  from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/irqflags.h:11:5: warning: "__LINUX_ARM_ARCH__" is not defin=
ed
> In file included from include/asm/bitops.h:23,
>                  from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/system.h:153:5: warning: "__LINUX_ARM_ARCH__" is not define=
d
> include/asm/system.h:159:5: warning: "__LINUX_ARM_ARCH__" is not define=
d
> include/asm/system.h:163:35: warning: "__LINUX_ARM_ARCH__" is not defin=
ed
> include/asm/system.h:293:5: warning: "__LINUX_ARM_ARCH__" is not define=
d
> include/asm/system.h:298:5: warning: "__LINUX_ARM_ARCH__" is not define=
d
> In file included from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/bitops.h:233:5: warning: "__LINUX_ARM_ARCH__" is not define=
d
> In file included from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/fpstate.h:28:5: warning: "__LINUX_ARM_ARCH__" is not define=
d
> In file included from include/linux/spinlock.h:326,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/atomic.h:25:5: warning: "__LINUX_ARM_ARCH__" is not defined
> In file included from include/linux/jiffies.h:4,
>                  from include/linux/sched.h:51,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/linux/calc64.h: In function 'do_div_llr':
> include/linux/calc64.h:25: error: '__LINUX_ARM_ARCH__' undeclared (firs=
t
> use in this function)
> include/linux/calc64.h:25: error: (Each undeclared identifier is
> reported only once
> include/linux/calc64.h:25: error: for each function it appears in.)
> In file included from include/linux/prefetch.h:14,
>                  from include/linux/list.h:8,
>                  from include/linux/wait.h:22,
>                  from include/asm/semaphore.h:9,
>                  from include/linux/sched.h:59,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/processor.h:103:5: warning: "__LINUX_ARM_ARCH__" is not def=
ined
> In file included from include/asm/semaphore.h:13,
>                  from include/linux/sched.h:59,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/locks.h:15:5: warning: "__LINUX_ARM_ARCH__" is not defined
> In file included from include/asm/page.h:32,
>                  from include/linux/sched.h:60,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/glue.h:119:2: error: #error Unknown data abort handler type
> In file included from include/linux/sched.h:60,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/page.h:106:2: error: #error Unknown user operations model
> include/asm/page.h:189:31: warning: "__LINUX_ARM_ARCH__" is not defined
> make[1]: ** [arch/arm/kernel/asm-offsets.s] Erro 1
>=20
> -
> I saw a similar thread in the arm-gnu mail list, but I didn't found
> the solution.
> http://www.codesourcery.com/archives/arm-gnu/msg01214.html
>=20
> Any suggetions will be helpful.
>=20
> Thanks,
> - tiago
>=20

- --
-
-------------------------------------------------------------------------=
-----
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 - Building 30
P.O. Box: 90619-900 - Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
-
-------------------------------------------------------------------------=
--------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGugk1KNrSZaSIZoURAjYpAJ0ai5C7T2JXhRxMKHzWoO6Y0i967ACZAW/I
1hXFScE+JRHhrSPQ47y8wTA=3D
=3DRJDm
-----END PGP SIGNATURE-----
