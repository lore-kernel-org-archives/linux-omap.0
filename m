From: Christoph Egger <siccegge@cs.fau.de>
Subject: [PATCH 22/33] Removing dead MPU_{BRIDGE,TESLA}_IOMMU
Date: Wed, 30 Jun 2010 18:01:01 +0200
Message-ID: <fcfa44a43c21c70f89ced96b96d7c1489d28cc51.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.orglinux-
Cc: vamos@i4.informatik.uni-erlangen.de
List-Id: linux-omap@vger.kernel.org

MPU_{BRIDGE,TESLA}_IOMMU doesn't exist in Kconfig, therefore removing
all references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-omap2/omap-iommu.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index eb9bee7..3aa3fe9 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -35,17 +35,6 @@ static struct iommu_device omap3_devices[] = {
 			.clk_name = "cam_ick",
 		},
 	},
-#if defined(CONFIG_MPU_BRIDGE_IOMMU)
-	{
-		.base = 0x5d000000,
-		.irq = 28,
-		.pdata = {
-			.name = "iva2",
-			.nr_tlb_entries = 32,
-			.clk_name = "iva2_ck",
-		},
-	},
-#endif
 };
 #define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
 static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
@@ -66,17 +55,6 @@ static struct iommu_device omap4_devices[] = {
 			.clk_name = "ducati_ick",
 		},
 	},
-#if defined(CONFIG_MPU_TESLA_IOMMU)
-	{
-		.base = OMAP4_MMU2_BASE,
-		.irq = INT_44XX_DSP_MMU,
-		.pdata = {
-			.name = "tesla",
-			.nr_tlb_entries = 32,
-			.clk_name = "tesla_ick",
-		},
-	},
-#endif
 };
 #define NR_OMAP4_IOMMU_DEVICES ARRAY_SIZE(omap4_devices)
 static struct platform_device *omap4_iommu_pdev[NR_OMAP4_IOMMU_DEVICES];
-- 
1.7.0.4
