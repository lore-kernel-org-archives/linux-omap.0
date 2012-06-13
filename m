From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/10] mtd: nand: omap2: handle nand on gpmc
Date: Wed, 13 Jun 2012 03:45:06 -0700
Message-ID: <20120613104505.GI12766@atomide.com>
References: <cover.1338790117.git.afzal@ti.com>
 <f39c9f3c8403d1ddc925ddcb6bf03ce1fe805c59.1338790117.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41751 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab2FMKpN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 06:45:13 -0400
Content-Disposition: inline
In-Reply-To: <f39c9f3c8403d1ddc925ddcb6bf03ce1fe805c59.1338790117.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com

* Afzal Mohammed <afzal@ti.com> [120604 00:06]:
> +static int omap_prefetch_enable(int cs, int fifo_th, int dma_mode,
> +	unsigned int u32_count, int is_write, struct omap_nand_info *info)
> +{
> +	u32 val;
> +
> +	if (fifo_th > PREFETCH_FIFOTHRESHOLD_MAX) {
> +		pr_err("gpmc: fifo threshold is not supported\n");
> +		return -1;
> +	} else if (!(readl(info->reg.gpmc_prefetch_control))) {
> +		/* Set the amount of bytes to be prefetched */
> +		writel(u32_count, info->reg.gpmc_prefetch_config2);
> +
> +		/* Set dma/mpu mode, the prefetch read / post write and
> +		 * enable the engine. Set which cs is has requested for.
> +		 */
> +		val = ((cs << PREFETCH_CONFIG1_CS_SHIFT) |
> +					PREFETCH_FIFOTHRESHOLD(fifo_th) |
> +					ENABLE_PREFETCH |
> +					(dma_mode << DMA_MPU_MODE_SHIFT) |
> +					(0x1 & is_write));
> +		writel(val, info->reg.gpmc_prefetch_config1);
> +
> +		/*  Start the prefetch engine */
> +		writel(0x1, info->reg.gpmc_prefetch_control);
> +	} else {
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

You can simplify the above by leaving out the if else stuff by
returning early:

	if (fifo_th > PREFETCH_FIFOTHRESHOLD_MAX)
		return -1;

	if (readl(info->reg.gpmc_prefetch_control))
		return -EBUSY;

	/* Set the amount of bytes to be prefetched */
	writel(u32_count, info->reg.gpmc_prefetch_config2);
	...

	return 0;

Regards,

Tony
