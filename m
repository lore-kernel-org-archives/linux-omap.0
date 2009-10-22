From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmci-omap: free irq resource
Date: Thu, 22 Oct 2009 14:58:17 -0700
Message-ID: <20091022215817.GX16230@atomide.com>
References: <20091021124320.GA8525@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58483 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbZJVV6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 17:58:21 -0400
Content-Disposition: inline
In-Reply-To: <20091021124320.GA8525@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org

* Ladislav.Michl@seznam.cz <Ladislav.Michl@seznam.cz> [091021 03:43]:
> Free IRQ on remove.

Looks like the MAINTAINERS file is a bit out of date for
drivers/mmc/host/omap.c..

Can you please resend this fix to Andrew Morton, and Cc
Jarkko Lavinen <jarkko.lavinen@nokia.com>,
linux-mmc@vger.kernel.org and linux-omap@vger.kernel.org?

We should be able to get this in as a fix during the -rc
cycle.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 5d773b8..5f970e2 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1529,6 +1529,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
>  		host->pdata->cleanup(&pdev->dev);
>  
>  	mmc_omap_fclk_enable(host, 0);
> +	free_irq(host->irq, host);
>  	clk_put(host->fclk);
>  	clk_disable(host->iclk);
>  	clk_put(host->iclk);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
