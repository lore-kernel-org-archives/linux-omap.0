From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 16 May 2009 10:20:36 +0100
Message-ID: <20090516092036.GD15328@n2100.arm.linux.org.uk>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com> <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54523 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbZEPJUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:20:45 -0400
Content-Disposition: inline
In-Reply-To: <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Tue, May 05, 2009 at 03:47:00PM +0300, Hiroshi DOYU wrote:
> +static struct resource omap3_iommu_res[] = {
> +	{ /* Camera ISP MMU */
> +		.start		= OMAP3_MMU1_BASE,
> +		.end		= OMAP3_MMU1_BASE + MMU_REG_SIZE - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP3_MMU1_IRQ,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +	{ /* IVA2.2 MMU */
> +		.start		= OMAP3_MMU2_BASE,
> +		.end		= OMAP3_MMU2_BASE + MMU_REG_SIZE - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP3_MMU2_IRQ,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)

This looks all very convoluted.  Why not do something like:

static unsigned long iommu_base[] = {
	OMAP3_MMU1_BASE,
	OMAP3_MMU2_BASE,
};

static int iommu_irq[] = {
	OMAP3_MMU1_IRQ,
	OMAP3_MMU2_IRQ,
};

> +static struct platform_device *omap3_iommu_pdev[NR_IOMMU_DEVICES];
> +
> +static int __init omap3_iommu_init(void)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("omap-iommu", i + 1);

Why number them 1 and up when zero is perfectly fine?

> +		if (!pdev) {
> +			err = -ENOMEM;
> +			goto err_out;
> +		}
> +		err = platform_device_add_resources(pdev,
> +				    &omap3_iommu_res[2 * i], NR_IOMMU_RES);

		struct resource res[2];

		res[0].start = iommu_base[i];
		res[0].end = iommu_base[i] + MMU_REG_SIZE - 1;
		res[0].flags = IORESOURCE_MEM;
		res[1].start = res[1].end = iommu_irq[i];
		res[1].flags = IORESOURCE_IRQ;

		err = platform_device_add_resources(pdev, &res, ARRAY_SIZE(res));

There's no need to keep 'res' around since it's copied by add_resources.

> +		if (err)
> +			goto err_out;
> +		err = platform_device_add_data(pdev, &omap3_iommu_pdata[i],
> +					       sizeof(omap3_iommu_pdata[0]));
> +		if (err)
> +			goto err_out;
> +		err = platform_device_add(pdev);
> +		if (err)
> +			goto err_out;
> +		omap3_iommu_pdev[i] = pdev;
> +	}
> +	return 0;
> +
> +err_out:
> +	while (i--)
> +		platform_device_put(omap3_iommu_pdev[i]);
> +	return err;
> +}
> +module_init(omap3_iommu_init);
> +
> +static void __exit omap3_iommu_exit(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < NR_IOMMU_DEVICES; i++)
> +		platform_device_unregister(omap3_iommu_pdev[i]);
> +}
> +module_exit(omap3_iommu_exit);
> +
> +MODULE_AUTHOR("Hiroshi DOYU");
> +MODULE_DESCRIPTION("omap iommu: omap3 device registration");
> +MODULE_LICENSE("GPL v2");
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
