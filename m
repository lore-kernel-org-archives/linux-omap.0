From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 1/3] ARM:OMAP4 iommu:changes in iommu for OMAP4
Date: Fri, 24 Jul 2009 21:27:24 +0300 (EEST)
Message-ID: <20090724.212724.189704711.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD43@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64295 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbZGXS1g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 14:27:36 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD43@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, grgupta@ti.com, rmk@arm.linux.org.uk, vpasam@ti.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC][PATCH 1/3] ARM:OMAP4 iommu:changes in iommu for OMAP4
Date: Fri, 24 Jul 2009 19:22:09 +0200

> This patch has the changes to iommu module to make
> iommu functional on OMAP4 simulator. The changes
> included using stubbed clock interface and commenting
> out reading the MMU soft reset register.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/iommu2.c |    8 ++++++--
>  arch/arm/plat-omap/iommu.c   |   12 +++++++++---
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> index 015f22a..01cb15d 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -80,12 +80,16 @@ static int omap2_iommu_enable(struct iommu *obj)
>  		if (l & MMU_SYS_RESETDONE)
>  			break;
>  	} while (time_after(jiffies, timeout));
> -
> +/* FIXME: Hack till the reading the MMU status register
> + * is resolved in Simulator. Simulator doesn't update
> + * the STATUS register.
> + */
> +#ifndef CONFIG_ARCH_OMAP4
>  	if (!(l & MMU_SYS_RESETDONE)) {


What about the following?

  	if (!cpu_is_omap44xx() && !(l & MMU_SYS_RESETDONE)) {


>  		dev_err(obj->dev, "can't take mmu out of reset\n");
>  		return -ENODEV;
>  	}
> -
> +#endif
>  	l = iommu_read_reg(obj, MMU_REVISION);
>  	dev_info(obj->dev, "%s: version %d.%d\n", obj->name,
>  		 (l >> 4) & 0xf, l & 0xf);
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 4cf449f..b62a087 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -861,9 +861,15 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
>  	if (!obj)
>  		return -ENOMEM;
>  
> -	obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> -	if (IS_ERR(obj->clk))
> -		goto err_clk;
> +	/*
> +	 * FIX-ME: Replace with correct clk node when clk
> +	 * framework is available
> +	 */
> +	if (!cpu_is_omap44xx())	{
> +		obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> +		if (IS_ERR(obj->clk))
> +			goto err_clk;
> +	}
>  
>  	obj->nr_tlb_entries = pdata->nr_tlb_entries;
>  	obj->name = pdata->name;
> -- 
> 1.5.4.3
> 
> 
> Thank you,
> Best regards,
> Hari
> 
