From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESENDING PATCH 4/4] ARM: OMAP: Add ethernet support for OMAP
	LDP
Date: Fri, 16 May 2008 10:55:49 -0700
Message-ID: <20080516175549.GW23002@atomide.com>
References: <1210862562-5903-1-git-send-email-nskamat@ti.com> <1210862562-5903-2-git-send-email-nskamat@ti.com> <1210862562-5903-3-git-send-email-nskamat@ti.com> <1210862562-5903-4-git-send-email-nskamat@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:53550 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbYEPRzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 13:55:48 -0400
Content-Disposition: inline
In-Reply-To: <1210862562-5903-4-git-send-email-nskamat@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishant Kamat <nskamat@ti.com>
Cc: linux-omap@vger.kernel.org

* Nishant Kamat <nskamat@ti.com> [080515 07:45]:
> This patch adds ethernet support (smc911x) for OMAP LDP platform.
> 
> Signed-off-by: Nishant Kamat <nskamat@ti.com>
> ---
>  arch/arm/configs/omap_ldp_defconfig   |  164 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/board-ldp.c       |   51 ++++++++++
>  include/asm-arm/arch-omap/board-ldp.h |    6 +
>  3 files changed, 218 insertions(+), 3 deletions(-)
> 

<snip>

> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index 2ac4c9b..47e86bf 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -46,6 +46,26 @@
>  
>  #define TWL4030_MSECURE_GPIO	22
>  
> +static struct resource ldp_smc911x_resources[] = {
> +	[0] = {
> +		.start	= OMAP34XX_ETHR_START,
> +		.end	= OMAP34XX_ETHR_START + SZ_4K,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= 0,
> +		.end	= 0,
> +		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
> +	},
> +};
> +
> +static struct platform_device ldp_smc911x_device = {
> +	.name		= "smc911x",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(ldp_smc911x_resources),
> +	.resource	= ldp_smc911x_resources,
> +};
> +
>  static int ts_gpio;
>  
>  #ifdef CONFIG_RTC_DRV_TWL4030
> @@ -184,16 +204,47 @@ static struct spi_board_info ldp_spi_board_info[] __initdata = {
>  };
>  
>  static struct platform_device *ldp_devices[] __initdata = {
> +	&ldp_smc911x_device,
>  #ifdef CONFIG_RTC_DRV_TWL4030
>  	&ldp_twl4030rtc_device,
>  #endif
>  };
>  
> +static inline void __init ldp_init_smc911x(void)
> +{
> +	int eth_cs;
> +	unsigned long cs_mem_base;
> +	int eth_gpio = 0;
> +
> +	eth_cs = LDP_SMC911X_CS;
> +
> +	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
> +		printk(KERN_ERR "Failed to request GPMC mem for smc911x\n");
> +		return;
> +	}
> +
> +	ldp_smc911x_resources[0].start = cs_mem_base + 0x0;
> +	ldp_smc911x_resources[0].end   = cs_mem_base + 0xf;
> +	udelay(100);
> +
> +	eth_gpio = LDP_SMC911X_GPIO;
> +
> +	ldp_smc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
> +
> +	if (omap_request_gpio(eth_gpio) < 0) {
> +		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
> +			eth_gpio);
> +		return;
> +	}
> +	omap_set_gpio_direction(eth_gpio, 1);
> +}
> +
>  static void __init omap_ldp_init_irq(void)
>  {
>  	omap2_init_common_hw();
>  	omap_init_irq();
>  	omap_gpio_init();
> +	ldp_init_smc911x();
>  }
>  
>  static struct omap_uart_config ldp_uart_config __initdata = {
> diff --git a/include/asm-arm/arch-omap/board-ldp.h b/include/asm-arm/arch-omap/board-ldp.h
> index b227561..97c15d9 100644
> --- a/include/asm-arm/arch-omap/board-ldp.h
> +++ b/include/asm-arm/arch-omap/board-ldp.h
> @@ -29,6 +29,12 @@
>  #ifndef __ASM_ARCH_OMAP_LDP_H
>  #define __ASM_ARCH_OMAP_LDP_H
>  
> +#define DEBUG_BASE		0x08000000
> +
> +#define OMAP34XX_ETHR_START	DEBUG_BASE
> +#define LDP_SMC911X_CS		1
> +#define LDP_SMC911X_GPIO	152
> +
>  #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
>  
>  #endif /* __ASM_ARCH_OMAP_LDP_H */

These redefines will conflict when compiling in support for multiple
boards. They should be passed in the platform_data.

Tony
