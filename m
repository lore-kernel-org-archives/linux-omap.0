From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: dma: Correct CPU version check for
 dma_common_ch_end
Date: Wed, 22 Feb 2012 15:07:15 -0800
Message-ID: <20120222230714.GV18185@atomide.com>
References: <1329470706-29682-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43670 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab2BVXHQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 18:07:16 -0500
Content-Disposition: inline
In-Reply-To: <1329470706-29682-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120217 00:54]:
> CCDN is the last common channel register in all OMAP4 versions. Use
> cpu_is_omap44xx() instead of the cpu_is_omap4430() - which is anyway not
> doing what it supposed to do.

This is a bit unclear.. Which is not doing what is supposed to do?
DMA driver? Or one of the cpu_is_omap?

If this should be queued as a fix, then we need some kind of
description here what breaks.

Regards,

Tony
 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index a59a45a..b19d849 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -227,7 +227,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
>  
>  	dma_stride		= OMAP2_DMA_STRIDE;
>  	dma_common_ch_start	= CSDP;
> -	if (cpu_is_omap3630() || cpu_is_omap4430())
> +	if (cpu_is_omap3630() || cpu_is_omap44xx())
>  		dma_common_ch_end = CCDN;
>  	else
>  		dma_common_ch_end = CCFN;
> -- 
> 1.7.8.4
> 
