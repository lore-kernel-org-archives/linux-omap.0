From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v3 0/4] OMAP: iommu: hwmod support and runtime PM
Date: Tue,  1 Nov 2011 17:15:48 -0500
Message-ID: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ohad Ben-Cohen <ohad@wizery.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, lm <linux-media@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>
List-Id: linux-omap@vger.kernel.org

Introduced hwmod support for OMAP3 (iva, isp) and OMAP4 (ipu, dsp),
along with the corresponding runtime PM routines to deassert reset
lines, enable/disable clocks and configure sysc registers.

v3:
- Rebased to 3.1-rc10 lo rebuilt, added structure terminators, and
removed .omap_chip field.

v2:
- Added oh reset info to assert/deassert mmu reset lines.
- Addressed previous comments on v1
http://www.spinics.net/lists/arm-kernel/msg103271.html

Due to compatibility an ifdef needs to be propagated (previously on
iommu resource info) to hwmod data in OMAP3, so users of iommu and
tidspbridge can avoid issues of two modules managing mmu data/irqs/resets;
this until tidspbridge can be safely migrated to iommu framework.

Omar Ramirez Luna (4):
  OMAP3: hwmod data: add mmu data for iva and isp
  OMAP4: hwmod data: add mmu hwmod for ipu and dsp
  OMAP3/4: iommu: migrate to hwmod framework
  OMAP3/4: iommu: adapt to runtime pm

 arch/arm/mach-omap2/iommu2.c                      |   36 -----
 arch/arm/mach-omap2/omap-iommu.c                  |  162 ++++-----------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c        |  131 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c        |  154 ++++++++++++++++++--
 arch/arm/plat-omap/include/plat/iommu.h           |   17 ++-
 arch/arm/plat-omap/include/plat/iommu2.h          |    2 -
 drivers/iommu/omap-iommu.c                        |   49 +++----
 drivers/media/video/omap3isp/isp.c                |    2 +-
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |    2 +-
 9 files changed, 339 insertions(+), 216 deletions(-)
