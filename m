From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP4: Add L2 Cache support
Date: Fri, 29 Jan 2010 09:52:04 -0800
Message-ID: <20100129175204.GE23505@atomide.com>
References: <1264765589-18353-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51276 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab0A2RwD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 12:52:03 -0500
Content-Disposition: inline
In-Reply-To: <1264765589-18353-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100129 03:44]:
> This patch adds L2 Cache support for OMAP4. External L2 cache
> is used in OMPA4
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c        |   33 ++++++++++++++++++++++++++++
>  arch/arm/mm/Kconfig                        |    2 +-
>  arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
>  3 files changed, 35 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 0c6be6b..194d633 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -28,6 +28,7 @@
>  #include <plat/control.h>
>  #include <plat/timer-gp.h>
>  #include <asm/hardware/gic.h>
> +#include <asm/hardware/cache-l2x0.h>
>  
>  static struct platform_device sdp4430_lcd_device = {
>  	.name		= "sdp4430_lcd",
> @@ -49,6 +50,38 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
>  static struct omap_board_config_kernel sdp4430_config[] __initdata = {
>  	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
>  };
> +#ifdef CONFIG_CACHE_L2X0
> +static int __init omap_l2_cache_init(void)
> +{
> +	void __iomem *l2cache_base;

Since this is an initcall, you need to return here early to avoid
running on other omaps:

	if (!cpu_is_omap44xx())
		return -ENODEV;

> +
> +	/* Static mapping, never released */
> +	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
> +	BUG_ON(!l2cache_base);
> +
> +	/* Enable L2 Cache using secure api
> +	 * r0 contains the value to be modified and "r12" contains
> +	 * the monitor API number. This API uses few CPU registers
> +	 * internally and hence they need be backed up including
> +	 * link register "lr".
> +	 */
> +	__asm__ __volatile__(
> +		"stmfd r13!, {r0-r12, r14}\n"
> +		"mov r0, #1\n"
> +		"ldr r12, =0x102\n"
> +		"dsb\n"
> +		"smc\n"
> +		"ldmfd r13!, {r0-r12, r14}");
> +
> +	/* 32KB way size, 16-way associativity,
> +	* parity disabled
> +	*/
> +	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
> +
> +	return 0;
> +}
> +early_initcall(omap_l2_cache_init);
> +#endif

Regards,

Tony
