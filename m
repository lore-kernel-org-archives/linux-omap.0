From: Tony Lindgren <tony@atomide.com>
Subject: Re: PATCH 1/2 OMAP: HSMMC: Fix HSMMC2 getting stuck with
	suspend/resume
Date: Tue, 28 Oct 2008 09:45:19 -0700
Message-ID: <20081028164517.GG7539@atomide.com>
References: <20081021124306.GA11845@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63873 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbYJ1Qp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2008 12:45:26 -0400
Content-Disposition: inline
In-Reply-To: <20081021124306.GA11845@angel.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

Hi,

* Jarkko Lavinen <jarkko.lavinen@nokia.com> [081021 05:47]:
> HSMMC2 was stuck on a test board when resuming from
> suspend. After the resume the first command CMD0 is written to
> command register and then we wait for an interrupt. After the CMD0 
> was written, no interrupt occured. No EOC, no timeout nor other error.
> This jammed the request.
> 
> The problem was a wrong 3.0V voltage setting being applied into
> HCTL before turning SDBP bit on. After fixing the voltage to 1.8V
> suspend-resume started to work correctly.
> 
> Cheers
> Jarkko Lavinen
> 
> From 1be795080e89cca6e637f88a4e14026aee0a75e8 Mon Sep 17 00:00:00 2001
> From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Date: Mon, 20 Oct 2008 11:23:45 +0300
> Subject: [PATCH] OMAP: HSMMC: Fix HSMMC2 getting stuck with suspend/resume
> 
> Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 00b1b68..edd1ce0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1068,15 +1068,16 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
>  			}
>  
>  			if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
> -				OMAP_HSMMC_WRITE(host->base, HCTL,
> -					OMAP_HSMMC_READ(host->base, HCTL)
> -					& SDVSCLR);
> -				OMAP_HSMMC_WRITE(host->base, HCTL,
> -					OMAP_HSMMC_READ(host->base, HCTL)
> -					| SDVS30);
> -				OMAP_HSMMC_WRITE(host->base, HCTL,
> -					OMAP_HSMMC_READ(host->base, HCTL)
> -					| SDBP);
> +				u32 hctl = OMAP_HSMMC_READ(host->base, HCTL) &
> +					SDVSCLR;
> +
> +				if (host->id == OMAP_MMC1_DEVID)
> +					hctl |= SDVS30;
> +				else
> +					hctl |= SDVS18;
> +
> +				OMAP_HSMMC_WRITE(host->base, HCTL, hctl);
> +				OMAP_HSMMC_WRITE(host->base, HCTL, hctl | SDBP);
>  			}
>  
>  			clk_disable(host->fclk);

Checking the voltage based on the controller instance seems wrong to
me. I guess that should be set based on the card type?

Anyways, let's get this driver first into shape for mainline, then
get Pierre into the loop for additional features.

Regards,

Tony
