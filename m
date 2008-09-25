From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-rc6-omap] hsmmc: request_irq says which
	controller is involved
Date: Thu, 25 Sep 2008 15:50:30 +0300
Message-ID: <20080925125029.GS5222@atomide.com>
References: <200809211416.14496.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52982 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbYIYMud (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 08:50:33 -0400
Content-Disposition: inline
In-Reply-To: <200809211416.14496.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080922 00:50]:
> Make the hsmmc driver irq requests say which controller they're
> associated with (e.g. "mmc0") so /proc/interrupts is more useful.

Pushing today.

Tony

> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -908,8 +908,8 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
>  			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
>  
>  	/* Request IRQ for MMC operations */
> -	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED, pdev->name,
> -			 host);
> +	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED,
> +			mmc_hostname(mmc), host);
>  	if (ret) {
>  		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
>  		goto err_irq;
> @@ -918,8 +918,8 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
>  	/* Request IRQ for card detect */
>  	if ((mmc_slot(host).card_detect_irq) && (mmc_slot(host).card_detect)) {
>  		ret = request_irq(mmc_slot(host).card_detect_irq,
> -				  omap_mmc_cd_handler, IRQF_DISABLED, "MMC CD",
> -				  host);
> +				  omap_mmc_cd_handler, IRQF_DISABLED,
> +				  mmc_hostname(mmc), host);
>  		if (ret) {
>  			dev_dbg(mmc_dev(host->mmc),
>  				"Unable to grab MMC CD IRQ\n");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
