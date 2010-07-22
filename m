From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: Remove non-existent config option
Date: Thu, 22 Jul 2010 14:43:47 +0530
Message-ID: <1279790027-2509-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59205 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286Ab0GVJOh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Jul 2010 05:14:37 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6M9EXCO028662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 04:14:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Yogesh Marathe <yogesh_marathe@ti.com>, Sanjeev Premi <premi@ti.com>

From: Yogesh Marathe <yogesh_marathe@ti.com>

The definition of "iva2" device in iommu_device
is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
this option is not defined in KConfig.

This patch removes the wrapper and makes "iva2"
available as another iommu_device.

Signed-off-by: Yogesh Marathe <yogesh_marathe@ti.com>
Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/omap-iommu.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index f5a1aad..bb8c01d 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -35,7 +35,6 @@ static struct iommu_device omap3_devices[] = {
 			.clk_name = "cam_ick",
 		},
 	},
-#if defined(CONFIG_MPU_BRIDGE_IOMMU)
 	{
 		.base = 0x5d000000,
 		.irq = 28,
@@ -45,7 +44,6 @@ static struct iommu_device omap3_devices[] = {
 			.clk_name = "iva2_ck",
 		},
 	},
-#endif
 };
 #define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
 static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
-- 
1.6.6.1

