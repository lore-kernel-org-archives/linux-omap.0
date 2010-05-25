From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
Date: Mon, 24 May 2010 17:00:25 -0700
Message-ID: <871vd0voiu.fsf@deeprootsystems.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
	<1274549122-26521-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35200 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758689Ab0EYAA2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 20:00:28 -0400
Received: by pvg3 with SMTP id 3so276402pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 17:00:28 -0700 (PDT)
In-Reply-To: <1274549122-26521-2-git-send-email-felipe.contreras@gmail.com> (Felipe Contreras's message of "Sat\, 22 May 2010 20\:25\:21 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Only OMAP3 would work.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap2/devices.c              |  103 +++++----------------------
>  arch/arm/mach-omap2/mailbox.c              |   14 +---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   45 ++++++++++++
>  arch/arm/plat-omap/include/plat/mailbox.h  |    4 +
>  4 files changed, 72 insertions(+), 94 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index d9ac853..89f6cbc 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -20,12 +20,14 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
>  
> +#include <plat/omap_device.h>
>  #include <plat/control.h>
>  #include <plat/tc.h>
>  #include <plat/board.h>
>  #include <plat/mux.h>
>  #include <mach/gpio.h>
>  #include <plat/mmc.h>
> +#include <plat/mailbox.h>
>  
>  #include "mux.h"
>  
> @@ -137,95 +139,28 @@ static inline void omap_init_camera(void)
>  #endif
>  
>  #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
> +static inline void omap_init_mbox(void)
> +{
> +	struct omap_hwmod *hwmod;
> +	struct omap_device *odev;
> +	struct omap_mbox_platform_data pdata;
>  
> -#define MBOX_REG_SIZE   0x120
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct resource omap2_mbox_resources[] = {
> -	{
> -		.start		= OMAP24XX_MAILBOX_BASE,
> -		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -	{
> -		.start		= INT_24XX_MAIL_U0_MPU,
> -		.flags		= IORESOURCE_IRQ,
> -		.name		= "dsp",
> -	},
> -	{
> -		.start		= INT_24XX_MAIL_U3_MPU,
> -		.flags		= IORESOURCE_IRQ,
> -		.name		= "iva",
> -	},
> -};
> -static int omap2_mbox_resources_sz = ARRAY_SIZE(omap2_mbox_resources);
> -#else
> -#define omap2_mbox_resources		NULL
> -#define omap2_mbox_resources_sz		0
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct resource omap3_mbox_resources[] = {
> -	{
> -		.start		= OMAP34XX_MAILBOX_BASE,
> -		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -	{
> -		.start		= INT_24XX_MAIL_U0_MPU,
> -		.flags		= IORESOURCE_IRQ,
> -		.name		= "dsp",
> -	},
> -};
> -static int omap3_mbox_resources_sz = ARRAY_SIZE(omap3_mbox_resources);
> -#else
> -#define omap3_mbox_resources		NULL
> -#define omap3_mbox_resources_sz		0
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -
> -#define OMAP4_MBOX_REG_SIZE	0x130
> -static struct resource omap4_mbox_resources[] = {
> -	{
> -		.start          = OMAP44XX_MAILBOX_BASE,
> -		.end            = OMAP44XX_MAILBOX_BASE +
> -					OMAP4_MBOX_REG_SIZE - 1,
> -		.flags          = IORESOURCE_MEM,
> -	},
> -	{
> -		.start          = OMAP44XX_IRQ_MAIL_U0,
> -		.flags          = IORESOURCE_IRQ,
> -		.name		= "mbox",
> -	},
> -};
> -static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
> -#else
> -#define omap4_mbox_resources		NULL
> -#define omap4_mbox_resources_sz		0
> -#endif
> +	hwmod = omap_hwmod_lookup("mailbox");
> +	if (!hwmod) {
> +		pr_err("%s: unable to find hwmod\n", __func__);
> +		return;
> +	}
>  
> -static struct platform_device mbox_device = {
> -	.name		= "omap-mailbox",
> -	.id		= -1,
> -};
> +	pdata.base_addr = hwmod->_rt_va;

Shouldn't need the base address in pdata.  The driver should just do a
platform_get_resource() to get the physical address and then ioremap.

> -static inline void omap_init_mbox(void)
> -{
> -	if (cpu_is_omap24xx()) {
> -		mbox_device.resource = omap2_mbox_resources;
> -		mbox_device.num_resources = omap2_mbox_resources_sz;
> -	} else if (cpu_is_omap34xx()) {
> -		mbox_device.resource = omap3_mbox_resources;
> -		mbox_device.num_resources = omap3_mbox_resources_sz;
> -	} else if (cpu_is_omap44xx()) {
> -		mbox_device.resource = omap4_mbox_resources;
> -		mbox_device.num_resources = omap4_mbox_resources_sz;
> -	} else {
> -		pr_err("%s: platform not supported\n", __func__);
> +	odev = omap_device_build("omap-mailbox", -1, hwmod,
> +			&pdata, sizeof(pdata),
> +			NULL, 0,
> +			0);
> +	if (!odev) {
> +		pr_err("%s: could not build device\n", __func__);
>  		return;
>  	}
> -	platform_device_register(&mbox_device);
>  }
>  #else
>  static inline void omap_init_mbox(void) { }
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index d46e439..baaaa5a 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <plat/mailbox.h>
> +#include <plat/omap_hwmod.h>
>  #include <mach/irqs.h>
>  
>  #define MAILBOX_REVISION		0x000
> @@ -388,11 +389,9 @@ struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
>  
>  static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	int ret;
>  	struct omap_mbox **list;
> -
> -	res = pdev->resource;
> +	struct omap_mbox_platform_data *pdata = pdev->dev.platform_data;
>  
>  	if (false);
>  #if defined(CONFIG_ARCH_OMAP3430)
> @@ -423,15 +422,11 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
> -	if (!mbox_base)
> -		return -ENOMEM;
> +	mbox_base = pdata->base_addr;

Here is where the platform_get_resource() and ioremap should be.

>  	ret = omap_mbox_register(&pdev->dev, list);
> -	if (ret) {
> -		iounmap(mbox_base);
> +	if (ret)
>  		return ret;
> -	}
>  	return 0;
>  
>  	return ret;

[...]

Kevin
