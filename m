From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmci-omap: remove bogus check for host->iclk
Date: Thu, 22 Oct 2009 14:59:30 -0700
Message-ID: <20091022215930.GY16230@atomide.com>
References: <20091021125217.GB8525@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59696 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZJVV71 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 17:59:27 -0400
Content-Disposition: inline
In-Reply-To: <20091021125217.GB8525@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org

* Ladislav.Michl@seznam.cz <Ladislav.Michl@seznam.cz> [091021 03:52]:
> Remove check for host->iclk being NULL from error path since we already know
> it is non-null and use return value from clk_get.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

This too to the mmc list. Might not go in as a fix though.

Acked-by: Tony Lindgren <tony@atomide.com>

> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 5d773b8..c6d7e8e 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1459,8 +1459,10 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
>  		goto err_ioremap;
>  
>  	host->iclk = clk_get(&pdev->dev, "ick");
> -	if (IS_ERR(host->iclk))
> +	if (IS_ERR(host->iclk)) {
> +		ret = PTR_ERR(host->iclk);
>  		goto err_free_mmc_host;
> +	}
>  	clk_enable(host->iclk);
>  
>  	host->fclk = clk_get(&pdev->dev, "fck");
> @@ -1500,10 +1502,8 @@ err_free_irq:
>  err_free_fclk:
>  	clk_put(host->fclk);
>  err_free_iclk:
> -	if (host->iclk != NULL) {
> -		clk_disable(host->iclk);
> -		clk_put(host->iclk);
> -	}
> +	clk_disable(host->iclk);
> +	clk_put(host->iclk);
>  err_free_mmc_host:
>  	iounmap(host->virt_base);
>  err_ioremap:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
