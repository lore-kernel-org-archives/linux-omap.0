From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 24/25] ARM: pm: hide 1st and 2nd arguments to cpu_suspend from platform code
Date: Thu, 23 Jun 2011 14:27:10 -0700
Message-ID: <87mxh88ci9.fsf@ti.com>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
	<E1QZpOm-0005nx-T1@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [74.125.149.146] ([74.125.149.146]:39022 "EHLO psmtp.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752784Ab1FWV1O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:27:14 -0400
In-Reply-To: <E1QZpOm-0005nx-T1@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Thu, 23 Jun 2011 20:17:08 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> The first and second arguments shouldn't concern platform code, so
> hide them from each platforms caller.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/suspend.h |   19 +++++++++++++++++++
>  arch/arm/include/asm/system.h  |    2 --
>  arch/arm/kernel/sleep.S        |    2 +-
>  arch/arm/mach-omap2/pm34xx.c   |    5 +++--
>  arch/arm/mach-pxa/palmz72.c    |    1 +
>  arch/arm/mach-pxa/pxa25x.c     |    4 ++--
>  arch/arm/mach-pxa/pxa27x.c     |    4 ++--
>  arch/arm/mach-pxa/pxa3xx.c     |    3 ++-
>  arch/arm/mach-pxa/zeus.c       |    4 ++--
>  arch/arm/mach-sa1100/pm.c      |    3 ++-
>  arch/arm/plat-samsung/pm.c     |    3 ++-
>  11 files changed, 36 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm/include/asm/suspend.h
>
> diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
> new file mode 100644
> index 0000000..8d5b446
> --- /dev/null
> +++ b/arch/arm/include/asm/suspend.h
> @@ -0,0 +1,19 @@
> +#ifndef __ASM_ARM_SUSPEND_H
> +#define __ASM_ARM_SUSPEND_H
> +
> +#include <asm/memory.h>
> +
> +extern void cpu_resume(void);
> +
> +/*
> + * Hide the first two arguments to __cpu_suspend - these are an implementation
> + * detail which platform code shouldn't have to know about.
> + */
> +static inline void cpu_suspend(unsigned long arg, void (*fn)(unsigned long))
> +{
> +	extern void __cpu_suspend(int, long, unsigned long,
> +				  void (*)(unsigned long));
> +	__cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, arg, fn);
> +}
> +
> +#endif
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 50be605..832888d 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -106,8 +106,6 @@ extern void __show_regs(struct pt_regs *);
>  
>  extern int cpu_architecture(void);
>  extern void cpu_init(void);
> -extern void cpu_suspend(int, long, unsigned long, void (*)(unsigned long));
> -extern void cpu_resume(void);
>  
>  void arm_machine_restart(char mode, const char *cmd);
>  extern void (*arm_pm_restart)(char str, const char *cmd);
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 5392274..0bdcc72 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -14,7 +14,7 @@
>   *  r3 = suspend function
>   * Note: does not return until system resumes
>   */
> -ENTRY(cpu_suspend)
> +ENTRY(__cpu_suspend)

You missed also changing the ENDPROC here, so it doesn't compile
without:

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 0bdcc72..c156d0e 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -56,7 +56,7 @@ ENTRY(__cpu_suspend)
        bl      __cpuc_flush_kern_all
 #endif
        ldmfd   sp!, {r0, pc}           @ call suspend fn
-ENDPROC(cpu_suspend)
+ENDPROC(__cpu_suspend)
        .ltorg
 
 /*


Kevin
