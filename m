From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Fri, 24 Jul 2009 21:21:40 +0300 (EEST)
Message-ID: <20090724.212140.104061104.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42846 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbZGXSVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 14:21:51 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, grgupta@ti.com, rmk@arm.linux.org.uk, vpasam@ti.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Fri, 24 Jul 2009 19:22:32 +0200

> This patch adds omap4 support in iommu
> module. This creates OMAP4 platform specific file
> for iommu and defines the Ducati MMU fault interrupt.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/omap4-iommu.c      |  112 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/irqs.h |    2 +-
>  2 files changed, 113 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap4-iommu.c
> 
> diff --git a/arch/arm/mach-omap2/omap4-iommu.c b/arch/arm/mach-omap2/omap4-iommu.c
> new file mode 100644
> index 0000000..5a782df
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap4-iommu.c
> @@ -0,0 +1,112 @@
> +/*
> + * omap iommu: omap4 device registration
> + *
> + * Copyright (C) 2009-2010 Nokia Corporation
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
> +#include <mach/iommu.h>
> +#include <mach/irqs.h>
> +
> +#define OMAP4_MMU1_BASE	0x55082000
> +#define OMAP4_MMU2_BASE	0x4A066000
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
> +		.clk_name = "ducati_ick",
> +	},
> +#if defined(CONFIG_MPU_TESLA_IOMMU)
> +	{
> +		.name = "tesla",
> +		.nr_tlb_entries = 32,
> +		.clk_name = "tesla_ick",
> +	},
> +#endif
> +};

If iommu is used as a character device driver, is the above config still necessary?

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
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
> index fb7cb77..34b6d09 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -511,7 +511,7 @@
>  #define INT_44XX_TLL_IRQ	(78 + IRQ_GIC_START)
>  #define INT_44XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
>  #define INT_44XX_MMC3_IRQ	(94 + IRQ_GIC_START)
> -
> +#define INT_44XX_DUCATI_MMU_IRQ	(100 + IRQ_GIC_START)
>  
>  /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
>   * 16 MPUIO lines */
> -- 
> 1.5.4.3
> 
> 
> Thank you,
> Best regards,
> Hari
> 
