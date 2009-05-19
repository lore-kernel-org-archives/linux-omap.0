From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] omap3-iommu: reorganize
Date: Tue, 19 May 2009 09:03:25 +0300 (EEST)
Message-ID: <20090519.090325.02296387.Hiroshi.DOYU@nokia.com>
References: <20090518.172613.116355729.Hiroshi.DOYU@nokia.com>
	<1242664980-6324-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46905 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbZESGEE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 02:04:04 -0400
In-Reply-To: <1242664980-6324-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] omap3-iommu: reorganize
Date: Mon, 18 May 2009 18:43:00 +0200

> No functional changes.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> 
> How about this?

What's the advantage of introducing a new structure here?

> 
>  arch/arm/mach-omap2/omap3-iommu.c |   53 ++++++++++++++++++-------------------
>  1 files changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
> index 91ee38a..50bd445 100644
> --- a/arch/arm/mach-omap2/omap3-iommu.c
> +++ b/arch/arm/mach-omap2/omap3-iommu.c
> @@ -14,32 +14,30 @@
>  
>  #include <mach/iommu.h>
>  
> -#define OMAP3_MMU1_BASE	0x480bd400
> -#define OMAP3_MMU2_BASE	0x5d000000
> -#define OMAP3_MMU1_IRQ	24
> -#define OMAP3_MMU2_IRQ	28
> -
> -
> -static unsigned long iommu_base[] __initdata = {
> -	OMAP3_MMU1_BASE,
> -	OMAP3_MMU2_BASE,
> -};
> -
> -static int iommu_irq[] __initdata = {
> -	OMAP3_MMU1_IRQ,
> -	OMAP3_MMU2_IRQ,
> +struct iommu_device {
> +	resource_size_t base;
> +	int irq;
> +	struct iommu_platform_data pdata;
>  };
>  
> -static const struct iommu_platform_data omap3_iommu_pdata[] __initconst = {
> +static struct iommu_device devices[] __initdata = {
>  	{
> -		.name = "isp",
> -		.nr_tlb_entries = 8,
> -		.clk_name = "cam_ick",
> +		.base = 0x480bd400,
> +		.irq = 24,
> +		.pdata = {
> +			.name = "isp",
> +			.nr_tlb_entries = 8,
> +			.clk_name = "cam_ick",
> +		},
>  	},
>  	{
> -		.name = "iva2",
> -		.nr_tlb_entries = 32,
> -		.clk_name = "iva2_ck",
> +		.base = 0x5d000000,
> +		.irq = 28,
> +		.pdata = {
> +			.name = "iva2",
> +			.nr_tlb_entries = 32,
> +			.clk_name = "iva2_ck",
> +		},
>  	},
>  };
>  #define NR_IOMMU_DEVICES ARRAY_SIZE(omap3_iommu_pdata)
> @@ -52,6 +50,7 @@ static int __init omap3_iommu_init(void)
>  
>  	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
>  		struct platform_device *pdev;
> +		const struct iommu_device *d = &devices[i];
>  		struct resource res[2];
>  
>  		pdev = platform_device_alloc("omap-iommu", i);
> @@ -60,19 +59,19 @@ static int __init omap3_iommu_init(void)
>  			goto err_out;
>  		}
>  
> -		memset(res, 0,  sizeof(res));
> -		res[0].start = iommu_base[i];
> -		res[0].end = iommu_base[i] + MMU_REG_SIZE - 1;
> +		memset(res, 0, sizeof(res));
> +		res[0].start = d->base;
> +		res[0].end = d->base + MMU_REG_SIZE - 1;
>  		res[0].flags = IORESOURCE_MEM;
> -		res[1].start = res[1].end = iommu_irq[i];
> +		res[1].start = res[1].end = d->irq;
>  		res[1].flags = IORESOURCE_IRQ;
>  
>  		err = platform_device_add_resources(pdev, res,
>  						    ARRAY_SIZE(res));
>  		if (err)
>  			goto err_out;
> -		err = platform_device_add_data(pdev, &omap3_iommu_pdata[i],
> -					       sizeof(omap3_iommu_pdata[0]));
> +		err = platform_device_add_data(pdev, &d->pdata,
> +					       sizeof(d->pdata));
>  		if (err)
>  			goto err_out;
>  		err = platform_device_add(pdev);
> -- 
> 1.6.3.1
> 
