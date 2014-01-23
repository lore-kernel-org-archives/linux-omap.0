From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: OMAP4+: move errata initialization to omap4_pm_init_early
Date: Thu, 23 Jan 2014 17:48:21 +0200
Message-ID: <52E139C5.3090207@ti.com>
References: <CAGa+x863_MQ22h+U=KtK++3aG2F_X4x57Xtfe16GYXKNiaWX4A@mail.gmail.com> <1390248397-14112-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46609 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAWOwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jan 2014 09:52:39 -0500
In-Reply-To: <1390248397-14112-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>

On 01/20/2014 10:06 PM, Nishanth Menon wrote:
> Move all OMAP4 PM errata initializations to centralized location in
> omap4_pm_init_early. This allows for users to utilize the erratas
> in various submodules as needed.
> 
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>

This patch fixes build failure caused by patch 
https://patchwork.kernel.org/patch/3084521/ 
in case if SMP is not enabled.

> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Reported by Tony here: https://patchwork.kernel.org/patch/3084521/
> Reproduced with .config: http://slexy.org/view/s2EEdvTGXV on next-20140120 tag (based on omap2plus_defconfig)
> Applies on v3.13 tag and on next-20140120
> Tested to boot on next-20140120 along with https://patchwork.kernel.org/patch/3084521/
> on PandaBoard-ES with multi_v7_defconfig: http://slexy.org/view/s27n0BWrPf
> 
>   arch/arm/mach-omap2/common.h   |    6 ++++++
>   arch/arm/mach-omap2/io.c       |    1 +
>   arch/arm/mach-omap2/omap-smp.c |    6 +-----
>   arch/arm/mach-omap2/pm44xx.c   |   15 +++++++++++++++
>   4 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 3adaa1d..a6aae30 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -62,11 +62,17 @@ static inline int omap3_pm_init(void)
>   
>   #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
>   int omap4_pm_init(void);
> +int omap4_pm_init_early(void);
>   #else
>   static inline int omap4_pm_init(void)
>   {
>   	return 0;
>   }
> +
> +static inline int omap4_pm_init_early(void)
> +{
> +	return 0;
> +}
>   #endif
>   
>   #ifdef CONFIG_OMAP_MUX
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 47381fd..d408b15 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -641,6 +641,7 @@ void __init omap4430_init_early(void)
>   	omap_cm_base_init();
>   	omap4xxx_check_revision();
>   	omap4xxx_check_features();
> +	omap4_pm_init_early();
>   	omap44xx_prm_init();
>   	omap44xx_voltagedomains_init();
>   	omap44xx_powerdomains_init();
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 75e95d4..17550aa 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -39,8 +39,6 @@
>   
>   #define OMAP5_CORE_COUNT	0x2
>   
> -u16 pm44xx_errata;
> -
>   /* SCU base address */
>   static void __iomem *scu_base;
>   
> @@ -217,10 +215,8 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
>   	if (scu_base)
>   		scu_enable(scu_base);
>   
> -	if (cpu_is_omap446x()) {
> +	if (cpu_is_omap446x())
>   		startup_addr = omap4460_secondary_startup;
> -		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
> -	}
>   
>   	/*
>   	 * Write the address of secondary startup routine into the
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 82f06989..eefb30c 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -24,6 +24,8 @@
>   #include "powerdomain.h"
>   #include "pm.h"
>   
> +u16 pm44xx_errata;
> +
>   struct power_state {
>   	struct powerdomain *pwrdm;
>   	u32 next_state;
> @@ -199,6 +201,19 @@ static inline int omap4_init_static_deps(void)
>   }
>   
>   /**
> + * omap4_pm_init_early - Does early initialization necessary for OMAP4+ devices
> + *
> + * Initializes basic stuff for power management functionality.
> + */
> +int __init omap4_pm_init_early(void)
> +{
> +	if (cpu_is_omap446x())
> +		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
> +
> +	return 0;
> +}
> +
> +/**
>    * omap4_pm_init - Init routine for OMAP4+ devices
>    *
>    * Initializes all powerdomain and clockdomain target states
> 

