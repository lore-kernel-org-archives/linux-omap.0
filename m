From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/6] OMAP_LDP: Add Ethernet device support to make
	ldp boot succeess.
Date: Thu, 13 Nov 2008 14:53:45 -0800
Message-ID: <20081113225344.GQ3106@atomide.com>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com> <1226404258-13027-2-git-send-email-stanley.miao@windriver.com> <1226404258-13027-3-git-send-email-stanley.miao@windriver.com> <20081113224243.GP3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56792 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbYKMWxs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 17:53:48 -0500
Content-Disposition: inline
In-Reply-To: <20081113224243.GP3106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org, johnpol@2ka.mipt.ru

* Tony Lindgren <tony@atomide.com> [081113 14:43]:
> * Stanley.Miao <stanley.miao@windriver.com> [081111 03:45]:
> > Add Ethernet device support in board-ldp.c to make ldp can boot and mount nfs
> > successfully.
> 
> Pushing only the board related changes of this patch.
> 
> Please send the smc91x changes to netdev list for integration and cc
> linux-omap list.

Adding board-ldp.c related part + defconfig options for smc to
omap3-upstream queue.

> Thanks,
> 
> Tony
> 
> 
> > Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> > ---
> >  arch/arm/mach-omap2/board-ldp.c             |   53 +++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/mach/board-ldp.h |    5 ++-
> >  drivers/net/smc911x.c                       |    6 ++-
> >  drivers/net/smc911x.h                       |    2 +
> >  4 files changed, 63 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> > index c2bb726..e89f271 100644
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -44,6 +44,7 @@
> >  #include "mmc-twl4030.h"
> >  
> >  
> > +#define SDP3430_SMC91X_CS	3
> >  #define CONFIG_DISABLE_HFCLK 1
> >  
> >  #define ENABLE_VAUX1_DEDICATED	0x03
> > @@ -51,6 +52,26 @@
> >  
> >  #define TWL4030_MSECURE_GPIO	22
> >  
> > +static struct resource ldp_smc911x_resources[] = {
> > +	[0] = {
> > +		.start	= OMAP34XX_ETHR_START,
> > +		.end	= OMAP34XX_ETHR_START + SZ_4K,
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[1] = {
> > +		.start	= 0,
> > +		.end	= 0,
> > +		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
> > +	},
> > +};
> > +
> > +static struct platform_device ldp_smc911x_device = {
> > +	.name		= "smc911x",
> > +	.id		= -1,
> > +	.num_resources	= ARRAY_SIZE(ldp_smc911x_resources),
> > +	.resource	= ldp_smc911x_resources,
> > +};
> > +
> >  static int ts_gpio;
> >  
> >  static int __init msecure_init(void)
> > @@ -177,14 +198,46 @@ static struct platform_device ldp_lcd_device = {
> >  };
> >  
> >  static struct platform_device *ldp_devices[] __initdata = {
> > +	&ldp_smc911x_device,
> >  	&ldp_lcd_device,
> >  };
> >  
> > +static inline void __init ldp_init_smc911x(void)
> > +{
> > +	int eth_cs;
> > +	unsigned long cs_mem_base;
> > +	int eth_gpio = 0;
> > +
> > +	eth_cs = LDP_SMC911X_CS;
> > +
> > +	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
> > +		printk(KERN_ERR "Failed to request GPMC mem for smc911x\n");
> > +		return;
> > +	}
> > +
> > +	ldp_smc911x_resources[0].start = cs_mem_base + 0x0;
> > +	ldp_smc911x_resources[0].end   = cs_mem_base + 0xf;
> > +	udelay(100);
> > +
> > +	eth_gpio = LDP_SMC911X_GPIO;
> > +
> > +	ldp_smc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
> > +
> > +	if (omap_request_gpio(eth_gpio) < 0) {
> > +		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
> > +				eth_gpio);
> > +		return;
> > +	}
> > +	omap_set_gpio_direction(eth_gpio, 1);
> > +}
> > +
> > +
> >  static void __init omap_ldp_init_irq(void)
> >  {
> >  	omap2_init_common_hw(NULL);
> >  	omap_init_irq();
> >  	omap_gpio_init();
> > +	ldp_init_smc911x();
> >  }
> >  
> >  static struct omap_uart_config ldp_uart_config __initdata = {
> > diff --git a/arch/arm/plat-omap/include/mach/board-ldp.h b/arch/arm/plat-omap/include/mach/board-ldp.h
> > index 66e2746..f233996 100644
> > --- a/arch/arm/plat-omap/include/mach/board-ldp.h
> > +++ b/arch/arm/plat-omap/include/mach/board-ldp.h
> > @@ -32,5 +32,8 @@
> >  extern void twl4030_bci_battery_init(void);
> >  
> >  #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
> > -
> > +#define LDP_SMC911X_CS         1
> > +#define LDP_SMC911X_GPIO       152
> > +#define DEBUG_BASE             0x08000000
> > +#define OMAP34XX_ETHR_START    DEBUG_BASE
> >  #endif /* __ASM_ARCH_OMAP_LDP_H */
> > diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
> > index f59c777..05e7512 100644
> > --- a/drivers/net/smc911x.c
> > +++ b/drivers/net/smc911x.c
> > @@ -2063,7 +2063,7 @@ static int smc911x_drv_probe(struct platform_device *pdev)
> >  		ret = -ENODEV;
> >  		goto out;
> >  	}
> > -
> > +#ifndef SMC_MEM_RESERVED
> >  	/*
> >  	 * Request the regions.
> >  	 */
> > @@ -2071,7 +2071,7 @@ static int smc911x_drv_probe(struct platform_device *pdev)
> >  		 ret = -EBUSY;
> >  		 goto out;
> >  	}
> > -
> > +#endif
> >  	ndev = alloc_etherdev(sizeof(struct smc911x_local));
> >  	if (!ndev) {
> >  		printk("%s: could not allocate device.\n", CARDNAME);
> > @@ -2108,7 +2108,9 @@ static int smc911x_drv_probe(struct platform_device *pdev)
> >  release_both:
> >  		free_netdev(ndev);
> >  release_1:
> > +#ifndef SMC_MEM_RESERVED
> >  		release_mem_region(res->start, SMC911X_IO_EXTENT);
> > +#endif
> >  out:
> >  		printk("%s: not found (%d).\n", CARDNAME, ret);
> >  	}
> > diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
> > index d1b3b9b..f688b55 100644
> > --- a/drivers/net/smc911x.h
> > +++ b/drivers/net/smc911x.h
> > @@ -682,6 +682,7 @@ smc_pxa_dma_outsl(struct smc911x_local *lp, u_long physaddr,
> >  #define CHIP_9116	0x0116
> >  #define CHIP_9117	0x0117
> >  #define CHIP_9118	0x0118
> > +#define CHIP_9211	0x9211
> >  #define CHIP_9215	0x115A
> >  #define CHIP_9217	0x117A
> >  #define CHIP_9218	0x118A
> > @@ -696,6 +697,7 @@ static const struct chip_id chip_ids[] =  {
> >  	{ CHIP_9116, "LAN9116" },
> >  	{ CHIP_9117, "LAN9117" },
> >  	{ CHIP_9118, "LAN9118" },
> > +	{ CHIP_9211, "LAN9211" },
> >  	{ CHIP_9215, "LAN9215" },
> >  	{ CHIP_9217, "LAN9217" },
> >  	{ CHIP_9218, "LAN9218" },
> > -- 
> > 1.5.6.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
