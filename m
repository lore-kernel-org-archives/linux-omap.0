From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 2/5] omap3: nand: prefetch in irq mode support
Date: Tue, 28 Sep 2010 15:29:33 -0700
Message-ID: <20100928222933.GT3117@atomide.com>
References: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
 <1285594634-19277-3-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63008 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0I1W3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 18:29:39 -0400
Content-Disposition: inline
In-Reply-To: <1285594634-19277-3-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Vimal Singh <vimalsingh@ti.com>

* Sukumar Ghorai <s-ghorai@ti.com> [100927 06:30]:
>  This patch enable prefetch-irq mode for NAND.

> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -112,6 +112,9 @@ config MTD_NAND_OMAP_PREFETCH
>  	help
>  	 The NAND device can be accessed for Read/Write using GPMC PREFETCH engine
>  	 to improve the performance.
> +	 GPMC PREFETCH can be configured eigther in MPU interrupt mode or in DMA
> +	 interrupt mode. If not selected any of them prefetch will be used in
> +	 polling mode.
>  
>  config MTD_NAND_OMAP_PREFETCH_DMA
>  	depends on MTD_NAND_OMAP_PREFETCH
> @@ -120,7 +123,16 @@ config MTD_NAND_OMAP_PREFETCH_DMA
>  	help
>  	 The GPMC PREFETCH engine can be configured eigther in MPU interrupt mode
>  	 or in DMA interrupt mode.
> -	 Say y for DMA mode or MPU mode will be used
> +	 Say y for DMA mode
> +
> +config MTD_NAND_OMAP_PREFETCH_IRQ
> +	depends on MTD_NAND_OMAP_PREFETCH && !MTD_NAND_OMAP_PREFETCH_DMA
> +	bool "IRQ mode"
> +	default n
> +	help
> +	 The GPMC PREFETCH engine can be configured eigther in MPU interrupt mode
> +	 or in DMA interrupt mode.
> +	 Say y for IRQ mode
>  
>  config MTD_NAND_IDS
>  	tristate

The configuration to use the prefetch IRQ should be passed in the platform_data
from the board-*.c files. What if you want to to boot a distro kernel on
omap2, 3 and 4 and only some of the boards can use the prefetch interrupt?

Tony
