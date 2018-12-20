From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/9] ARM: oxnas: remove CPU hotplug implementation
Date: Thu, 20 Dec 2018 15:03:44 +0100
Message-ID: <b1e2ac26-52a2-0614-4e14-0cb46e839d3f@baylibre.com>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVI3-00088u-N6@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1gXVI3-00088u-N6@rmk-PC.armlinux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/12/2018 19:00, Russell King wrote:
> The CPU hotplug implementation on this platform is cargo-culted from
> the plat-versatile implementation, and is buggy.  Once a CPU hits the
> "low power" loop, it will wait for pen_release to be set to the CPU
> number to wake up again - but nothing in this implementation does that.
> 
> So, once a CPU has entered cpu_die() it will never, ever leave.
> 
> Remove this useless cargo-culted implementation.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/mach-oxnas/Makefile  |   1 -
>  arch/arm/mach-oxnas/hotplug.c | 109 ------------------------------------------
>  arch/arm/mach-oxnas/platsmp.c |   4 --
>  3 files changed, 114 deletions(-)
>  delete mode 100644 arch/arm/mach-oxnas/hotplug.c
> 
> diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
> index b625906a9970..61a34e1c0f22 100644
> --- a/arch/arm/mach-oxnas/Makefile
> +++ b/arch/arm/mach-oxnas/Makefile
> @@ -1,2 +1 @@
>  obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> -obj-$(CONFIG_HOTPLUG_CPU) 	+= hotplug.o
> diff --git a/arch/arm/mach-oxnas/hotplug.c b/arch/arm/mach-oxnas/hotplug.c
> deleted file mode 100644
> index 854f29b8cba6..000000000000
> --- a/arch/arm/mach-oxnas/hotplug.c
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -/*
> - *  Copyright (C) 2002 ARM Ltd.
> - *  All Rights Reserved
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/smp.h>
> -
> -#include <asm/cp15.h>
> -#include <asm/smp_plat.h>
> -
> -static inline void cpu_enter_lowpower(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(
> -	"	mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> -	/*
> -	 * Turn off coherency
> -	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C)
> -	  : "cc");
> -}
> -
> -static inline void cpu_leave_lowpower(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	orr	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	  : "=&r" (v)
> -	  : "Ir" (CR_C)
> -	  : "cc");
> -}
> -
> -static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> -{
> -	/*
> -	 * there is no power-control hardware on this platform, so all
> -	 * we can do is put the core into WFI; this is safe as the calling
> -	 * code will have already disabled interrupts
> -	 */
> -	for (;;) {
> -		/*
> -		 * here's the WFI
> -		 */
> -		asm(".word	0xe320f003\n"
> -		    :
> -		    :
> -		    : "memory", "cc");
> -
> -		if (pen_release == cpu_logical_map(cpu)) {
> -			/*
> -			 * OK, proper wakeup, we're done
> -			 */
> -			break;
> -		}
> -
> -		/*
> -		 * Getting here, means that we have come out of WFI without
> -		 * having been woken up - this shouldn't happen
> -		 *
> -		 * Just note it happening - when we're woken, we can report
> -		 * its occurrence.
> -		 */
> -		(*spurious)++;
> -	}
> -}
> -
> -/*
> - * platform-specific code to shutdown a CPU
> - *
> - * Called with IRQs disabled
> - */
> -void ox820_cpu_die(unsigned int cpu)
> -{
> -	int spurious = 0;
> -
> -	/*
> -	 * we're ready for shutdown now, so do it
> -	 */
> -	cpu_enter_lowpower();
> -	platform_do_lowpower(cpu, &spurious);
> -
> -	/*
> -	 * bring this CPU back into the world of cache
> -	 * coherency, and then restore interrupts
> -	 */
> -	cpu_leave_lowpower();
> -
> -	if (spurious)
> -		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
> -}
> diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
> index 442cc8a2f7dc..735141c0e3a3 100644
> --- a/arch/arm/mach-oxnas/platsmp.c
> +++ b/arch/arm/mach-oxnas/platsmp.c
> @@ -19,7 +19,6 @@
>  #include <asm/smp_scu.h>
>  
>  extern void ox820_secondary_startup(void);
> -extern void ox820_cpu_die(unsigned int cpu);
>  
>  static void __iomem *cpu_ctrl;
>  static void __iomem *gic_cpu_ctrl;
> @@ -94,9 +93,6 @@ static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
>  static const struct smp_operations ox820_smp_ops __initconst = {
>  	.smp_prepare_cpus	= ox820_smp_prepare_cpus,
>  	.smp_boot_secondary	= ox820_boot_secondary,
> -#ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_die		= ox820_cpu_die,
> -#endif
>  };
>  
>  CPU_METHOD_OF_DECLARE(ox820_smp, "oxsemi,ox820-smp", &ox820_smp_ops);
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
