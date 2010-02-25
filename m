From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] can:ti_hecc: board specific hookup on AM3517EVM
Date: Thu, 25 Feb 2010 14:04:08 -0800
Message-ID: <20100225220408.GL28173@atomide.com>
References: <1266907068-6210-1-git-send-email-srk@ti.com>
 <1266907068-6210-2-git-send-email-srk@ti.com>
 <1266907068-6210-3-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56323 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933887Ab0BYWDG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 17:03:06 -0500
Content-Disposition: inline
In-Reply-To: <1266907068-6210-3-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriramakrishnan <srk@ti.com>
Cc: linux-omap@vger.kernel.org, anantgole@ti.com

* Sriramakrishnan <srk@ti.com> [100222 22:35]:
> Add board specific hookup for TI HECC driver on
> AM3517 EVM
> 
> Signed-off-by: Sriramakrishnan <srk@ti.com>
> Acked-by: Anant Gole <anantgole@ti.com>
> ---
> The driver requires that CAN_STB signal be driven low to enable
> CAN PHY. Currently this is being managed from U-boot. Will submit a patch
> for handling this as part of board init sequence.
> 
>  arch/arm/mach-omap2/board-am3517evm.c     |   38 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/am35xx.h |   10 +++++++
>  2 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
> index af99faf..42013b5 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
> +#include <linux/can/platform/ti_hecc.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/am35xx.h>
> @@ -223,6 +224,42 @@ static struct omap_board_mux board_mux[] __initdata = {
>  #define board_mux	NULL
>  #endif
>  
> +
> +static struct resource am3517_hecc_resources[] = {
> +	{
> +		.start  = AM35XX_IPSS_HECC_BASE,
> +		.end    = AM35XX_IPSS_HECC_BASE + 0x3FFF,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	{
> +		.start  = INT_35XX_HECC0_IRQ,
> +		.end    = INT_35XX_HECC0_IRQ,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device am3517_hecc_device = {
> +	.name           = "ti_hecc",
> +	.id             = -1,
> +	.num_resources  = ARRAY_SIZE(am3517_hecc_resources),
> +	.resource       = am3517_hecc_resources,
> +};
> +
> +static struct ti_hecc_platform_data am3517_evm_hecc_pdata = {
> +	.scc_hecc_offset        = AM35XX_HECC_SCC_HECC_OFFSET,
> +	.scc_ram_offset         = AM35XX_HECC_SCC_RAM_OFFSET,
> +	.hecc_ram_offset        = AM35XX_HECC_RAM_OFFSET,
> +	.mbx_offset            = AM35XX_HECC_MBOX_OFFSET,
> +	.int_line               = AM35XX_HECC_INT_LINE,
> +	.version                = AM35XX_HECC_VERSION,
> +};

The formatting above should use tabs instead of spaces. Please
check and run checkpatch.pl --strict on this.

Also, sounds like the Kconfig changes should be 2/2, not 1/2
to enable this.

Tony

> +
> +static void am3517_evm_hecc_init(struct ti_hecc_platform_data *pdata)
> +{
> +	am3517_hecc_device.dev.platform_data = pdata;
> +	platform_device_register(&am3517_hecc_device);
> +}
> +
>  static void __init am3517_evm_init(void)
>  {
>  	am3517_evm_i2c_init();
> @@ -233,6 +270,7 @@ static void __init am3517_evm_init(void)
>  
>  	omap_serial_init();
>  	usb_ehci_init(&ehci_pdata);
> +	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
>  	/* DSS */
>  	am3517_evm_display_init();
>  }
> diff --git a/arch/arm/mach-omap2/include/mach/am35xx.h b/arch/arm/mach-omap2/include/mach/am35xx.h
> index a705f94..6d5429b 100644
> --- a/arch/arm/mach-omap2/include/mach/am35xx.h
> +++ b/arch/arm/mach-omap2/include/mach/am35xx.h
> @@ -23,4 +23,14 @@
>  #define AM35XX_IPSS_HECC_BASE		0x5C050000
>  #define AM35XX_IPSS_VPFE_BASE		0x5C060000
>  
> +
> +/* HECC module specifc offset definitions */
> +#define AM35XX_HECC_SCC_HECC_OFFSET	(0x0)
> +#define AM35XX_HECC_SCC_RAM_OFFSET	(0x3000)
> +#define AM35XX_HECC_RAM_OFFSET		(0x3000)
> +#define AM35XX_HECC_MBOX_OFFSET		(0x2000)
> +#define AM35XX_HECC_INT_LINE		(0x0)
> +#define AM35XX_HECC_VERSION		(0x1)
> +
> +
>  #endif /*  __ASM_ARCH_AM35XX_H */
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
