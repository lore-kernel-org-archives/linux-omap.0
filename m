From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 0/3] iommu: Remove OMAP IOVMM driver
Date: Fri, 18 Jul 2014 12:49:54 +0200
Message-ID: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42803 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761319AbaGRKtw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2014 06:49:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>

Hello,

The OMAP3 ISP driver was the only user of the OMAP IOVMM API. Now that is has
been ported to the DMA API, remove the unused virtual memory manager.

The removal is split in three patches to ease upstream merge. The first patch
removes the omap-iovmm driver, the second patch removes setting of now unused
platform data fields from arch code, and the last patch cleans up the platform
data structure.

I'd like to get at least the first patch merged in v3.17. To avoid splitting
the series across three kernel versions, it would be nice to also merge at
least the second patch for v3.17. If there's no risk of conflict everything
could be merged in one go through the ARM SoC tree. Otherwise a stable branch
with patch 1/3 will be needed to base the arch change on.

Joerg, Tony, how would you like to proceed ?

Changes compared to v1:

- Fix OMAP_IOMMU_DEBUG dependency on OMAP_IOMMU
- Remove omap_iommu da_start and da_end fields
- Added patches 2/3 and 3/3

Laurent Pinchart (3):
  iommu/omap: Remove virtual memory manager
  ARM: omap: Don't set iommu pdata da_start and da_end fields
  iommu/omap: Remove platform data da_start and da_end fields

 arch/arm/mach-omap2/omap-iommu.c           |   2 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   4 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   4 -
 drivers/iommu/Kconfig                      |  10 +-
 drivers/iommu/Makefile                     |   1 -
 drivers/iommu/omap-iommu-debug.c           | 114 -----
 drivers/iommu/omap-iommu.c                 |  13 -
 drivers/iommu/omap-iommu.h                 |   8 +-
 drivers/iommu/omap-iovmm.c                 | 791 -----------------------------
 include/linux/omap-iommu.h                 |  37 +-
 include/linux/platform_data/iommu-omap.h   |   6 -
 11 files changed, 8 insertions(+), 982 deletions(-)
 delete mode 100644 drivers/iommu/omap-iovmm.c

-- 
Regards,

Laurent Pinchart

