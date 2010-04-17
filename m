From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM:iommu support for OMAP4
Date: Sat, 17 Apr 2010 10:06:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4F16550@dbde02.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B216AE2@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48782 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab0DQEgn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Apr 2010 00:36:43 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B216AE2@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Kanigeri, Hari
> Sent: Friday, April 16, 2010 9:47 PM
> To: linux-omap@vger.kernel.org
> Cc: Doyu Hiroshi (Nokia-D/Helsinki); Shilimkar, Santosh; tony@atomide.com
> Subject: [PATCH] ARM:iommu support for OMAP4
> 
> From 708914e1a82a608d423b050cb31b4deb46eb8411 Mon Sep 17 00:00:00 2001
> From: Hari Kanigeri <h-kanigeri2@ti.com>
> Date: Mon, 8 Mar 2010 17:55:21 -0600
> Subject: [PATCH] ARM:iommu support for OMAP4
> 
> This patch provides the iommu support for OMAP4 co-processors.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile      |    2 +-
>  arch/arm/mach-omap2/omap4-iommu.c |  110 +++++++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/iommu.c        |   10 ++-
>  3 files changed, 117 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap4-iommu.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index d3e54da..1395125 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -77,7 +77,7 @@ mailbox_mach-objs			:= mailbox.o
> 
>  iommu-y					+= iommu2.o
>  iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
> -
> +iommu-$(CONFIG_ARCH_OMAP4)              += omap4-iommu.o
>  obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
> 
>  i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
> diff --git a/arch/arm/mach-omap2/omap4-iommu.c b/arch/arm/mach-omap2/omap4-iommu.c
> new file mode 100644
> index 0000000..6225616
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap4-iommu.c
> @@ -0,0 +1,110 @@
> +/*
> + * omap iommu: omap4 device registration
> + *
> + * Copyright (C) 2009-2010 Nokia Corporation

You should Add TI copyrights as well here
> + *
> + * Written by Hari Kanigeri <h-kanigeri2@ti.com>
> + *
> + * Added support for OMAP4. This is based on original file
> + * omap3-iommu.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/platform_device.h>
> +
> +#include <plat/iommu.h>
> +#include <plat/irqs.h>
> +
> +#define OMAP4_MMU1_BASE	0x55082000
> +#define OMAP4_MMU2_BASE	0x4A066000

Can you move these base definitions to plat/omap44xx.h and use
them directly.

> +
> +#define OMAP4_MMU1_IRQ	INT_44XX_DUCATI_MMU_IRQ
> +#define OMAP4_MMU2_IRQ	INT_44XX_DSP_MMU
> +
> +
> +
> +static unsigned long iommu_base[] __initdata = {
> +	OMAP4_MMU1_BASE,
> +	OMAP4_MMU2_BASE,
> +};
> +
> +static int iommu_irq[] __initdata = {
> +	OMAP4_MMU1_IRQ,
> +	OMAP4_MMU2_IRQ,
> +};
> +
> +static const struct iommu_platform_data omap4_iommu_pdata[] __initconst = {
> +	{
> +		.name = "ducati",
> +		.nr_tlb_entries = 32,
> +	},
> +#if defined(CONFIG_MPU_TESLA_IOMMU)
> +	{
> +		.name = "tesla",
> +		.nr_tlb_entries = 32,
> +	},
> +#endif
> +};
> +#define NR_IOMMU_DEVICES ARRAY_SIZE(omap4_iommu_pdata)
> +
> +static struct platform_device *omap4_iommu_pdev[NR_IOMMU_DEVICES];
> +
> +static int __init omap4_iommu_init(void)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
> +		struct platform_device *pdev;
> +		struct resource res[2];
> +
> +		pdev = platform_device_alloc("omap-iommu", i);
> +		if (!pdev) {
> +			err = -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		memset(res, 0,  sizeof(res));
> +		res[0].start = iommu_base[i];
> +		res[0].end = iommu_base[i] + MMU_REG_SIZE - 1;
> +		res[0].flags = IORESOURCE_MEM;
> +		res[1].start = res[1].end = iommu_irq[i];
> +		res[1].flags = IORESOURCE_IRQ;
> +
> +		err = platform_device_add_resources(pdev, res,
> +						    ARRAY_SIZE(res));
> +		if (err)
> +			goto err_out;
> +		err = platform_device_add_data(pdev, &omap4_iommu_pdata[i],
> +					       sizeof(omap4_iommu_pdata[0]));
> +		if (err)
> +			goto err_out;
> +		err = platform_device_add(pdev);
> +		if (err)
> +			goto err_out;
> +		omap4_iommu_pdev[i] = pdev;
> +	}
> +	return 0;
> +
> +err_out:
> +	while (i--)
> +		platform_device_put(omap4_iommu_pdev[i]);
> +	return err;
> +}
> +module_init(omap4_iommu_init);
> +
> +static void __exit omap4_iommu_exit(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < NR_IOMMU_DEVICES; i++)
> +		platform_device_unregister(omap4_iommu_pdev[i]);
> +}
> +module_exit(omap4_iommu_exit);
> +
> +MODULE_AUTHOR("Hiroshi DOYU, Hari Kanigeri");
> +MODULE_DESCRIPTION("omap iommu: omap4 device registration");
> +MODULE_LICENSE("GPL v2");
> +
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 905ed83..5186728 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -862,10 +862,12 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
>  	if (!obj)
>  		return -ENOMEM;
> 
> -	obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> -	if (IS_ERR(obj->clk))
> -		goto err_clk;
> -
> +	/* FIX ME: OMAP4 PM framework not ready */
This is not true any more. Have you tried removing this check ??

> +	if (!cpu_is_omap44xx()) {
> +		obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> +		if (IS_ERR(obj->clk))
> +			goto err_clk;
> +	}
>  	obj->nr_tlb_entries = pdata->nr_tlb_entries;
>  	obj->name = pdata->name;
>  	obj->dev = &pdev->dev;
> --
> 1.7.0
> 
> 
> Thank you,
> Best regards,
> Hari

