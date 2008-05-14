From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: DMA: Don't mark channel active in
	omap_enable_channel_irq
Date: Wed, 14 May 2008 15:26:46 -0700
Message-ID: <20080514222646.GD8928@atomide.com>
References: <1210674363-23309-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59339 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbYENW0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 18:26:46 -0400
Content-Disposition: inline
In-Reply-To: <1210674363-23309-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080513 03:26]:
> Channel should be marked active only when DMA is really started. Otherwise
> just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch will cause
> incorrect dump_stack().
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index c00eda5..39c637b 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -501,8 +501,6 @@ static inline void omap_enable_channel_irq(int lch)
>  
>  	/* Enable some nice interrupts. */
>  	OMAP_DMA_CICR_REG(lch) = dma_chan[lch].enabled_irqs;
> -
> -	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
>  }
>  
>  static void omap_disable_channel_irq(int lch)

Pushing today.

Tony
