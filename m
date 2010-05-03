From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC/PATCH 6/8] omap: mailbox: more more stuff to
 omap2_mbox_init
Date: Mon, 3 May 2010 08:42:38 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B79179A@dlee03.ent.ti.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
 <1272844967-25441-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46279 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755978Ab0ECNmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 09:42:44 -0400
In-Reply-To: <1272844967-25441-2-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Felipe,

Small suggestion...if we are re-organizing can we make it look similar to how iommu is structured? This way we can maintain consistency. 


Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Contreras
> Sent: Sunday, May 02, 2010 7:03 PM
> To: linux-omap
> Cc: Tony Lindgren; Hiroshi Doyu; Ohad Ben-Cohen; Felipe Contreras
> Subject: [RFC/PATCH 6/8] omap: mailbox: more more stuff to omap2_mbox_init
> 
> Will be needed to split the platform_driver.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |   49 ++++++++++++++++++------------------
> ----
>  1 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index e9a803c..474c1e7 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -418,31 +418,6 @@ static int __devinit omap2_mbox_probe(struct
> platform_device *pdev)
> 
>  	res = pdev->resource;
> 
> -	mbox_base = ioremap(res->start, resource_size(res));
> -	if (!mbox_base)
> -		return -ENOMEM;
> -
> -	if (cpu_is_omap3430()) {
> -		list.num = ARRAY_SIZE(omap3_mboxes);
> -		list.mbox = omap3_mboxes;
> -
> -		list.mbox[0]->irq = res[1].start;
> -	}
> -	else if (cpu_is_omap2420()) {
> -		list.num = ARRAY_SIZE(omap2_mboxes);
> -		list.mbox = omap2_mboxes;
> -
> -		list.mbox[0]->irq = res[1].start;
> -		list.mbox[1]->irq = res[2].start;
> -	}
> -	else if (cpu_is_omap44xx()) {
> -		list.num = ARRAY_SIZE(omap4_mboxes);
> -		list.mbox = omap4_mboxes;
> -
> -		list.mbox[0]->irq = res[1].start;
> -		list.mbox[1]->irq = res[1].start;
> -	}
> -
>  	for (i = 0; i < list.num; i++) {
>  		struct omap_mbox *mbox = list.mbox[i];
>  		ret = omap_mbox_register(&pdev->dev, mbox);
> @@ -454,7 +429,6 @@ static int __devinit omap2_mbox_probe(struct
> platform_device *pdev)
>  err_out:
>  	while (i--)
>  		omap_mbox_unregister(list.mbox[i]);
> -	iounmap(mbox_base);
>  	return ret;
>  }
> 
> @@ -465,7 +439,6 @@ static int __devexit omap2_mbox_remove(struct
> platform_device *pdev)
>  	for (i = 0; i < list.num; i++)
>  		omap_mbox_unregister(list.mbox[i]);
> 
> -	iounmap(mbox_base);
>  	return 0;
>  }
> 
> @@ -483,18 +456,33 @@ static int __init omap2_mbox_init(void)
>  	struct platform_device *pdev;
>  	struct resource *res;
>  	unsigned num;
> +	struct omap_mbox_list list;
> 
>  	if (cpu_is_omap3430()) {
>  		res = omap3_mbox_resources;
>  		num = ARRAY_SIZE(omap3_mbox_resources);
> +		list.num = ARRAY_SIZE(omap3_mboxes);
> +		list.mbox = omap3_mboxes;
> +
> +		list.mbox[0]->irq = res[1].start;
>  	}
>  	else if (cpu_is_omap2420()) {
>  		res = omap2_mbox_resources;
>  		num = ARRAY_SIZE(omap2_mbox_resources);
> +		list.num = ARRAY_SIZE(omap2_mboxes);
> +		list.mbox = omap2_mboxes;
> +
> +		list.mbox[0]->irq = res[1].start;
> +		list.mbox[1]->irq = res[2].start;
>  	}
>  	else if (cpu_is_omap44xx()) {
>  		res = omap4_mbox_resources;
>  		num = ARRAY_SIZE(omap4_mbox_resources);
> +		list.num = ARRAY_SIZE(omap4_mboxes);
> +		list.mbox = omap4_mboxes;
> +
> +		list.mbox[0]->irq = res[1].start;
> +		list.mbox[1]->irq = res[1].start;
>  	}
>  	else {
>  		pr_err("%s: platform not supported\n", __func__);
> @@ -515,6 +503,12 @@ static int __init omap2_mbox_init(void)
>  	if (err)
>  		goto err_out;
> 
> +	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
> +	if (!mbox_base) {
> +		platform_device_put(pdev);
> +		return -ENOMEM;
> +	}
> +
>  	return platform_driver_register(&omap2_mbox_driver);
> 
>  err_out:
> @@ -524,6 +518,7 @@ err_out:
>  static void __exit omap2_mbox_exit(void)
>  {
>  	platform_driver_unregister(&omap2_mbox_driver);
> +	iounmap(mbox_base);
>  }
> 
>  module_init(omap2_mbox_init);
> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
