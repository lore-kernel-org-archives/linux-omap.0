From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/2] arm: mach-omap2: omap_l3_smx: fix irq handler setup
Date: Thu, 17 Mar 2011 11:24:03 +0530
Message-ID: <997c0c456e24cd4bec71cb003fdce6f3@mail.gmail.com>
References: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com> <1300295763-497-2-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47486 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751498Ab1CQFyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 01:54:08 -0400
Received: by gyg13 with SMTP id 13so1056242gyg.38
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 22:54:07 -0700 (PDT)
In-Reply-To: <1300295763-497-2-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
> arm-kernel-bounces@lists.infradead.org] On Behalf Of Aaro Koskinen
> Sent: Wednesday, March 16, 2011 10:46 PM
> To: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; tony@atomide.com
> Cc: Aaro Koskinen
> Subject: [PATCH 2/2] arm: mach-omap2: omap_l3_smx: fix irq handler
> setup
>
> The handler function may be called from the point it is registered.
> Since the handler inspects IRQ numbers, we must set them up before
> registration.
>
Right. Thanks.

> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

>  arch/arm/mach-omap2/omap_l3_smx.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-
> omap2/omap_l3_smx.c
> index 265bff3..5f2da75 100644
> --- a/arch/arm/mach-omap2/omap_l3_smx.c
> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
> @@ -226,7 +226,6 @@ static int __init omap3_l3_probe(struct
> platform_device *pdev)
>  	struct omap3_l3         *l3;
>  	struct resource         *res;
>  	int                     ret;
> -	int                     irq;
>
>  	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
>  	if (!l3) {
> @@ -249,18 +248,17 @@ static int __init omap3_l3_probe(struct
> platform_device *pdev)
>  		goto err2;
>  	}
>
> -	irq = platform_get_irq(pdev, 0);
> -	ret = request_irq(irq, omap3_l3_app_irq,
> +	l3->debug_irq = platform_get_irq(pdev, 0);
> +	ret = request_irq(l3->debug_irq, omap3_l3_app_irq,
>  		IRQF_DISABLED | IRQF_TRIGGER_RISING,
>  		"l3-debug-irq", l3);
>  	if (ret) {
>  		dev_err(&pdev->dev, "couldn't request debug irq\n");
>  		goto err3;
>  	}
> -	l3->debug_irq = irq;
>
> -	irq = platform_get_irq(pdev, 1);
> -	ret = request_irq(irq, omap3_l3_app_irq,
> +	l3->app_irq = platform_get_irq(pdev, 1);
> +	ret = request_irq(l3->app_irq, omap3_l3_app_irq,
>  		IRQF_DISABLED | IRQF_TRIGGER_RISING,
>  		"l3-app-irq", l3);
>
> @@ -269,7 +267,6 @@ static int __init omap3_l3_probe(struct
> platform_device *pdev)
>  		goto err4;
>  	}
>
> -	l3->app_irq = irq;
>  	goto err0;
>
>  err4:
> --
> 1.5.6.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
