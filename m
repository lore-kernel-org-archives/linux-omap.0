From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP3EVM: cosmetic fixes for parent clk set
Date: Wed, 20 Jun 2012 11:00:28 -0500
Message-ID: <4FE1F39C.50104@ti.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com> <1340183693-3195-5-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51437 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756924Ab2FTQA2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 12:00:28 -0400
In-Reply-To: <1340183693-3195-5-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>
Cc: mike@compulab.co.il, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@ti.com, hvaibhav@ti.com, ajay.gupta@ti.com


On 06/20/2012 04:14 AM, Zumeng Chen wrote:
> Since it's no more sense to set parent for dummy clock,
> so we can just ignore it to mute failed message.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>  arch/arm/plat-omap/clock.c  |    4 ++++
>  drivers/mfd/omap-usb-host.c |    2 +-
>  2 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 62ec5c4..c7e26e4 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -149,6 +149,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>  	if (!arch_clock || !arch_clock->clk_set_parent)
>  		return ret;
>  
> +	/* If the clock is a dummy clock just return */
> +	if (clk == &dummy_ck)
> +		return 0;
> +
>  	spin_lock_irqsave(&clockfw_lock, flags);
>  	if (clk->usecount == 0) {
>  		ret = arch_clock->clk_set_parent(clk, parent);
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 7e96bb2..c9d27c4 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -699,7 +699,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>  	}
>  
>  	if (is_ehci_phy_mode(pdata->port_mode[0])) {
> -		/* for OMAP3 , the clk set paretn fails */
> +		/* for OMAP3 , the clk set parent fails */

Can't we remove this comment now with the above fix? It is no longer
relevant, right?

Cheers
Jon
