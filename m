From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 10/13] ARM: OMAP5: board-generic: Add device tree support.
Date: Mon, 7 May 2012 15:27:29 +0200
Message-ID: <4FA7CDC1.9050301@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-11-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36151 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449Ab2EGN1f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 09:27:35 -0400
In-Reply-To: <1336029982-31898-11-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com

Hi Sricharan,

On 5/3/2012 9:26 AM, R Sricharan wrote:
> Adding the minimal support for OMAP5 soc with device tree.

You should probably split that patch since you are doing several things 
that are not OMAP5 related.

Do a patch that move the omap_init_irq into the INTC and GIC code first.

Then, you can add a patch to add the OMAP5_DT machine entry.

> Signed-off-by: R Sricharan<r.sricharan@ti.com>
> ---
>   arch/arm/mach-omap2/board-generic.c |   39 +++++++++++++++++++++-------------
>   arch/arm/mach-omap2/common.h        |    2 +
>   arch/arm/mach-omap2/irq.c           |   11 +++++++++
>   arch/arm/mach-omap2/omap4-common.c  |   14 ++++++++++++
>   4 files changed, 51 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 098d183..0dd9e3f 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -20,6 +20,7 @@
>   #include<mach/hardware.h>
>   #include<asm/hardware/gic.h>
>   #include<asm/mach/arch.h>
> +#include<mach/omap-wakeupgen.h>
>
>   #include<plat/board.h>
>   #include "common.h"
> @@ -32,17 +33,6 @@
>   #define gic_of_init		NULL
>   #endif
>
> -static struct of_device_id irq_match[] __initdata = {
> -	{ .compatible = "ti,omap2-intc", .data = omap_intc_of_init, },
> -	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> -	{ }
> -};
> -
> -static void __init omap_init_irq(void)
> -{
> -	of_irq_init(irq_match);
> -}
> -
>   static struct of_device_id omap_dt_match_table[] __initdata = {
>   	{ .compatible = "simple-bus", },
>   	{ .compatible = "ti,omap-infra", },
> @@ -66,7 +56,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
>   	.reserve	= omap_reserve,
>   	.map_io		= omap242x_map_io,
>   	.init_early	= omap2420_init_early,
> -	.init_irq	= omap_init_irq,
> +	.init_irq	= omap_of_init_irq,
>   	.handle_irq	= omap2_intc_handle_irq,
>   	.init_machine	= omap_generic_init,
>   	.timer		=&omap2_timer,
> @@ -85,7 +75,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
>   	.reserve	= omap_reserve,
>   	.map_io		= omap243x_map_io,
>   	.init_early	= omap2430_init_early,
> -	.init_irq	= omap_init_irq,
> +	.init_irq	= omap_of_init_irq,
>   	.handle_irq	= omap2_intc_handle_irq,
>   	.init_machine	= omap_generic_init,
>   	.timer		=&omap2_timer,
> @@ -120,7 +110,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
>   	.reserve	= omap_reserve,
>   	.map_io		= omap3_map_io,
>   	.init_early	= omap3430_init_early,
> -	.init_irq	= omap_init_irq,
> +	.init_irq	= omap_of_init_irq,
>   	.handle_irq	= omap3_intc_handle_irq,
>   	.init_machine	= omap3_init,
>   	.timer		=&omap3_timer,
> @@ -155,7 +145,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
>   	.reserve	= omap_reserve,
>   	.map_io		= omap4_map_io,
>   	.init_early	= omap4430_init_early,
> -	.init_irq	= omap_init_irq,
> +	.init_irq	= omap_gic_of_init,
>   	.handle_irq	= gic_handle_irq,
>   	.init_machine	= omap4_init,
>   	.timer		=&omap4_timer,
> @@ -163,3 +153,22 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
>   	.restart	= omap_prcm_restart,
>   MACHINE_END
>   #endif
> +
> +#ifdef CONFIG_ARCH_OMAP5
> +static const char *omap5_boards_compat[] __initdata = {
> +	"ti,omap5",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
> +	.reserve	= omap_reserve,
> +	.map_io		= omap5_map_io,
> +	.init_early	= omap5_init_early,
> +	.init_irq	= omap_gic_of_init,
> +	.handle_irq	= gic_handle_irq,
> +	.init_machine	= omap_generic_init,
> +	.timer		=&omap5_timer,
> +	.dt_compat	= omap5_boards_compat,
> +	.restart	= omap_prcm_restart,
> +MACHINE_END
> +#endif
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 0771d22..e66859d 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -185,6 +185,8 @@ void omap3_intc_prepare_idle(void);
>   void omap3_intc_resume_idle(void);
>   void omap2_intc_handle_irq(struct pt_regs *regs);
>   void omap3_intc_handle_irq(struct pt_regs *regs);
> +void omap_of_init_irq(void);

In order to be consistent with the GIC function and even the previous 
ones, you should name the exported one:

+void omap_intc_of_init(void);

> +void omap_gic_of_init(void);
>
>   #ifdef CONFIG_CACHE_L2X0
>   extern void __iomem *omap4_get_l2cache_base(void);
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 65f0d25..d316c68 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -21,6 +21,7 @@
>   #include<linux/irqdomain.h>
>   #include<linux/of.h>
>   #include<linux/of_address.h>
> +#include<linux/of_irq.h>
>
>   #include<mach/hardware.h>
>
> @@ -279,6 +280,16 @@ int __init omap_intc_of_init(struct device_node *node,

And thus rename that one that become a private function without the 
omap_ prefix.

>   	return 0;
>   }
>
> +static struct of_device_id irq_match[] __initdata = {
> +	{ .compatible = "ti,omap2-intc", .data = omap_intc_of_init, },

+	{ .compatible = "ti,omap2-intc", .data = intc_of_init, },

> +	{ }
> +};
> +
> +void __init omap_of_init_irq(void)

+void __init omap_intc_of_init(void)

> +{
> +	of_irq_init(irq_match);
> +}

Regards,
Benoit
