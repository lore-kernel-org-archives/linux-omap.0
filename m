From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 17 Jan 2009 16:21:39 +0000
Message-ID: <20090117162139.GB12341@n2100.arm.linux.org.uk>
References: <20090116083003.18344.38307.stgit@oreo.research.nokia.com> <20090116083719.18344.28959.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58323 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763170AbZAQQVw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2009 11:21:52 -0500
Content-Disposition: inline
In-Reply-To: <20090116083719.18344.28959.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jan 16, 2009 at 10:37:20AM +0200, Hiroshi DOYU wrote:
> +#include <linux/io.h>

Is linux/io.h needed, or will a more specific include be better?

> +#include <linux/platform_device.h>
> +
> +#include <mach/iommu.h>
> +
> +#define DEVNAME "omap-iommu"

I'm not sure this DEVNAME definition really helps anything.

> +static void omap3_iommu_release(struct device *dev)
> +{
> +}

Err, no.  Never ever ever provide a NULL release function.  Providing
such a function is a screaming message that what you're doing is buggy.

And if you get a warning through not providing such a function, it's
telling you that what your overall approach with the driver API is
buggy (and you haven't understood the implications of refcounted
object management.)

> +
> +static struct platform_device omap3_iommu_pdev[] = {
> +	{
> +		.name		= DEVNAME,
> +		.id		= 1,
> +		.num_resources	= ARRAY_SIZE(iommu1_res),
> +		.resource	= iommu1_res,
> +		.dev		= {
> +			.release = omap3_iommu_release,
> +			.platform_data = &omap3_iommu_pdata[0],
> +		},
> +	},
> +	{
> +		.name		= DEVNAME,
> +		.id		= 2,
> +		.num_resources	= ARRAY_SIZE(iommu2_res),
> +		.resource	= iommu2_res,
> +		.dev		= {
> +			.release = omap3_iommu_release,
> +			.platform_data = &omap3_iommu_pdata[1],
> +		},
> +	},
> +};
> +
> +static int __init omap3_iommu_init(void)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(omap3_iommu_pdev); i++)
> +		platform_device_register(&omap3_iommu_pdev[i]);
> +	return 0;
> +}
> +module_init(omap3_iommu_init);
> +
> +static void __exit omap3_iommu_exit(void)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(omap3_iommu_pdev); i++)
> +		platform_device_unregister(&omap3_iommu_pdev[i]);

So... this can never be bug free - you can _never_ unregister statically
allocated devices.  Not even if you provide an empty release function.

If you want to register and unregister device structures, it must be
done using the correct APIs, and in the case of platform devices, that's
the platform_device_alloc(), platform_device_add() and
platform_device_unregister() APIs.
