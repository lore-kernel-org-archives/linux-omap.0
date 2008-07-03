From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: hsmmc: Avoid NULL pointer dereference
Date: Thu, 3 Jul 2008 13:21:47 +0300
Message-ID: <20080703102144.GI14276@atomide.com>
References: <1214835387-11123-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50723 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYGCMMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:12:00 -0400
Content-Disposition: inline
In-Reply-To: <1214835387-11123-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080630 17:18]:
> Try if pdata provides a cleanup function pointers. For
> boards which don't provide it, driver will oops in
> omap_remove.

Pushing today.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 467f146..4dfa8dd 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -887,7 +887,8 @@ static int omap_mmc_remove(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, NULL);
>  	if (host) {
> -		host->pdata->cleanup(&pdev->dev);
> +		if (host->pdata->cleanup)
> +			host->pdata->cleanup(&pdev->dev);
>  		free_irq(host->irq, host);
>  		if (mmc_slot(host).card_detect_irq)
>  			free_irq(mmc_slot(host).card_detect_irq, host);
> -- 
> 1.5.6.49.g112db
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
