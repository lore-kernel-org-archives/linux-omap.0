From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 0/3] iommu: Remove OMAP IOVMM driver
Date: Mon, 21 Jul 2014 11:14:49 +0200
Message-ID: <9251918.dhlInzvbvO@avalon>
References: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com> <53C95124.1010902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33757 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbaGUJOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 05:14:44 -0400
In-Reply-To: <53C95124.1010902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hi Suman, Joerg and Tony,

On Friday 18 July 2014 11:53:56 Suman Anna wrote:
> On 07/18/2014 05:49 AM, Laurent Pinchart wrote:
> > Hello,
> > 
> > The OMAP3 ISP driver was the only user of the OMAP IOVMM API. Now that is
> > has been ported to the DMA API, remove the unused virtual memory manager.
> > 
> > The removal is split in three patches to ease upstream merge. The first
> > patch removes the omap-iovmm driver, the second patch removes setting of
> > now unused platform data fields from arch code, and the last patch cleans
> > up the platform data structure.
> 
> Thanks for the revised series, it looks good. I have also tested the
> series on OMAP3, OMAP4 and OMAP5.
> 
> For the changes in the entire series,
> Acked-by: Suman Anna <s-anna@ti.com>

Thank you.

> > I'd like to get at least the first patch merged in v3.17. To avoid
> > splitting the series across three kernel versions, it would be nice to
> > also merge at least the second patch for v3.17. If there's no risk of
> > conflict everything could be merged in one go through the ARM SoC tree.
> > Otherwise a stable branch with patch 1/3 will be needed to base the arch
> > change on.
> > 
> > Joerg, Tony, how would you like to proceed ?

The v3.17 merge window is getting close, it's probably too late to merge patch 
2/3. Joerg, could you please take 1/3 in your tree for v3.17 ? 2/3 and 3/3 
would then get in v3.18. Tony, how would you like to proceed for those ?

> > Changes compared to v1:
> > 
> > - Fix OMAP_IOMMU_DEBUG dependency on OMAP_IOMMU
> > - Remove omap_iommu da_start and da_end fields
> > - Added patches 2/3 and 3/3
> > 
> > Laurent Pinchart (3):
> >   iommu/omap: Remove virtual memory manager
> >   ARM: omap: Don't set iommu pdata da_start and da_end fields
> >   iommu/omap: Remove platform data da_start and da_end fields
> >  
> >  arch/arm/mach-omap2/omap-iommu.c           |   2 -
> >  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   4 -
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   4 -
> >  drivers/iommu/Kconfig                      |  10 +-
> >  drivers/iommu/Makefile                     |   1 -
> >  drivers/iommu/omap-iommu-debug.c           | 114 -----
> >  drivers/iommu/omap-iommu.c                 |  13 -
> >  drivers/iommu/omap-iommu.h                 |   8 +-
> >  drivers/iommu/omap-iovmm.c                 | 791 ------------------------
> >  include/linux/omap-iommu.h                 |  37 +-
> >  include/linux/platform_data/iommu-omap.h   |   6 -
> >  11 files changed, 8 insertions(+), 982 deletions(-)
> >  delete mode 100644 drivers/iommu/omap-iovmm.c

-- 
Regards,

Laurent Pinchart

