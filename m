From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 0/3] iommu: Remove OMAP IOVMM driver
Date: Fri, 18 Jul 2014 11:53:56 -0500
Message-ID: <53C95124.1010902@ti.com>
References: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40252 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885AbaGRQy2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jul 2014 12:54:28 -0400
In-Reply-To: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>, Florian Vaussard <florian.vaussard@epfl.ch>

Hi Laurent,

On 07/18/2014 05:49 AM, Laurent Pinchart wrote:
> Hello,
> 
> The OMAP3 ISP driver was the only user of the OMAP IOVMM API. Now that is has
> been ported to the DMA API, remove the unused virtual memory manager.
> 
> The removal is split in three patches to ease upstream merge. The first patch
> removes the omap-iovmm driver, the second patch removes setting of now unused
> platform data fields from arch code, and the last patch cleans up the platform
> data structure.

Thanks for the revised series, it looks good. I have also tested the
series on OMAP3, OMAP4 and OMAP5.

For the changes in the entire series,
Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> 
> I'd like to get at least the first patch merged in v3.17. To avoid splitting
> the series across three kernel versions, it would be nice to also merge at
> least the second patch for v3.17. If there's no risk of conflict everything
> could be merged in one go through the ARM SoC tree. Otherwise a stable branch
> with patch 1/3 will be needed to base the arch change on.
> 
> Joerg, Tony, how would you like to proceed ?
> 
> Changes compared to v1:
> 
> - Fix OMAP_IOMMU_DEBUG dependency on OMAP_IOMMU
> - Remove omap_iommu da_start and da_end fields
> - Added patches 2/3 and 3/3
> 
> Laurent Pinchart (3):
>   iommu/omap: Remove virtual memory manager
>   ARM: omap: Don't set iommu pdata da_start and da_end fields
>   iommu/omap: Remove platform data da_start and da_end fields
> 
>  arch/arm/mach-omap2/omap-iommu.c           |   2 -
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   4 -
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   4 -
>  drivers/iommu/Kconfig                      |  10 +-
>  drivers/iommu/Makefile                     |   1 -
>  drivers/iommu/omap-iommu-debug.c           | 114 -----
>  drivers/iommu/omap-iommu.c                 |  13 -
>  drivers/iommu/omap-iommu.h                 |   8 +-
>  drivers/iommu/omap-iovmm.c                 | 791 -----------------------------
>  include/linux/omap-iommu.h                 |  37 +-
>  include/linux/platform_data/iommu-omap.h   |   6 -
>  11 files changed, 8 insertions(+), 982 deletions(-)
>  delete mode 100644 drivers/iommu/omap-iovmm.c
> 

