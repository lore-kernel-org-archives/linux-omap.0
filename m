From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH] MMC: OMAP: Re-organizing some goto at hsmmc probe
Date: Thu, 21 Aug 2008 18:53:22 +0530
Message-ID: <01c401c90391$15c17130$LocalHost@wipultra1303>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com> <1219072400-7814-2-git-send-email-jarkko.lavinen@nokia.com> <1219072400-7814-3-git-send-email-jarkko.lavinen@nokia.com> <1219072400-7814-4-git-send-email-jarkko.lavinen@nokia.com> <1219072400-7814-5-git-send-email-jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:46539 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbYHUNXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 09:23:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Hi Jarkko,

I am not clear what this patch is doing? Is it fixing any perticular issue?

Regards,
Madhu
----- Original Message ----- 
From: "Jarkko Lavinen" <jarkko.lavinen@nokia.com>
To: <linux-omap@vger.kernel.org>
Cc: "Jarkko Lavinen" <jarkko.lavinen@nokia.com>
Sent: Monday, August 18, 2008 8:43 PM
Subject: [PATCH] MMC: OMAP: Re-organizing some goto at hsmmc probe


> Re-organizing some goto at hsmmc probe.
> 
> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> ---
> drivers/mmc/host/omap_hsmmc.c |   20 +++++++++++---------
> 1 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index f5acf91..824e7e9 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -878,7 +878,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
>  host);
>  if (ret) {
>  dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
> - goto irq_err;
> + goto err_irq;
>  }
> 
>  /* Request IRQ for card detect */
> @@ -888,18 +888,17 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
>    host);
>  if (ret) {
>  dev_dbg(mmc_dev(host->mmc),
> - "Unable to grab MMC CD IRQ");
> - free_irq(host->irq, host);
> - goto irq_err;
> + "Unable to grab MMC CD IRQ\n");
> + goto err_irq_cd;
>  }
>  }
> 
>  INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
>  if (pdata->init != NULL) {
>  if (pdata->init(&pdev->dev) != 0) {
> - free_irq(mmc_slot(host).card_detect_irq, host);
> - free_irq(host->irq, host);
> - goto irq_err;
> + dev_dbg(mmc_dev(host->mmc),
> + "Unable to configure MMC IRQs\n");
> + goto err_irq_cd_init;
>  }
>  }
> 
> @@ -911,8 +910,11 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
> 
>  return 0;
> 
> -irq_err:
> - dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs\n");
> +err_irq_cd_init:
> + free_irq(mmc_slot(host).card_detect_irq, host);
> +err_irq_cd:
> + free_irq(host->irq, host);
> +err_irq:
>  clk_disable(host->fclk);
>  clk_disable(host->iclk);
>  clk_put(host->fclk);
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
>
