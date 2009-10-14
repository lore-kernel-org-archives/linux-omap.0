From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: SDMA: Fix omap_stop_dma() API for channel
	linking
Date: Wed, 14 Oct 2009 10:06:26 -0700
Message-ID: <20091014170625.GH12700@atomide.com>
References: <1255500862-29847-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61655 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbZJNRHK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 13:07:10 -0400
Content-Disposition: inline
In-Reply-To: <1255500862-29847-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [091013 23:14]:
> OMAP sDMA driver API omap_stop_dma() doesn't really stop the dma when used
> in linking scenario. This patch fixes the same.

To me it looks like this will break things for omap1 as the DMA channel
interrupt is not disabled first. I guess the fix is to move the 
"Disable all interrupts on the channel" part above clearing the
link mappings.

This fix should be tested in linux-omap before we send this to mainline.

Tony
 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> CC: Hari n <hari.zoom@gmail.com>
> CC: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  arch/arm/plat-omap/dma.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index fd3154a..633c123 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -975,6 +975,11 @@ void omap_stop_dma(int lch)
>  {
>  	u32 l;
>  
> +	/* Disable the DMA channel */
> +	l = dma_read(CCR(lch));
> +	l &= ~OMAP_DMA_CCR_EN;
> +	dma_write(l, CCR(lch));
> +
>  	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
>  		int next_lch, cur_lch = lch;
>  		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
> @@ -1000,10 +1005,6 @@ void omap_stop_dma(int lch)
>  	if (cpu_class_is_omap1())
>  		dma_write(0, CICR(lch));
>  
> -	l = dma_read(CCR(lch));
> -	l &= ~OMAP_DMA_CCR_EN;
> -	dma_write(l, CCR(lch));
> -
>  	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
>  }
>  EXPORT_SYMBOL(omap_stop_dma);
> -- 
> 1.5.4.7
> 
