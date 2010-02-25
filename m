From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5 v2] omap2/3/4: mailbox: remove compiler warning
Date: Thu, 25 Feb 2010 14:34:14 -0800
Message-ID: <20100225223413.GP28173@atomide.com>
References: <2C1563023E232C49B9F505633D57C2DA2640F2CA32@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50988 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934273Ab0BYWdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 17:33:13 -0500
Content-Disposition: inline
In-Reply-To: <2C1563023E232C49B9F505633D57C2DA2640F2CA32@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

* Anna, Suman <s-anna@ti.com> [100223 07:57]:
> From 02c45559105c62343e31226fe67117231ea10c35 Mon Sep 17 00:00:00 2001
> From: Suman Anna <s-anna@ti.com>
> Date: Mon, 25 Jan 2010 18:27:21 -0600
> Subject: [PATCH] omap2/3/4: mailbox: remove compiler warning
> 
> Remove a compiler warning in device-specific
> mailbox module.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Hiroshi, do you want me to queue this? If so, please respond
with your ack.

Tony

> ---
>  arch/arm/mach-omap2/mailbox.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 2c9fd1c..a732664 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -409,19 +409,19 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  		if (unlikely(!res)) {
>  			dev_err(&pdev->dev, "invalid irq resource\n");
>  			ret = -ENODEV;
> -			goto err_iva1;
> +			omap_mbox_unregister(&mbox_dsp_info);
> +			goto err_dsp;
>  		}
>  		mbox_iva_info.irq = res->start;
>  		ret = omap_mbox_register(&pdev->dev, &mbox_iva_info);
> -		if (ret)
> -			goto err_iva1;
> +		if (ret) {
> +			omap_mbox_unregister(&mbox_dsp_info);
> +			goto err_dsp;
> +		}
>  	}
>  #endif
>  	return 0;
>  
> -err_iva1:
> -	omap_mbox_unregister(&mbox_dsp_info);
> -
>  err_dsp:
>  	iounmap(mbox_base);
>  	return ret;
> -- 
> 1.6.6.2
