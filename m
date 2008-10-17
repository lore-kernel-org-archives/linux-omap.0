From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] n800: usb: fix num_eps and avoid BUG()
Date: Fri, 17 Oct 2008 15:37:02 -0700
Message-ID: <20081017223702.GK18573@atomide.com>
References: <1223901345-25847-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52384 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYJQWhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 18:37:04 -0400
Content-Disposition: inline
In-Reply-To: <1223901345-25847-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [081013 09:02]:
> num_eps is 16, not 32.

Pushing.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-n800-usb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800-usb.c b/arch/arm/mach-omap2/board-n800-usb.c
> index f8df19e..fc128f2 100644
> --- a/arch/arm/mach-omap2/board-n800-usb.c
> +++ b/arch/arm/mach-omap2/board-n800-usb.c
> @@ -73,7 +73,7 @@ static struct musb_hdrc_config musb_config = {
>  	.dyn_fifo	= 1,
>  	.soft_con	= 1,
>  	.dma		= 1,
> -	.num_eps	= 32,
> +	.num_eps	= 16,
>  	.dma_channels	= 7,
>  	.ram_bits	= 12,
>  	.eps_bits	= musb_eps,
> -- 
> 1.6.0.2.307.gc427
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
