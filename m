From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v4 0/6] omap iommu changes to remove plat includes
Date: Wed, 24 Oct 2012 17:20:46 -0700
Message-ID: <20121025001913.2082.31062.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22416 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750894Ab2JYAUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 20:20:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are these posted again after updating patch 3/6 the following
patches no longer applied.

Regards,

Tony

---

Ido Yariv (3):
      ARM: OMAP: Merge iommu2.h into iommu.h
      ARM: OMAP2+: Move iopgtable header to drivers/iommu/
      ARM: OMAP2+: Make some definitions local

Tony Lindgren (3):
      ARM: OMAP2+: Move plat/iovmm.h to include/linux/omap-iommu.h
      ARM: OMAP2+: Move iommu2 to drivers/iommu/omap-iommu2.c
      ARM: OMAP2+: Move iommu/iovmm headers to platform_data


 arch/arm/mach-omap2/Makefile                |    2 
 arch/arm/mach-omap2/devices.c               |    2 
 arch/arm/mach-omap2/omap-iommu.c            |    2 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  |    2 
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |    2 
 arch/arm/plat-omap/include/plat/iommu2.h    |   96 -------------------
 arch/arm/plat-omap/include/plat/iovmm.h     |   89 ------------------
 drivers/iommu/Makefile                      |    1 
 drivers/iommu/omap-iommu-debug.c            |    8 +-
 drivers/iommu/omap-iommu.c                  |   39 ++++++++
 drivers/iommu/omap-iommu.h                  |  133 ++++++++++++++-------------
 drivers/iommu/omap-iommu2.c                 |   11 ++
 drivers/iommu/omap-iopgtable.h              |   22 ----
 drivers/iommu/omap-iovmm.c                  |   50 ++++++++++
 drivers/media/platform/omap3isp/isp.c       |    1 
 drivers/media/platform/omap3isp/isp.h       |    4 -
 drivers/media/platform/omap3isp/ispccdc.c   |    1 
 drivers/media/platform/omap3isp/ispstat.c   |    1 
 drivers/media/platform/omap3isp/ispvideo.c  |    3 -
 include/linux/omap-iommu.h                  |   52 +++++++++++
 include/linux/platform_data/iommu-omap.h    |   49 ++++++++++
 21 files changed, 279 insertions(+), 291 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/iommu2.h
 delete mode 100644 arch/arm/plat-omap/include/plat/iovmm.h
 rename arch/arm/plat-omap/include/plat/iommu.h => drivers/iommu/omap-iommu.h (69%)
 rename arch/arm/mach-omap2/iommu2.c => drivers/iommu/omap-iommu2.c (96%)
 rename arch/arm/plat-omap/include/plat/iopgtable.h => drivers/iommu/omap-iopgtable.h (85%)
 create mode 100644 include/linux/omap-iommu.h
 create mode 100644 include/linux/platform_data/iommu-omap.h

-- 
