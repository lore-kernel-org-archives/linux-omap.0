From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv2] omap3: Add minimal OMAP3 IGEP module support.
Date: Sat, 2 Oct 2010 14:27:06 +0200
Message-ID: <201010021427.07226.laurent.pinchart@ideasonboard.com>
References: <1286012995-2697-1-git-send-email-eballetbo@gmail.com> <1286012995-2697-2-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.irobotique.be ([92.243.18.41]:55739 "EHLO
	perceval.irobotique.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab0JBM1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Oct 2010 08:27:07 -0400
In-Reply-To: <1286012995-2697-2-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

Hi Enric,

On Saturday 02 October 2010 11:49:55 Enric Balletbo i Serra wrote:
> The OMAP3 IGEP module is a low-power, high performance production-ready
> system-on-module (SOM) based on TI's OMAP3 family. More about this
> board at www.igep.es.

[snip]

> diff --git a/arch/arm/mach-omap2/board-igep0030.c
> b/arch/arm/mach-omap2/board-igep0030.c new file mode 100644
> index 0000000..7313ef5
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-igep0030.c

[snip]

> +static int igep3_onenand_setup(void __iomem *onenand_base, int freq)
> +{
> +	/* nothing is required to be setup for onenand as of now */
> +	return 0;
> +}
> +
> +static struct omap_onenand_platform_data igep3_onenand_pdata = {
> +	.parts = igep3_onenand_partitions,
> +	.nr_parts = ARRAY_SIZE(igep3_onenand_partitions),
> +	.onenand_setup = igep3_onenand_setup,
> +	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
> +};

You can just set onenand_setup to NULL instead of adding a no-op function.

[snip]

> +void __init igep3_flash_init(void)
> +{
> +	u8 cs = 0;
> +	u8 onenandcs = GPMC_CS_NUM + 1;
> +
> +	while (cs < GPMC_CS_NUM) {

What's wrong with "for (cs = 0; cs < GPMC_CS_NUM; cs++)" ? :-)

> +		u32 ret = 0;

No need to initialize ret to 0, you're assigning it right after.

> +		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +		/* Check if NAND/oneNAND is configured */
> +		if ((ret & 0xC00) == 0x800)
> +			/* NAND found */
> +			pr_err("IGEP3: Unsupported NAND found\n");
> +		else {
> +			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
> +			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
> +				/* ONENAND found */
> +				onenandcs = cs;
> +		}
> +		cs++;
> +	}
> +	if (onenandcs > GPMC_CS_NUM) {
> +		pr_err("IGEP3: Unable to find configuration in GPMC\n");
> +		return;
> +	}
> +
> +	if (onenandcs < GPMC_CS_NUM) {

No need to check for onenandcs < GPMC_CS_NUM here, it will always be true.

> +		igep3_onenand_pdata.cs = onenandcs;
> +		if (platform_device_register(&igep3_onenand_device) < 0)
> +			pr_err("IGEP3: Unable to register OneNAND device\n");
> +	}
> +}

[snip]

> +static void __init igep3_init_irq(void)
> +{
> +	omap_board_config = igep3_config;
> +	omap_board_config_size = ARRAY_SIZE(igep3_config);

No need for this. omap_board_config_size is implicitly initialized to 0 in 
plat-omap/common.c so get_config() won't dereference omap_board_config. You 
can remove the empty igep3_config array.

> +	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
> +	omap_init_irq();
> +	omap_gpio_init();
> +}

[snip]

-- 
Regards,

Laurent Pinchart
