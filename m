From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 3/4] iovmm: replace __iounmap with omap_iounmap
Date: Thu, 14 Oct 2010 09:45:25 +0300 (EEST)
Message-ID: <20101014.094525.71092814.Hiroshi.DOYU@nokia.com>
References: <1287023257-30951-2-git-send-email-x0095840@ti.com>
	<1287023257-30951-3-git-send-email-x0095840@ti.com>
	<1287023257-30951-4-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48352 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab0JNGqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 02:46:25 -0400
In-Reply-To: <1287023257-30951-4-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: felipe.contreras@nokia.com, tony@atomide.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org

Hi Fernando,

From: ext Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH 3/4] iovmm: replace __iounmap with omap_iounmap
Date: Thu, 14 Oct 2010 04:27:36 +0200

> Omap platform is omap_iounmap function.
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  arch/arm/plat-omap/iovmm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 93a34d9..5489ca9 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -821,7 +821,7 @@ void iommu_kunmap(struct iommu *obj, u32 da)
>  	struct sg_table *sgt;
>  	typedef void (*func_t)(const void *);
>  
> -	sgt = unmap_vm_area(obj, da, (func_t)__iounmap,

+	sgt = unmap_vm_area(obj, da, (func_t)iounmap,

Woundn't the above be enough?

Eventually this "iounmap()" calls "__arch_iounmap()" ->
"omap_iounmap()". I don't see any special reason to call
"omap_iounmap()" here for now.


> +	sgt = unmap_vm_area(obj, da, (func_t)omap_iounmap,
>  			    IOVMF_LINEAR | IOVMF_MMIO);
>  	if (!sgt)
>  		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
> -- 
> 1.6.3.3
> 
