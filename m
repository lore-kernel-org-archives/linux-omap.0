From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: add deprecation message for legacy omap DMA API
Date: Fri, 13 Jun 2014 04:12:06 -0700
Message-ID: <20140613111206.GU17845@atomide.com>
References: <E1WvOoq-0002cL-Q0@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58667 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbaFMLMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 07:12:10 -0400
Content-Disposition: inline
In-Reply-To: <E1WvOoq-0002cL-Q0@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140613 03:36]:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/plat-omap/dma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index b5608b1f9fbd..1c98659bbf89 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -698,6 +698,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	unsigned long flags;
>  	struct omap_dma_lch *chan;
>  
> +	WARN(strcmp(dev_name, "DMA engine"), "Using deprecated platform DMA API - please update to DMA engine");
> +
>  	spin_lock_irqsave(&dma_chan_lock, flags);
>  	for (ch = 0; ch < dma_chan_count; ch++) {
>  		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
> -- 
> 1.8.3.1
> 
