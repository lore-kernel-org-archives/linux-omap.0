From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 0/7] omap: iommu migration, relocation and cleanups
Date: Thu, 18 Aug 2011 02:10:01 +0300
Message-ID: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63009 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab1HQXKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Aug 2011 19:10:34 -0400
Received: by wyg24 with SMTP id 24so1018589wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Aug 2011 16:10:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>

1. Migrate OMAP's iommu driver to the generic IOMMU API, and move it
to the dedicated iommu folder.

2. Fix omap3isp appropriately so it doesn't break.

3. Adapt OMAP's iovmm appropriately as well, because omap3isp still relies
on it. The plan is eventually to remove iovmm and replace it with the
upcoming IOMMU-based generic DMA-API. Move iovmm to the iommu folder too;
it belongs there more than it belongs in the OMAP folders.

4. Start cleaning up OMAP's iommu components towards the end goal, where
    1) omap-iommu no longer exports public API (and instead provides its
       entire functionality via the generic IOMMU API).
    2) omap-iovmm is removed.

Changes:
1. Migrate iommu, iovmm and omap3isp in a single patch for bisectibility sake.
2. Apply Laurent Pinchart's comments (thanks Laurent!)
3. Rebase to 3.1-rc2

Ohad Ben-Cohen (7):
  omap: iommu: migrate to the generic IOMMU API
  omap: iommu/iovmm: move to dedicated iommu folder
  omap: iommu: stop exporting local functions
  omap: iommu: PREFETCH_IOTLB cleanup
  omap: iovmm: remove unused functionality
  omap: iommu: remove unused exported API
  omap: iommu: omapify 'struct iommu' and exposed API

 arch/arm/mach-omap2/iommu2.c                       |   31 +-
 arch/arm/plat-omap/Kconfig                         |   12 -
 arch/arm/plat-omap/Makefile                        |    2 -
 arch/arm/plat-omap/include/plat/iommu.h            |   75 ++--
 arch/arm/plat-omap/include/plat/iommu2.h           |    4 +-
 arch/arm/plat-omap/{ => include/plat}/iopgtable.h  |   20 +-
 arch/arm/plat-omap/include/plat/iovmm.h            |   30 +-
 drivers/iommu/Kconfig                              |   18 +
 drivers/iommu/Makefile                             |    3 +
 .../iommu/omap-iommu-debug.c                       |   36 +-
 .../iommu.c => drivers/iommu/omap-iommu.c          |  495 +++++++++++++-------
 .../iovmm.c => drivers/iommu/omap-iovmm.c          |  304 ++++---------
 drivers/media/video/Kconfig                        |    2 +-
 drivers/media/video/omap3isp/isp.c                 |   45 ++-
 drivers/media/video/omap3isp/isp.h                 |    5 +-
 drivers/media/video/omap3isp/ispccdc.c             |   25 +-
 drivers/media/video/omap3isp/ispstat.c             |   11 +-
 drivers/media/video/omap3isp/ispvideo.c            |    4 +-
 18 files changed, 600 insertions(+), 522 deletions(-)
 rename arch/arm/plat-omap/{ => include/plat}/iopgtable.h (82%)
 rename arch/arm/plat-omap/iommu-debug.c => drivers/iommu/omap-iommu-debug.c (91%)
 rename arch/arm/plat-omap/iommu.c => drivers/iommu/omap-iommu.c (62%)
 rename arch/arm/plat-omap/iovmm.c => drivers/iommu/omap-iovmm.c (68%)

-- 
1.7.4.1

