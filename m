From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
Date: Fri, 23 Apr 2010 18:43:19 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B4C368D@dlee03.ent.ti.com>
References: <1271978196-26792-1-git-send-email-h-kanigeri2@ti.com>
	<1271978196-26792-5-git-send-email-h-kanigeri2@ti.com>
 <20100423.153411.116357255.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58676 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571Ab0DWXn0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:43:26 -0400
In-Reply-To: <20100423.153411.116357255.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hiroshi,

> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 1e83fac..d09a0a1 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -25,6 +25,9 @@
> 
>  #include "iopgtable.h"
> 
> +#define for_each_iotlb_cr(obj, n, i, cr)				\
> +	for (i = 0; (i < n) && (cr = get_iotlb_cr(obj, i)); i++)
> +
-- This code is giving compilation error. 
Can you please send a new patch after fixing this on top of my patches.

Thank you,
Best regards,
Hari
