From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/11] omap3: Remove non-existent config option
Date: Thu, 23 Sep 2010 18:50:56 -0700
Message-ID: <20100924015056.10325.95854.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57649 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab0IXBu4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 21:50:56 -0400
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>, Yogesh Marathe <yogesh_marathe@ti.com>

From: Yogesh Marathe <yogesh_marathe@ti.com>

The definition of "iva2" device in iommu_device
is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
this option is not defined in KConfig.

This patch removes the wrapper and makes "iva2"
available as another iommu_device.

Signed-off-by: Yogesh Marathe <yogesh_marathe@ti.com>
Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

