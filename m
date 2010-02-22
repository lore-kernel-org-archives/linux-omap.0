From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RESEND] [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
Date: Mon, 22 Feb 2010 17:57:10 -0600
Message-ID: <4B8319D6.8080909@ti.com>
References: <2C1563023E232C49B9F505633D57C2DA2640F2C540@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47429 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab0BVX5O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Feb 2010 18:57:14 -0500
In-Reply-To: <2C1563023E232C49B9F505633D57C2DA2640F2C540@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 2/22/2010 5:41 PM, Anna, Suman wrote:
>  From 657358cd06a3f20bef2472945991749bacef12e6 Mon Sep 17 00:00:00 2001
> From: Suman Anna<s-anna@ti.com>
> Date: Mon, 25 Jan 2010 18:27:21 -0600
> Subject: [PATCH] omap2/3/4: mailbox: remove compiler warning
>
> Remove a compiler warning in device-specific
> mailbox module.
>
> Signed-off-by: Suman Anna<s-anna@ti.com>
> ---
>   arch/arm/mach-omap2/mailbox.c |    5 ++++-
>   1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 2c9fd1c..8b5fc2a 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -419,8 +419,11 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>   #endif
>   	return 0;
>
> +#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
>   err_iva1:
> -	omap_mbox_unregister(&mbox_dsp_info);
> +	if (cpu_is_omap2420())
> +		omap_mbox_unregister(&mbox_dsp_info);
> +#endif

why not moving omap_mbox_unregister to the block containing the ifdefs? 
at least you won't be adding an ifdef and if(cpu_xx)

from mailbox.c:

> #if defined(CONFIG_ARCH_OMAP2420) /* IVA */
> 	if (cpu_is_omap2420()) {
> 		/* IVA IRQ */
> 		res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
> 		if (unlikely(!res)) {
> 			dev_err(&pdev->dev, "invalid irq resource\n");
> 			ret = -ENODEV;
> 			goto err_iva1;

this is not even needed because at this point mailbox has not been 
registered (unless i'm missing something)

> 		}
> 		mbox_iva_info.irq = res->start;
> 		ret = omap_mbox_register(&pdev->dev, &mbox_iva_info);
> 		if (ret)
> 			goto err_iva1;

this should be omap_mbox_unregister... I haven't looked to the code to 
comment if its needed to call omap_mbox_unregister when 
omap_mbox_register fails.

> 	}
> #endif

Regards,

- omar

