From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 2/3] omap iommu: fix incorrect address for large page
 1st entry
Date: Mon, 11 Jan 2010 15:57:44 -0600
Message-ID: <A24693684029E5489D1D202277BE8944513DBE55@dlee02.ent.ti.com>
References: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1263195995-23244-2-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53768 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab0AKVzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 16:55:55 -0500
In-Reply-To: <1263195995-23244-2-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nagalla, Hari" <hnagalla@ti.com>

Hi Hiroshi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> Sent: Monday, January 11, 2010 1:47 AM
> To: linux-omap@vger.kernel.org
> Cc: Nagalla, Hari; Hiroshi DOYU
> Subject: [PATCH 2/3] omap iommu: fix incorrect address for large page 1st
> entry
> 
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Description missing here aswell.

Regards,
Sergio
> 
> Reported-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  arch/arm/plat-omap/iommu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index c0ff1e3..ccf25b3 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -1,7 +1,7 @@
>  /*
>   * omap iommu: tlb and pagetable primitives
>   *
> - * Copyright (C) 2008-2009 Nokia Corporation
> + * Copyright (C) 2008-2010 Nokia Corporation
>   *
>   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
>   *		Paul Mundt and Toshihiro Kobayashi
> @@ -646,7 +646,7 @@ static size_t iopgtable_clear_entry_core(struct iommu
> *obj, u32 da)
>  		if (*iopte & IOPTE_LARGE) {
>  			nent *= 16;
>  			/* rewind to the 1st entry */
> -			iopte = (u32 *)((u32)iopte & IOLARGE_MASK);
> +			iopte = iopte_offset(iopgd, (da & IOLARGE_MASK));
>  		}
>  		bytes *= nent;
>  		memset(iopte, 0, nent * sizeof(*iopte));
> --
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
