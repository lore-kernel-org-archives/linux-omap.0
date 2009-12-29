From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Remove set_clock for usb-musb.c
Date: Tue, 29 Dec 2009 11:35:38 -0800
Message-ID: <20091229193537.GC3512@atomide.com>
References: <20091229193103.GB3512@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52701 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZL2Tfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 14:35:41 -0500
Content-Disposition: inline
In-Reply-To: <20091229193103.GB3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [091229 11:29]:
> Felipe, can you take a look at this patch? To me it seems
> like it should be now OK to get rid of set_clock.

Heh, never mind, looks like you already did the same patch earlier :)

Tony
 

> From 58c67fd38d9aa65cf35550f7b0e8c279d86afefe Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 29 Dec 2009 11:26:45 -0800
> Subject: [PATCH] omap: Remove set_clock for usb-musb.c
> 
> This is no longer needed because of clkdev. We are
> already using clk_enable/disable directly in musb_core.c
> if set_clock is NULL.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index a80441d..74c40ab 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -47,27 +47,6 @@ static struct resource musb_resources[] = {
>  	},
>  };
>  
> -static int clk_on;
> -
> -static int musb_set_clock(struct clk *clk, int state)
> -{
> -	if (state) {
> -		if (clk_on > 0)
> -			return -ENODEV;
> -
> -		clk_enable(clk);
> -		clk_on = 1;
> -	} else {
> -		if (clk_on == 0)
> -			return -ENODEV;
> -
> -		clk_disable(clk);
> -		clk_on = 0;
> -	}
> -
> -	return 0;
> -}
> -
>  static struct musb_hdrc_eps_bits musb_eps[] = {
>  	{	"ep1_tx", 10,	},
>  	{	"ep1_rx", 10,	},
> @@ -121,8 +100,6 @@ static struct musb_hdrc_platform_data musb_plat = {
>  #elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>  	.mode		= MUSB_PERIPHERAL,
>  #endif
> -	/* .clock is set dynamically */
> -	.set_clock	= musb_set_clock,
>  	.config		= &musb_config,
>  
>  	/* REVISIT charge pump on TWL4030 can supply up to

