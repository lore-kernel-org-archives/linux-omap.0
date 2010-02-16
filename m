From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 07/24] omap 3/4: Remove overlapping mapping of L4_WKUP io space
Date: Tue, 16 Feb 2010 21:27:58 +0530
Message-ID: <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54200 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757035Ab0BPP6f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:58:35 -0500
In-Reply-To: <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch removes the L4 wakeup io mapping section for omap3d
and omap4. L4 wakeup space is part of 4MB L4 space which is
already mapped and hence remove the overlapped mapping.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/io.c             |   12 ------------
 arch/arm/plat-omap/include/plat/io.h |    9 ---------
 arch/arm/plat-omap/io.c              |    4 ----
 3 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5a3d6f9..0385a28 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -140,12 +140,6 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= L4_WK_34XX_VIRT,
-		.pfn		= __phys_to_pfn(L4_WK_34XX_PHYS),
-		.length		= L4_WK_34XX_SIZE,
-		.type		= MT_DEVICE
-	},
-	{
 		.virtual	= OMAP34XX_GPMC_VIRT,
 		.pfn		= __phys_to_pfn(OMAP34XX_GPMC_PHYS),
 		.length		= OMAP34XX_GPMC_SIZE,
@@ -192,12 +186,6 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 		.type		= MT_DEVICE,
 	},
 	{
-		.virtual	= L4_WK_44XX_VIRT,
-		.pfn		= __phys_to_pfn(L4_WK_44XX_PHYS),
-		.length		= L4_WK_44XX_SIZE,
-		.type		= MT_DEVICE,
-	},
-	{
 		.virtual	= OMAP44XX_GPMC_VIRT,
 		.pfn		= __phys_to_pfn(OMAP44XX_GPMC_PHYS),
 		.length		= OMAP44XX_GPMC_SIZE,
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index eef914d..128b549 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -158,10 +158,6 @@
  * VPOM3430 was not working for Int controller
  */
 
-#define L4_WK_34XX_PHYS		L4_WK_34XX_BASE	/* 0x48300000 --> 0xfa300000 */
-#define L4_WK_34XX_VIRT		(L4_WK_34XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_WK_34XX_SIZE		SZ_1M
-
 #define L4_PER_34XX_PHYS	L4_PER_34XX_BASE
 						/* 0x49000000 --> 0xfb000000 */
 #define L4_PER_34XX_VIRT	(L4_PER_34XX_PHYS + OMAP2_L4_IO_OFFSET)
@@ -204,11 +200,6 @@
 #define L4_44XX_VIRT		(L4_44XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_44XX_SIZE		SZ_4M
 
-
-#define L4_WK_44XX_PHYS		L4_WK_44XX_BASE	/* 0x4a300000 --> 0xfc300000 */
-#define L4_WK_44XX_VIRT		(L4_WK_44XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_WK_44XX_SIZE		SZ_1M
-
 #define L4_PER_44XX_PHYS	L4_PER_44XX_BASE
 						/* 0x48000000 --> 0xfa000000 */
 #define L4_PER_44XX_VIRT	(L4_PER_44XX_PHYS + OMAP2_L4_IO_OFFSET)
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index 0cfd54f..2c494cf 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -90,8 +90,6 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 			return XLATE(p, L3_34XX_PHYS, L3_34XX_VIRT);
 		if (BETWEEN(p, L4_34XX_PHYS, L4_34XX_SIZE))
 			return XLATE(p, L4_34XX_PHYS, L4_34XX_VIRT);
-		if (BETWEEN(p, L4_WK_34XX_PHYS, L4_WK_34XX_SIZE))
-			return XLATE(p, L4_WK_34XX_PHYS, L4_WK_34XX_VIRT);
 		if (BETWEEN(p, OMAP34XX_GPMC_PHYS, OMAP34XX_GPMC_SIZE))
 			return XLATE(p, OMAP34XX_GPMC_PHYS, OMAP34XX_GPMC_VIRT);
 		if (BETWEEN(p, OMAP343X_SMS_PHYS, OMAP343X_SMS_SIZE))
@@ -110,8 +108,6 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 			return XLATE(p, L3_44XX_PHYS, L3_44XX_VIRT);
 		if (BETWEEN(p, L4_44XX_PHYS, L4_44XX_SIZE))
 			return XLATE(p, L4_44XX_PHYS, L4_44XX_VIRT);
-		if (BETWEEN(p, L4_WK_44XX_PHYS, L4_WK_44XX_SIZE))
-			return XLATE(p, L4_WK_44XX_PHYS, L4_WK_44XX_VIRT);
 		if (BETWEEN(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_SIZE))
 			return XLATE(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_VIRT);
 		if (BETWEEN(p, OMAP44XX_EMIF1_PHYS, OMAP44XX_EMIF1_SIZE))
-- 
1.6.0.4

