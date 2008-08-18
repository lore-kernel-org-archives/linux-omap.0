From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: DMA: Fix uninitialized channel flags
Date: Mon, 18 Aug 2008 15:15:05 +0300
Message-ID: <20080818121501.GB17827@atomide.com>
References: <1219051702-25944-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53730 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbYHRMP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 08:15:26 -0400
Content-Disposition: inline
In-Reply-To: <1219051702-25944-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080818 12:53]:
> This has similar symptoms than 66c23551b1b774e2be3c7bdf91c0ebf2c7a3519e
> where just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch
> can cause incorrect dump_stack(). Here it can happen if channel has been
> used before and the channel flags variable holds old status.

Pushing today.

Tony

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index a63b644..1c6b905 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -712,6 +712,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	chan->dev_name = dev_name;
>  	chan->callback = callback;
>  	chan->data = data;
> +	chan->flags = 0;
>  
>  #ifndef CONFIG_ARCH_OMAP1
>  	if (cpu_class_is_omap2()) {
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
