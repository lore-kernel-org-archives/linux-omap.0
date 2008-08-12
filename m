From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] HSMMC: Fix omap_hsmmc.c compilation
Date: Tue, 12 Aug 2008 14:04:25 +0300
Message-ID: <20080812110424.GC6705@atomide.com>
References: <alpine.DEB.1.00.0808111136300.10219@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54080 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbYHLLCO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 07:02:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808111136300.10219@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, madhu.cr@ti.com

* Paul Walmsley <paul@pwsan.com> [080811 20:39]:
> 
> Fix asm/semaphore.h to be linux/semaphore.h; also remove 
> MMC_CAP_MULTIWRITE per 23af60398af2f5033e2f53665538a09f498dbc03.

Pushing today.

Tony

> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: <madhu.cr@ti.com>
> 
> ---
> 
>  drivers/mmc/host/omap_hsmmc.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1ff51b7..7a6586f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -26,7 +26,7 @@
>  #include <linux/clk.h>
>  #include <linux/mmc/host.h>
>  #include <linux/io.h>
> -#include <asm/semaphore.h>
> +#include <linux/semaphore.h>
>  #include <asm/dma.h>
>  #include <asm/hardware.h>
>  #include <asm/arch/board.h>
> @@ -810,8 +810,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
>  	mmc->max_seg_size = mmc->max_req_size;
>  
>  	mmc->ocr_avail = mmc_slot(host).ocr_mask;
> -	mmc->caps |= MMC_CAP_MULTIWRITE | MMC_CAP_MMC_HIGHSPEED |
> -				MMC_CAP_SD_HIGHSPEED;
> +	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
>  
>  	if (pdata->conf.wire4)
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
