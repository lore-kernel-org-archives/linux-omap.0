From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: remove warning that clk alias
 already exists
Date: Fri, 22 Aug 2014 16:07:00 -0700
Message-ID: <20140822230700.GA17254@atomide.com>
References: <1407156844-21548-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38421 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbaHVXHL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2014 19:07:11 -0400
Content-Disposition: inline
In-Reply-To: <1407156844-21548-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, kernel@pengutronix.de

* Markus Pargmann <mpa@pengutronix.de> [140804 05:56]:
> When an alias for a clock already exists the warning is printed. For
> every module with a main_clk defined, a clk alias for fck is added.
> There are some components that have the same main_clk defined, so this
> is a really normal situation.
> 
> For example the am33xx edma device has 4 components using the same main
> clock. So there are three warnings in the boot log for this already
> existing clock alias:
> 	platform 49000000.edma: alias fck already exists
> 	platform 49000000.edma: alias fck already exists
> 	platform 49000000.edma: alias fck already exists
> 
> As this is only interesting for developers, this patch changes the
> message to a debug message.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/mach-omap2/omap_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 01ef59def44b..d22c30d3ccfa 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -56,7 +56,7 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
>  
>  	r = clk_get_sys(dev_name(&od->pdev->dev), clk_alias);
>  	if (!IS_ERR(r)) {
> -		dev_warn(&od->pdev->dev,
> +		dev_dbg(&od->pdev->dev,
>  			 "alias %s already exists\n", clk_alias);
>  		clk_put(r);
>  		return;

Thanks applying into omap-for-v3.17/fixes.

Tony
