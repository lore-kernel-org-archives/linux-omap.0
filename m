From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/5] omap iommu: Reject unaligned physical address at
 setting page table entry
Date: Fri, 7 May 2010 06:45:14 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B91FCB1@dlee03.ent.ti.com>
References: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36355 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab0EGLpV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 07:45:21 -0400
In-Reply-To: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "vimarsh.zutshi@nokia.com" <vimarsh.zutshi@nokia.com>, "Sakari.Ailus@nokia.com" <Sakari.Ailus@nokia.com>, "david.cohen@nokia.com" <david.cohen@nokia.com>

Hiroshi,
 


> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> This rejects unaligned physical address at setting page table 
> entry and informs error to caller. Otherwise, a wrong address 
> may be used by IO device.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/plat-omap/iommu.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iommu.c 
> b/arch/arm/plat-omap/iommu.c index 0e13766..b3591ee 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -503,6 +503,12 @@ static int iopgd_alloc_section(struct 
> iommu *obj, u32 da, u32 pa, u32 prot)  {
>  	u32 *iopgd = iopgd_offset(obj, da);
>  
> +	if (pa & ~IOSECTION_MASK) {
> +		dev_err(obj->dev, "%s: pa:%08x should aligned 
> on %08lx\n",
> +			__func__, pa, IOSECTION_SIZE);
> +		return -EINVAL;
> +	}
> +

-- I think the alignment check should be present even for da address. Same comment for below checks.

>  	*iopgd = (pa & IOSECTION_MASK) | prot | IOPGD_SECTION;
>  	flush_iopgd_range(iopgd, iopgd);
>  	return 0;
> @@ -513,6 +519,12 @@ static int iopgd_alloc_super(struct 
> iommu *obj, u32 da, u32 pa, u32 prot)
>  	u32 *iopgd = iopgd_offset(obj, da);
>  	int i;
>  
> +	if (pa & ~IOSUPER_MASK) {
> +		dev_err(obj->dev, "%s: pa:%08x should aligned 
> on %08lx\n",
> +			__func__, pa, IOSUPER_SIZE);
> +		return -EINVAL;
> +	}
> +
>  	for (i = 0; i < 16; i++)
>  		*(iopgd + i) = (pa & IOSUPER_MASK) | prot | IOPGD_SUPER;
>  	flush_iopgd_range(iopgd, iopgd + 15);
> @@ -542,6 +554,12 @@ static int iopte_alloc_large(struct 
> iommu *obj, u32 da, u32 pa, u32 prot)
>  	u32 *iopte = iopte_alloc(obj, iopgd, da);
>  	int i;
>  
> +	if (pa & ~IOLARGE_MASK) {
> +		dev_err(obj->dev, "%s: pa:%08x should aligned 
> on %08lx\n",
> +			__func__, pa, IOLARGE_SIZE);
> +		return -EINVAL;
> +	}
> +
>  	if (IS_ERR(iopte))
>  		return PTR_ERR(iopte);
>  
> --
> 1.7.1.rc1
> 
> 