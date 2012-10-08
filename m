From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP: VRFB: convert vrfb to platform device
Date: Mon, 8 Oct 2012 10:24:41 -0700
Message-ID: <20121008172440.GI3874@atomide.com>
References: <1349699429-12736-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39025 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185Ab2JHRYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 13:24:43 -0400
Content-Disposition: inline
In-Reply-To: <1349699429-12736-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121008 05:31]:
> This patch converts vrfb library into a platform device, in an effort to
> remove omap dependencies.
> 
> The platform device is registered in arch/arm/plat-omap/fb.c and
> assigned resources depending on whether running on omap2 or omap3.
> 
> The vrfb driver will parse those resources and use them to access vrfb
> configuration registers and the vrfb virtual rotation areas.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/fb.c    |   53 +++++++++++++++++++
>  drivers/video/omap2/vrfb.c |  124 +++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 157 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
> index dd6f92c..d231912 100644
> --- a/arch/arm/plat-omap/fb.c
> +++ b/arch/arm/plat-omap/fb.c
> @@ -35,6 +35,59 @@
>  
>  #include <plat/board.h>
>  
> +#if defined(CONFIG_OMAP2_VRFB)
> +static const struct resource omap2_vrfb_resources[] = {
> +	DEFINE_RES_MEM(0x68008000u, 0x40),
> +	DEFINE_RES_MEM(0x70000000u, 0x4000000),
> +	DEFINE_RES_MEM(0x74000000u, 0x4000000),
> +	DEFINE_RES_MEM(0x78000000u, 0x4000000),
> +	DEFINE_RES_MEM(0x7c000000u, 0x4000000),
> +};
> +
> +static const struct resource omap3_vrfb_resources[] = {
> +	DEFINE_RES_MEM(0x6C000180u, 0xc0),
> +	DEFINE_RES_MEM(0x70000000u, 0x4000000),
> +	DEFINE_RES_MEM(0x74000000u, 0x4000000),
> +	DEFINE_RES_MEM(0x78000000u, 0x4000000),
> +	DEFINE_RES_MEM(0x7c000000u, 0x4000000),
> +	DEFINE_RES_MEM(0xe0000000u, 0x4000000),
> +	DEFINE_RES_MEM(0xe4000000u, 0x4000000),
> +	DEFINE_RES_MEM(0xe8000000u, 0x4000000),
> +	DEFINE_RES_MEM(0xec000000u, 0x4000000),
> +	DEFINE_RES_MEM(0xf0000000u, 0x4000000),
> +	DEFINE_RES_MEM(0xf4000000u, 0x4000000),
> +	DEFINE_RES_MEM(0xf8000000u, 0x4000000),
> +	DEFINE_RES_MEM(0xfc000000u, 0x4000000),
> +};

Maybe add comments describing what these register are in case
we have a framework handling them at some point later on?

> --- a/drivers/video/omap2/vrfb.c
> +++ b/drivers/video/omap2/vrfb.c
> +#define SMS_ROT_CONTROL(context)	(0x0 + 0x10 * context)
> +#define SMS_ROT_SIZE(context)		(0x4 + 0x10 * context)
> +#define SMS_ROT_PHYSICAL_BA(context)	(0x8 + 0x10 * context)
> +#define SMS_ROT_VIRT_BASE(rot)		(0x1000000 * (rot))

Can you please also remove the old SMS defines and functions
so other code won't start tinkering with them?

> +static int __init vrfb_probe(struct platform_device *pdev)
> +{
> +	struct resource *mem;
> +	int i;
> +
> +	/* first resource is the register res, the rest are vrfb contexts */
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "can't get vrfb base address\n");
> +		return -EINVAL;
> +	}

Now that we assume vrfb is the only user of this, so you must do
request_mem_region here as that's the only protection we have.
If that fails here, then we know something is wrong.

> +	vrfb_base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
> +	if (!vrfb_base) {
> +		dev_err(&pdev->dev, "can't ioremap vrfb memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	num_ctxs = pdev->num_resources - 1;
> +
> +	ctxs = devm_kzalloc(&pdev->dev,
> +			sizeof(struct vrfb_ctx) * num_ctxs,
> +			GFP_KERNEL);
> +
> +	if (!ctxs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_ctxs; ++i) {
> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1 + i);
> +		if (!mem) {
> +			dev_err(&pdev->dev, "can't get vrfb ctx %d address\n",
> +					i);
> +			return -EINVAL;
> +		}
> +
> +		ctxs[i].base = mem->start;
> +	}

And request_mem_region must also be done for these registers to make
sure no other code is using them. Again, if it fails, something is
wrong.

Regards,

Tony
