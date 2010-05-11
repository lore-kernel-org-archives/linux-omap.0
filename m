From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] omap-hsmmc.c: re-organize dma line population
Date: Tue, 11 May 2010 12:56:48 -0700
Message-ID: <20100511195648.GF13931@atomide.com>
References: <1273566733-22572-1-git-send-email-sriram.m@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56137 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab0EKT4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 15:56:46 -0400
Content-Disposition: inline
In-Reply-To: <1273566733-22572-1-git-send-email-sriram.m@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhvapathi Sriram <sriram.m@ti.com>
Cc: linux-omap@vger.kernel.org, madhu.cr@ti.com

* Madhvapathi Sriram <sriram.m@ti.com> [100511 02:26]:
> @@ -255,6 +256,52 @@ int __init omap_mmc_add(const char *name, int id, unsigned long base,
>  	res[0].flags = IORESOURCE_MEM;
>  	res[1].start = res[1].end = irq;
>  	res[1].flags = IORESOURCE_IRQ;
> +	/* Populate DMA lines based on the instance used. Rx first,Tx next*/
> +	switch (id) {
> +	case 0:
> +		res[2].start = OMAP24XX_DMA_MMC1_RX;
> +		res[2].end = OMAP24XX_DMA_MMC1_RX;
> +		res[2].flags = IORESOURCE_DMA;
> +		res[3].start = OMAP24XX_DMA_MMC1_TX;
> +		res[3].end = OMAP24XX_DMA_MMC1_TX;
> +		res[3].flags = IORESOURCE_DMA;
> +		break;
> +	case 1:
> +		res[2].start = OMAP24XX_DMA_MMC2_RX;
> +		res[2].end = OMAP24XX_DMA_MMC2_RX;
> +		res[2].flags = IORESOURCE_DMA;
> +		res[3].start = OMAP24XX_DMA_MMC2_TX;
> +		res[3].end = OMAP24XX_DMA_MMC2_TX;
> +		res[3].flags = IORESOURCE_DMA;
> +		break;
> +	case 2:
> +		res[2].start = OMAP34XX_DMA_MMC3_RX;
> +		res[2].end = OMAP34XX_DMA_MMC3_RX;
> +		res[2].flags = IORESOURCE_DMA;
> +		res[3].start = OMAP34XX_DMA_MMC3_TX;
> +		res[3].end = OMAP34XX_DMA_MMC3_TX;
> +		res[3].flags = IORESOURCE_DMA;
> +		break;
> +	case 3:
> +		res[2].start = OMAP44XX_DMA_MMC4_RX;
> +		res[2].end = OMAP44XX_DMA_MMC4_RX;
> +		res[2].flags = IORESOURCE_DMA;
> +		res[3].start = OMAP44XX_DMA_MMC4_TX;
> +		res[3].end = OMAP44XX_DMA_MMC4_TX;
> +		res[3].flags = IORESOURCE_DMA;
> +		break;
> +	case 4:
> +		res[2].start = OMAP44XX_DMA_MMC5_RX;
> +		res[2].end = OMAP44XX_DMA_MMC5_RX;
> +		res[2].flags = IORESOURCE_DMA;
> +		res[3].start = OMAP44XX_DMA_MMC5_TX;
> +		res[3].end = OMAP44XX_DMA_MMC5_TX;
> +		res[3].flags = IORESOURCE_DMA;
> +		break;
> +	default:
> +		ret = -ENODEV;
> +		goto fail;
> +	}

To me it seems like this should go into mach-omap2/hsmmc.c instead
of plat-omap/devices.c.

Tony
