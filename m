From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
Date: Mon, 26 Apr 2010 15:20:44 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B571F42@dlee03.ent.ti.com>
References: <1271978196-26792-5-git-send-email-h-kanigeri2@ti.com>
	<20100423.153411.116357255.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4B4C368D@dlee03.ent.ti.com>
 <20100424.094433.258130456.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43622 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab0DZUUu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 16:20:50 -0400
In-Reply-To: <20100424.094433.258130456.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hiroshi,


> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Saturday, April 24, 2010 1:45 AM
> To: Kanigeri, Hari
> Cc: Gupta, Ramesh; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
> Date: Sat, 24 Apr 2010 01:43:19 +0200
> 
> > Hi Hiroshi,
> >
> >>
> >> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> >> index 1e83fac..d09a0a1 100644
> >> --- a/arch/arm/plat-omap/iommu.c
> >> +++ b/arch/arm/plat-omap/iommu.c
> >> @@ -25,6 +25,9 @@
> >>
> >>  #include "iopgtable.h"
> >>
> >> +#define for_each_iotlb_cr(obj, n, i, cr)				\
> >> +	for (i = 0; (i < n) && (cr = get_iotlb_cr(obj, i)); i++)
> >> +
> > -- This code is giving compilation error.
> 
> Should be like:
> 
> +#define for_each_iotlb_cr(obj, n, __i, cr)				\
> +	for (__i = 0;							\
> +	     (__i < (n)) && (cr = __iotlb_read_cr((obj), __i), true);	\
> +	     __i++)
> +

-- The change looks good to me.

Thank you,
Best regards,
Hari
