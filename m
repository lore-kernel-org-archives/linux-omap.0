From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: DMA: Fix incorrect channel linking
Date: Mon, 17 Mar 2008 18:41:11 +0200
Message-ID: <20080317164110.GB20921@atomide.com>
References: <1205766070-16752-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65024 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYCQQlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 12:41:50 -0400
Content-Disposition: inline
In-Reply-To: <1205766070-16752-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080317 17:04]:
> Function enable_lnk does incorrect channel link on non-omap1 builds if chain
> is created manually with omap_request_dma and omap_dma_link_lch functions.
> 
> Fix this by making sure that next_linked_ch field is initialized to -1 just
> in omap_request_dma.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7937406..c00eda5 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -604,6 +604,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	chan->data = data;
>  #ifndef CONFIG_ARCH_OMAP1
>  	chan->chain_id = -1;
> +	chan->next_linked_ch = -1;
>  #endif
>  	chan->enabled_irqs = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
>  
> @@ -1087,7 +1088,6 @@ int omap_request_dma_chain(int dev_id, const char *dev_name,
>  			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
>  			return err;
>  		}
> -		dma_chan[channels[i]].next_linked_ch = -1;
>  		dma_chan[channels[i]].prev_linked_ch = -1;
>  		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
>  

Pushing today.

Tony
