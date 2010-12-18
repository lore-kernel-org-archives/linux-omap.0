From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] omap3: nand: configurable transfer type per board
Date: Fri, 17 Dec 2010 16:08:46 -0800
Message-ID: <20101218000845.GW5941@atomide.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
 <1290785677-16005-3-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61785 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab0LRAIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 19:08:51 -0500
Content-Disposition: inline
In-Reply-To: <1290785677-16005-3-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [101126 07:25]:
> nand transfer type (sDMA, Polled, prefetch) can be select from board file,
> enabling all transfer type in driver, by default.
> 
> this helps in multi-omap build and to select different transfer type for
> different board.
> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/nand.h |    7 +++
>  drivers/mtd/nand/Kconfig               |   17 ------
>  drivers/mtd/nand/omap2.c               |   92 +++++++++++--------------------
>  3 files changed, 40 insertions(+), 76 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
> index 6562cd0..78c0bdb 100644
> --- a/arch/arm/plat-omap/include/plat/nand.h
> +++ b/arch/arm/plat-omap/include/plat/nand.h
> @@ -10,6 +10,12 @@
>  
>  #include <linux/mtd/partitions.h>
>  
> +enum nand_io {
> +	NAND_OMAP_PREFETCH_POLLED = 0,	/* prefetch polled mode, default */
> +	NAND_OMAP_POLLED,		/* polled mode, without prefetch */
> +	NAND_OMAP_PREFETCH_DMA		/* prefetch enabled sDMA mode */
> +};
> +
>  struct omap_nand_platform_data {
>  	unsigned int		options;
>  	int			cs;
> @@ -20,6 +26,7 @@ struct omap_nand_platform_data {
>  	int			(*nand_setup)(void);
>  	int			(*dev_ready)(struct omap_nand_platform_data *);
>  	int			dma_channel;
> +	enum nand_io		xfer_type;
>  	unsigned long		phys_base;
>  	int			devsize;
>  };

So maybe the devsize in patch 1/7 should be handled with this too?

Regards,

Tony
