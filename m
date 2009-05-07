From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Thu, 7 May 2009 15:28:29 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AED092B@dlee03.ent.ti.com>
References: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
 <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34327 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbZEGU2l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:28:41 -0400
In-Reply-To: <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tony Lindgren <tony@atomide.com>

> Currently the iva2 code (tidspbridge) is not using iommu, therefore it
> can't be
> used as-is with the current omap iommu. 

Bridge can use IOMMU module that Hiroshi has sent by calling below 2 lines of code. 

struct iommu *iva_iommu_ptr;
iva_iommu_ptr = iommu_get("iva2");


Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Contreras
> Sent: Thursday, May 07, 2009 3:11 PM
> To: linux-omap@vger.kernel.org
> Cc: Hiroshi DOYU; Felipe Contreras; Tony Lindgren; Felipe Contreras
> Subject: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
> 
> This patch series cleanups up a bit the opap3-iommu device registration
> and
> then allows registration from other parts of the code.
> 
> Currently the iva2 code (tidspbridge) is not using iommu, therefore it
> can't be
> used as-is with the current omap iommu. By allowing devies to be
> registered
> externaly (either isp, or iva2) this problem goes away.
> 
> Felipe Contreras (3):
>   omap3-iommu: reorganize
>   omap3-iommu: split init function into omap_iommu_add
>   omap3-iommu: remote registration
> 
>  arch/arm/mach-omap2/omap3-iommu.c       |  130 ++++++++++++++------------
> -----
>  arch/arm/plat-omap/include/mach/iommu.h |    2 +
>  2 files changed, 62 insertions(+), 70 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

