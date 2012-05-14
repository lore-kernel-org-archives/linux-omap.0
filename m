From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Mon, 14 May 2012 10:12:12 +0530
Message-ID: <4FB08D24.7070101@ti.com>
References: <1336644177-13834-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:43537 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363Ab2ENEmU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 00:42:20 -0400
Received: by obbeh20 with SMTP id eh20so10228310obb.17
        for <linux-omap@vger.kernel.org>; Sun, 13 May 2012 21:42:18 -0700 (PDT)
In-Reply-To: <1336644177-13834-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Thursday 10 May 2012 03:32 PM, Daniel Lezcano wrote:
> The current Makefile compiles the cpuidle34xx.c and cpuidle44xx.c files
> even if the cpuidle option is not set in the kernel.
>
> This patch fixes this by creating a section in the Makefile where these
> files are compiled only if the CONFIG_CPU_IDLE option is set.
>
> This modification breaks an implicit dependency between CPU_IDLE and PM as
> they belong to the same block in the Makefile. This is fixed in the Kconfig
> by selecting explicitely PM is CPU_IDLE is set.
>
> The linux coding style recommend to use no-op functions in the headers
> when the subsystem is disabled instead of adding big section in C files.

Looks good to me.
Reviewed-by: Rajendra Nayak <rnayak@ti.com>

>
> This patch fix this also.
>
> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/Kconfig       |    2 ++
>   arch/arm/mach-omap2/Makefile      |   11 +++++++----
>   arch/arm/mach-omap2/cpuidle34xx.c |    8 --------
>   arch/arm/mach-omap2/cpuidle44xx.c |    8 --------
>   arch/arm/mach-omap2/pm.h          |   17 +++++++++++++++--
>   5 files changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 8141b76..42f6b89 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -34,6 +34,7 @@ config ARCH_OMAP3
>   	select CPU_V7
>   	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>   	select ARCH_HAS_OPP
> +	select PM if CPU_IDLE
>   	select PM_OPP if PM
>   	select ARM_CPU_SUSPEND if PM
>   	select MULTI_IRQ_HANDLER
> @@ -51,6 +52,7 @@ config ARCH_OMAP4
>   	select PL310_ERRATA_727915
>   	select ARM_ERRATA_720789
>   	select ARCH_HAS_OPP
> +	select PM if CPU_IDLE
>   	select PM_OPP if PM
>   	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>   	select ARM_CPU_SUSPEND if PM
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 49f92bc..f46c735 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -64,10 +64,8 @@ endif
>   ifeq ($(CONFIG_PM),y)
>   obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>   obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
> -obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
> -					   cpuidle34xx.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o \
> -					   cpuidle44xx.o
> +obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
>   obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>   obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>   obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
> @@ -81,6 +79,11 @@ endif
>
>   endif
>
> +ifeq ($(CONFIG_CPU_IDLE),y)
> +obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
> +obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
> +endif
> +
>   # PRCM
>   obj-y					+= prm_common.o
>   obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 207bc1c..3134452 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -36,8 +36,6 @@
>   #include "control.h"
>   #include "common.h"
>
> -#ifdef CONFIG_CPU_IDLE
> -
>   /* Mach specific information to be recorded in the C-state driver_data */
>   struct omap3_idle_statedata {
>   	u32 mpu_state;
> @@ -379,9 +377,3 @@ int __init omap3_idle_init(void)
>
>   	return 0;
>   }
> -#else
> -int __init omap3_idle_init(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_CPU_IDLE */
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index be1617c..02d15bb 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -22,8 +22,6 @@
>   #include "pm.h"
>   #include "prm.h"
>
> -#ifdef CONFIG_CPU_IDLE
> -
>   /* Machine specific information */
>   struct omap4_idle_statedata {
>   	u32 cpu_state;
> @@ -199,9 +197,3 @@ int __init omap4_idle_init(void)
>
>   	return 0;
>   }
> -#else
> -int __init omap4_idle_init(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_CPU_IDLE */
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 7856489..ab04d3b 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -15,12 +15,25 @@
>
>   #include "powerdomain.h"
>
> +#ifdef CONFIG_CPU_IDLE
> +extern int __init omap3_idle_init(void);
> +extern int __init omap4_idle_init(void);
> +#else
> +static inline int omap3_idle_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline int omap4_idle_init(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>   extern void *omap3_secure_ram_storage;
>   extern void omap3_pm_off_mode_enable(int);
>   extern void omap_sram_idle(void);
>   extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
> -extern int omap3_idle_init(void);
> -extern int omap4_idle_init(void);
>   extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
>   extern int (*omap_pm_suspend)(void);
>

