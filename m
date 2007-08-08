From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Compiling an image for OMAP
Date: Wed, 8 Aug 2007 10:59:39 -0400
Message-ID: <31e679430708080759s3179faa0l25d4726fc92a1ffd@mail.gmail.com>
References: <600adaf50708080613q3a85196cq56fbbcc139fd990f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <600adaf50708080613q3a85196cq56fbbcc139fd990f@mail.gmail.com>
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
To: Tiago Maluta <tiago.maluta@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 8/8/07, Tiago Maluta <tiago.maluta@gmail.com> wrote:
> Hi,
>
> I'm trying to compile a kernel image for OMAP platform.
>
> I'm using the sources from kernel.org and from documentation, I put in a
> Makefile:
>
> #--------------------------------------------
> ARCH =3D arm
> CROSS_COMPILE =3D arm-none-linux-gnueabi-
> #--------------------------------------------
>
>
> linux-2.6.22.1 # make
>
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
> include/asm/irqflags.h:11:5: warning: "__LINUX_ARM_ARCH__" is not defined
> In file included from include/asm/bitops.h:23,
>                  from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/system.h:153:5: warning: "__LINUX_ARM_ARCH__" is not defined
> include/asm/system.h:159:5: warning: "__LINUX_ARM_ARCH__" is not defined
> include/asm/system.h:163:35: warning: "__LINUX_ARM_ARCH__" is not defined
> include/asm/system.h:293:5: warning: "__LINUX_ARM_ARCH__" is not defined
> include/asm/system.h:298:5: warning: "__LINUX_ARM_ARCH__" is not defined
> In file included from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/bitops.h:233:5: warning: "__LINUX_ARM_ARCH__" is not defined
> In file included from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/fpstate.h:28:5: warning: "__LINUX_ARM_ARCH__" is not defined
> In file included from include/linux/spinlock.h:326,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/atomic.h:25:5: warning: "__LINUX_ARM_ARCH__" is not defined
> In file included from include/linux/jiffies.h:4,
>                  from include/linux/sched.h:51,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/linux/calc64.h: In function 'do_div_llr':
> include/linux/calc64.h:25: error: '__LINUX_ARM_ARCH__' undeclared (first
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
> include/asm/processor.h:103:5: warning: "__LINUX_ARM_ARCH__" is not defin=
ed
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
>
> -
> I saw a similar thread in the arm-gnu mail list, but I didn't found
> the solution.
> http://www.codesourcery.com/archives/arm-gnu/msg01214.html
>
> Any suggetions will be helpful.
>
> Thanks,
> - tiago
>
> --
> Tiago Maluta
> Research Group on Systems and Computer Engineering (GPESC)
> Federal University of Itajuba
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

are you using the kernel image from kernel.org??

try make ARCH=3Darm CROSS_COMPILE=3Darm-linux-

this should help.

--=20
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
