From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers when
	resuming
Date: Mon, 2 Mar 2009 08:44:14 -0800
Message-ID: <20090302164413.GB11864@atomide.com>
References: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com> <200902231023.49653.david-b@pacbell.net> <49A3EF96.3090603@nokia.com> <200902241410.19132.david-b@pacbell.net> <20090227220812.GM11594@atomide.com> <49ABD098.8080108@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62240 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbZCBQoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 11:44:30 -0500
Content-Disposition: inline
In-Reply-To: <49ABD098.8080108@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, Kyungmin Park <kyungmin.park@samsung.com>, Kim Kyuwon <chammoru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "drzeus-mmc@drzeus.cx" <drzeus-mmc@drzeus.cx>, =?utf-8?B?77+977+977+91L/vv70=?= <q1.kim@samsung.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>

* Adrian Hunter <adrian.hunter@nokia.com> [090302 04:27]:
> From a2ad80abeb9550782d4962472980e47df4055434 Mon Sep 17 00:00:00 2001
> From: Kim Kyuwon <chammoru@gmail.com>
> Date: Fri, 20 Feb 2009 13:10:08 +0100
> Subject: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers when resuming
>
> Most registers lose its state when the processor wakes up from sleep state.
> Thus registers should be initialized, when the processor wakes up. However the
> current hsmmc 'resume' function doesn't consider this issue and finally makes
> deadlock. So this patch fixes this problem.
>
> Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
> Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>

Sounds like there's no rush to get this into mainline until during the
next merge window as we're still missing most of the 24xx and 34xx PM code.

Acked-by: Tony Lindgren <tony@atomide.com>


> ---
>
>
>
>
> Here is Kim Kyuwon's patch without the 'host is never null in suspend / resume'
> assumption, and leaving the issue of SDBP for later.
>
>
>
>
>
>
> drivers/mmc/host/omap_hsmmc.c |   55 +++++++++++++++++++++++-----------------
> 1 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index a631c81..1047cb5 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -56,6 +56,7 @@
> #define SDVS18			(0x5 << 9)
> #define SDVS30			(0x6 << 9)
> #define SDVS33			(0x7 << 9)
> +#define SDVS_MASK		0x00000E00
> #define SDVSCLR			0xFFFFF1FF
> #define SDVSDET			0x00000400
> #define AUTOIDLE		0x1
> @@ -891,6 +892,34 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
> 	return pdata->slots[0].get_ro(host->dev, 0);
> }
>
> +static void omap_hsmmc_init(struct mmc_omap_host *host)
> +{
> +	u32 hctl, capa, value;
> +
> +	/* Only MMC1 supports 3.0V */
> +	if (host->id == OMAP_MMC1_DEVID) {
> +		hctl = SDVS30;
> +		capa = VS30 | VS18;
> +	} else {
> +		hctl = SDVS18;
> +		capa = VS18;
> +	}
> +
> +	value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
> +	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
> +
> +	value = OMAP_HSMMC_READ(host->base, CAPA);
> +	OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);
> +
> +	/* Set the controller to AUTO IDLE mode */
> +	value = OMAP_HSMMC_READ(host->base, SYSCONFIG);
> +	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, value | AUTOIDLE);
> +
> +	/* Set SD bus power bit */
> +	value = OMAP_HSMMC_READ(host->base, HCTL);
> +	OMAP_HSMMC_WRITE(host->base, HCTL, value | SDBP);
> +}
> +
> static struct mmc_host_ops mmc_omap_ops = {
> 	.request = omap_mmc_request,
> 	.set_ios = omap_mmc_set_ios,
> @@ -906,7 +935,6 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
> 	struct mmc_omap_host *host = NULL;
> 	struct resource *res;
> 	int ret = 0, irq;
> -	u32 hctl, capa;
>
> 	if (pdata == NULL) {
> 		dev_err(&pdev->dev, "Platform Data is missing\n");
> @@ -1011,28 +1039,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
> 	if (pdata->slots[host->slot_id].wires >= 4)
> 		mmc->caps |= MMC_CAP_4_BIT_DATA;
>
> -	/* Only MMC1 supports 3.0V */
> -	if (host->id == OMAP_MMC1_DEVID) {
> -		hctl = SDVS30;
> -		capa = VS30 | VS18;
> -	} else {
> -		hctl = SDVS18;
> -		capa = VS18;
> -	}
> -
> -	OMAP_HSMMC_WRITE(host->base, HCTL,
> -			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
> -
> -	OMAP_HSMMC_WRITE(host->base, CAPA,
> -			OMAP_HSMMC_READ(host->base, CAPA) | capa);
> -
> -	/* Set the controller to AUTO IDLE mode */
> -	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
> -			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
> -
> -	/* Set SD bus power bit */
> -	OMAP_HSMMC_WRITE(host->base, HCTL,
> -			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
> +	omap_hsmmc_init(host);
>
> 	/* Request IRQ for MMC operations */
> 	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED,
> @@ -1222,6 +1229,8 @@ static int omap_mmc_resume(struct platform_device *pdev)
> 			dev_dbg(mmc_dev(host->mmc),
> 					"Enabling debounce clk failed\n");
>
> +		omap_hsmmc_init(host);
> +
> 		if (host->pdata->resume) {
> 			ret = host->pdata->resume(&pdev->dev, host->slot_id);
> 			if (ret)
> -- 
> 1.5.6.3
