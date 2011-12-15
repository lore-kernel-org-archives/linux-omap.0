From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v4 0/4] OMAP: iommu: hwmod support and runtime PM
Date: Wed, 14 Dec 2011 22:18:25 -0600
Message-ID: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:59357 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755957Ab1LOESm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 23:18:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, MyungJoo Ham <myungjoo.ham@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Linux PM <linux-pm@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Introduced hwmod support for OMAP3 (iva, isp) and OMAP4 (ipu, dsp),
along with the corresponding runtime PM routines to deassert reset
lines, enable/disable clocks and configure sysc registers.

v4:
- Rebased to 3.2-rc5 LO.
- Added missing clkdm field for OMAP4 hwmod data.
- Moved pm runtime enable/disable to probe/remove functions as
  suggested by MyungJoo Ham.
- Removed HWMOD_INIT_NO_RESET as it is not needed and because of
  Kevin Hilman's comments, the failure I was seeing without
  HWMOD_INIT_NO_RESET might have been related to local changes as
  it couldn't be reproduced anymore.
- Removed iommu latency as it is the same as the default omap latency.
- Tested on OMAP3 (zoom3 + tidspbridge) and OMAP4 (Panda + rpmsg).

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

 arch/arm/mach-omap2/iommu2.c               |   36 -------
 arch/arm/mach-omap2/omap-iommu.c           |  156 +++++-----------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  135 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  154 +++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/iommu.h    |   17 +++-
 arch/arm/plat-omap/include/plat/iommu2.h   |    2 -
 drivers/iommu/omap-iommu.c                 |   47 +++-----
 7 files changed, 334 insertions(+), 213 deletions(-)

-- 
1.7.4.1

