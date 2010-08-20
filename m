From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] omap:iommu-load cam register before flushing the entry
Date: Fri, 20 Aug 2010 17:09:20 -0500
Message-ID: <A24693684029E5489D1D202277BE89445721FA38@dlee02.ent.ti.com>
References: <1282312218-26545-1-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54396 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab0HTWJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 18:09:26 -0400
In-Reply-To: <1282312218-26545-1-git-send-email-h-kanigeri2@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux omap <linux-omap@vger.kernel.org>

Hi Hari,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
> Sent: Friday, August 20, 2010 8:50 AM
> To: Hiroshi Doyu; Linux omap
> Cc: Kanigeri, Hari
> Subject: [PATCH] omap:iommu-load cam register before flushing the entry
> 
> The flush_iotlb_page is not loading the cam register before flushing
> the cam entry. This causes wrong entry to be flushed out from the TLB, and
> if the entry happens to be a locked TLB entry it would lead to MMU faults.
> 
> The fix is to load the cam register with the address to be flushed before
> flushing the TLB entry.

I'm curious... does this impact OMAP3 ISP aswell? Or is it for OMAP4 only?

Regards,
Sergio

> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/iommu.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 2e603fe..c534280 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -315,6 +315,7 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
>  		if ((start <= da) && (da < start + bytes)) {
>  			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
>  				__func__, start, da, bytes);
> +			iotlb_load_cr(obj, &cr);
>  			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
>  		}
>  	}
> --
> 1.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
