From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: Clean-up MMC device init (Was: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data)
Date: Sat, 13 Sep 2008 10:59:46 +0100
Message-ID: <20080913095946.GA24437@flint.arm.linux.org.uk>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911091309.GD26078@flint.arm.linux.org.uk> <20080911173333.GI21163@atomide.com> <20080911181312.GC4986@flint.arm.linux.org.uk> <20080912004848.GO21163@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45985 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781AbYIMKAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 06:00:21 -0400
Content-Disposition: inline
In-Reply-To: <20080912004848.GO21163@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>

On Thu, Sep 11, 2008 at 05:48:49PM -0700, Tony Lindgren wrote:
> +static inline void omap1_mmc_mux(struct omap_mmc_platform_data *info)
> +{
> +	if (info->slots[0].enabled) {
> +		omap_cfg_reg(MMC_CMD);
> +		omap_cfg_reg(MMC_CLK);
> +		omap_cfg_reg(MMC_DAT0);
> +		if (cpu_is_omap1710()) {
> +			omap_cfg_reg(M15_1710_MMC_CLKI);
> +			omap_cfg_reg(P19_1710_MMC_CMDDIR);
> +			omap_cfg_reg(P20_1710_MMC_DATDIR0);
> +		}
> +		if (info->slots[0].wire4) {
> +			omap_cfg_reg(MMC_DAT1);
> +			/* NOTE: DAT2 can be on W10 (here) or M15 */
> +			if (!info->slots[0].nomux)
> +				omap_cfg_reg(MMC_DAT2);
> +			omap_cfg_reg(MMC_DAT3);
> +		}
> +	}
> +
> +	/* Block 2 is on newer chips, and has many pinout options */
> +	if (cpu_is_omap16xx() && info->slots[1].enabled) {
> +		if (!info->slots[1].nomux) {
> +			omap_cfg_reg(Y8_1610_MMC2_CMD);
> +			omap_cfg_reg(Y10_1610_MMC2_CLK);
> +			omap_cfg_reg(R18_1610_MMC2_CLKIN);
> +			omap_cfg_reg(W8_1610_MMC2_DAT0);
> +			if (info->slots[1].wire4) {
> +				omap_cfg_reg(V8_1610_MMC2_DAT1);
> +				omap_cfg_reg(W15_1610_MMC2_DAT2);
> +				omap_cfg_reg(R10_1610_MMC2_DAT3);
> +			}
> +
> +			/* These are needed for the level shifter */
> +			omap_cfg_reg(V9_1610_MMC2_CMDDIR);
> +			omap_cfg_reg(V5_1610_MMC2_DATDIR0);
> +			omap_cfg_reg(W19_1610_MMC2_DATDIR1);
> +		}
> +
> +		/* Feedback clock must be set on OMAP-1710 MMC2 */
> +		if (cpu_is_omap1710())
> +			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
> +					MOD_CONF_CTRL_1);
> +	}
> +}
> +
> +void omap1_init_mmc(struct omap_mmc_platform_data *info)
> +{
> +	if (!info)
> +		return;
> +
> +	omap1_mmc_mux(info);
> +	platform_set_drvdata(&omap1_mmc1_device, info);
> +
> +	if (cpu_is_omap16xx())
> +		platform_set_drvdata(OMAP1_MMC2_DEVICE, info);
> +
> +	omap_init_mmc(info, &omap1_mmc1_device, OMAP1_MMC2_DEVICE);
> +}
> +
> +#endif
> +
> +/*-------------------------------------------------------------------------*/
> +
>  #if defined(CONFIG_OMAP_STI)
>  
>  #define OMAP1_STI_BASE		IO_ADDRESS(0xfffea000)


> @@ -203,6 +205,113 @@ static inline void omap_init_mcspi(void) {}
>  
>  /*-------------------------------------------------------------------------*/
>  
> +#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
> +	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> +
> +#define	OMAP2_MMC1_BASE		0x4809c000
> +#define	OMAP2_MMC1_END		(OMAP2_MMC1_BASE + 0x1fc)
> +#define	OMAP2_MMC1_INT		INT_24XX_MMC_IRQ
> +
> +#define	OMAP2_MMC2_BASE		0x480b4000
> +#define	OMAP2_MMC2_END		(OMAP2_MMC2_BASE + 0x1fc)
> +#define	OMAP2_MMC2_INT		INT_24XX_MMC2_IRQ
> +
> +static u64 omap2_mmc1_dmamask = 0xffffffff;
> +
> +static struct resource omap2_mmc1_resources[] = {
> +	{
> +		.start		= OMAP2_MMC1_BASE,
> +		.end		= OMAP2_MMC1_END,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP2_MMC1_INT,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device omap2_mmc1_device = {
> +	.name		= "mmci-omap",
> +	.id		= 1,
> +	.dev = {
> +		.dma_mask	= &omap2_mmc1_dmamask,
> +	},
> +	.num_resources	= ARRAY_SIZE(omap2_mmc1_resources),
> +	.resource	= omap2_mmc1_resources,
> +};
> +
> +static u64 omap2_mmc2_dmamask = 0xffffffff;
> +
> +static struct resource omap2_mmc2_resources[] = {
> +	{
> +		.start		= OMAP2_MMC2_BASE,
> +		.end		= OMAP2_MMC2_END,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP2_MMC2_INT,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device omap2_mmc2_device = {
> +	.name		= "mmci-omap",
> +	.id		= 2,
> +	.dev = {
> +		.dma_mask	= &omap2_mmc2_dmamask,
> +	},
> +	.num_resources	= ARRAY_SIZE(omap2_mmc2_resources),
> +	.resource	= omap2_mmc2_resources,
> +};
> +
> +static inline void omap2_mmc_mux(struct omap_mmc_platform_data *info)
> +{
> +	if (!cpu_is_omap2420())
> +		return;
> +
> +	if (info->slots[0].enabled) {
> +		omap_cfg_reg(H18_24XX_MMC_CMD);
> +		omap_cfg_reg(H15_24XX_MMC_CLKI);
> +		omap_cfg_reg(G19_24XX_MMC_CLKO);
> +		omap_cfg_reg(F20_24XX_MMC_DAT0);
> +		omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
> +		omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
> +		if (info->slots[0].wire4) {
> +			omap_cfg_reg(H14_24XX_MMC_DAT1);
> +			omap_cfg_reg(E19_24XX_MMC_DAT2);
> +			omap_cfg_reg(D19_24XX_MMC_DAT3);
> +			omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
> +			omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
> +			omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
> +		}
> +
> +		/*
> +		 * Use internal loop-back in MMC/SDIO Module Input Clock
> +		 * selection
> +		 */
> +		if (info->slots[0].internal_clock) {
> +			u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> +			v |= (1 << 24);
> +			omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
> +		}
> +	}
> +}
> +
> +void omap2_init_mmc(struct omap_mmc_platform_data *info)
> +{
> +	if (!info)
> +		return;
> +
> +	omap2_mmc_mux(info);
> +	omap2_mmc1_device.dev.platform_data = info;
> +	omap2_mmc2_device.dev.platform_data = info;
> +	omap_init_mmc(info, &omap2_mmc1_device, &omap2_mmc2_device);
> +}
> +
> +#endif
> +
> +/*-------------------------------------------------------------------------*/
> +
>  static int __init omap2_init_devices(void)
>  {
>  	/* please keep these calls, and their implementations above,

Hmm.

How about, in arch/arm/plat-omap/devices.c:

static int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
		unsigned int irq, struct omap_mmc_platform_data *data)
{
	struct platform_device *dev;
	struct resource res[2];
	int ret;

	dev = platform_device_alloc("mmci-omap", id);
	if (!dev)
		return -ENOMEM;

	res[0].start = base;
	res[0].end = base + size - 1;
	res[0].flags = IORESOURCE_MEM;
	res[1].start = res[1].end = irq;
	res[1].flags = IORESOURCE_IRQ;

	ret = platform_device_add_resources(dev, res, ARRAY_SIZE(res));
	if (ret == 0)
		ret = platform_device_add_data(dev, data, sizeof(*data));
	if (ret)
		goto fail;

	ret = platform_device_add(dev);
	if (ret)
		goto fail;
	return 0;

 fail:
	platform_device_put(dev);
	return ret;
}

Now, for OMAP1 all you need, apart from the MUX function, is:

void omap1_init_mmc(struct omap_mmc_platform_data *info)
{
	omap1_mmc_mux(info);

	if (info->slots[0].enabled)
		omap_mmc_add(0, OMAP1_MMC1_BASE, 0x7f, OMAP1_MMC1_INT, info);

	if (cpu_is_omap16xx() && info->slots[1].enabled)
		omap_mmc_add(1, OMAP1_MMC2_BASE, 0x7f, OMAP1_MMC2_INT, info);
}

And OMAP2 looks like this:

void omap2_init_mmc(struct omap_mmc_platform_data *info)
{
	omap2_mmc_mux(info);

	if (info->slots[0].enabled)
		omap_mmc_add(0, OMAP2_MMC1_BASE, 0x1fc, OMAP2_MMC1_INT, info);

	if (info->slots[1].enabled)
		omap_mmc_add(1, OMAP2_MMC2_BASE, 0x1fc, OMAP2_MMC2_INT, info);
}

Maybe these functions should also be taking note of info->nr_slots?
Though I don't particularly like the way 'info' is shared between both
controllers.  It's more usual to pass a data structure to drivers
describing just the data for _this_ instance of the device.

Now, when you come across a device with three controllers, you're not
modifying arch/arm/plat-omap/devices.c to add that third controller -
you're just creating the omapN_init_mmc() function with another
omap_mmc_add() line.

As an added bonus, notice the lack of nasty #ifdef's scattered in there
as well.

Oh, and I see little reason for checking for NULL data in these functions -
they clearly don't take NULL data, and if someone passes NULL data, they
deserve to oops - and hopefully they'll fix their code.
