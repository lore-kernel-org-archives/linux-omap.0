From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 1/3] omap3-iommu: reorganize
Date: Mon, 18 May 2009 13:07:17 +0100
Message-ID: <20090518120717.GA3067@n2100.arm.linux.org.uk>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59558 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbZERMHa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 08:07:30 -0400
Content-Disposition: inline
In-Reply-To: <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, Felipe Contreras <felipe.contreras@nokia.com>

On Sat, May 16, 2009 at 01:05:48PM +0300, Felipe Contreras wrote:
> +struct iommu_device {
> +	resource_size_t base;
> +	resource_size_t irq;
> +	struct iommu_platform_data pdata;
> +	struct resource res[2];
>  };

The data which is needed per device is:

- base address
- IRQ (no need for this to be resource_size_t - int will do)
- platform data

There's no need for that res[2] being there.

> @@ -63,23 +51,35 @@ static int __init omap3_iommu_init(void)
>  
>  	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
>  		struct platform_device *pdev;
> +		const struct iommu_device *d = &devices[i];
> +		struct resource res[] = {
> +			{ .flags = IORESOURCE_MEM },
> +			{ .flags = IORESOURCE_IRQ },
> +		};

This initialization doesn't buy you anything, in fact quite the opposite.
The compiler actually interprets this as:

static struct resource __initial_res[] = {
	{ .flags = IORESOURCE_MEM },
	{ .flags = IORESOURCE_IRQ },
};
...
	for () {
		struct resource res[...];
		memcpy(res, __initial_res, sizeof(__initial_res));

> +
> +		res[0].start = d->base;
> +		res[0].end = d->base + MMU_REG_SIZE - 1;
> +
> +		res[1].start = d->irq;

It would be far better to initialize the flags element here for both.
And please also set res[1].end as I did in my patch.

> +
> +		err = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
>  		if (err)
>  			goto err_out;
> -		err = platform_device_add_data(pdev, &omap3_iommu_pdata[i],
> -					       sizeof(omap3_iommu_pdata[0]));
> +
> +		err = platform_device_add_data(pdev, &d->pdata, sizeof(d->pdata));

This will fail checkpatch.
