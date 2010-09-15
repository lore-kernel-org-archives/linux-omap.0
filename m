From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] nand/omap2: fix compile error with DMA Config
Date: Wed, 15 Sep 2010 10:37:11 -0700
Message-ID: <20100915173710.GA4174@atomide.com>
References: <1284153862-26332-1-git-send-email-cbrake@bec-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57839 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab0IORhO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 13:37:14 -0400
Content-Disposition: inline
In-Reply-To: <1284153862-26332-1-git-send-email-cbrake@bec-systems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cbrake@bec-systems.com>
Cc: linux-omap@vger.kernel.org

* Cliff Brake <cbrake@bec-systems.com> [100910 14:46]:
> With CONFIG_MTD_NAND_OMAP_PREFETCH_DMA, there is a compile
> error that this patch fixes.

This should go via linux-mtd, can you please repost?

Regards,

Tony
 
> Signed-off-by: Cliff Brake <cbrake@bec-systems.com>
> ---
>  drivers/mtd/nand/omap2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 133d515..513e0a7 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -413,7 +413,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
>  		prefetch_status = gpmc_read_status(GPMC_PREFETCH_COUNT);
>  	} while (prefetch_status);
>  	/* disable and stop the PFPW engine */
> -	gpmc_prefetch_reset();
> +	gpmc_prefetch_reset(info->gpmc_cs);
>  
>  	dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
>  	return 0;
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
