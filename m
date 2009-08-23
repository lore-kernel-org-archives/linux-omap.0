From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] ARM: OMAP2/3/4: Add OMAP4 L3 and L4 peripherals.
Date: Sun, 23 Aug 2009 19:04:55 +0530
Message-ID: <1251034495-10107-5-git-send-email-santosh.shilimkar@ti.com>
References: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com>
 <1251034495-10107-2-git-send-email-santosh.shilimkar@ti.com>
 <1251034495-10107-3-git-send-email-santosh.shilimkar@ti.com>
 <1251034495-10107-4-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35659 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933759AbZHWNfG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Aug 2009 09:35:06 -0400
In-Reply-To: <1251034495-10107-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds few necessary peripherals for OMAP4.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/io.c                   |   18 +++++++++++++++++
 arch/arm/plat-omap/include/mach/io.h       |   29 +++++++++++++++++++++++++--
 arch/arm/plat-omap/include/mach/omap44xx.h |    3 ++
 arch/arm/plat-omap/io.c                    |    8 +++++++
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e9b9bcb..6487a69 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -197,6 +197,24 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 		.type		= MT_DEVICE,
 	},
 	{
+		.virtual	= OMAP44XX_EMIF1_VIRT,
+		.pfn		= __phys_to_pfn(OMAP44XX_EMIF1_PHYS),
+		.length		= OMAP44XX_EMIF1_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= OMAP44XX_EMIF2_VIRT,
+		.pfn		= __phys_to_pfn(OMAP44XX_EMIF2_PHYS),
+		.length		= OMAP44XX_EMIF2_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= OMAP44XX_DMM_VIRT,
+		.pfn		= __phys_to_pfn(OMAP44XX_DMM_PHYS),
+		.length		= OMAP44XX_DMM_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
 		.virtual	= L4_PER_44XX_VIRT,
 		.pfn		= __phys_to_pfn(L4_PER_44XX_PHYS),
 		.length		= L4_PER_44XX_SIZE,
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 47d673a..8f56545 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -66,15 +66,19 @@
 #define OMAP2_L3_IO_OFFSET	0x90000000
 #define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
 
+
+#define OMAP2_L4_IO_OFFSET	0xb2000000
+#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET) /* L4 */
+
 #define OMAP4_L3_IO_OFFSET	0xb4000000
 #define OMAP4_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_IO_OFFSET) /* L3 */
 
+#define OMAP4_L3_PER_IO_OFFSET	0xb1100000
+#define OMAP4_L3_PER_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_PER_IO_OFFSET)
+
 #define OMAP4_GPMC_IO_OFFSET		0xa9000000
 #define OMAP4_GPMC_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_GPMC_IO_OFFSET)
 
-#define OMAP2_L4_IO_OFFSET	0xb2000000
-#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET) /* L4 */
-
 /* EMU mapping is not used anywhere in OMAP. Still mapping incase needed */
 #define OMAP2_EMU_IO_OFFSET		0xaa800000	/* Emulation */
 #define OMAP2_EMU_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_EMU_IO_OFFSET)
@@ -214,6 +218,11 @@
 #define L4_PER_44XX_VIRT	(L4_PER_44XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_PER_44XX_SIZE	SZ_4M
 
+#define L4_ABE_44XX_PHYS	L4_ABE_44XX_BASE
+						/* 0x49000000 --> 0xfb000000 */
+#define L4_ABE_44XX_VIRT	(L4_ABE_44XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_ABE_44XX_SIZE	SZ_1M
+
 #define L4_EMU_44XX_PHYS	L4_EMU_44XX_BASE
 						/* 0x54000000 --> 0xfe800000 */
 #define L4_EMU_44XX_VIRT	(L4_EMU_44XX_PHYS + OMAP2_EMU_IO_OFFSET)
@@ -225,6 +234,20 @@
 #define OMAP44XX_GPMC_SIZE	SZ_1M
 
 
+#define OMAP44XX_EMIF1_PHYS	OMAP44XX_EMIF1_BASE
+						/* 0x4c000000 --> 0xfd100000 */
+#define OMAP44XX_EMIF1_VIRT	(OMAP44XX_EMIF1_PHYS + OMAP4_L3_PER_IO_OFFSET)
+#define OMAP44XX_EMIF1_SIZE	SZ_1M
+
+#define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
+						/* 0x4d000000 --> 0xfd200000 */
+#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF2_PHYS + OMAP4_L3_PER_IO_OFFSET)
+#define OMAP44XX_EMIF2_SIZE	SZ_1M
+
+#define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
+						/* 0x4e000000 --> 0xfd300000 */
+#define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
+#define OMAP44XX_DMM_SIZE	SZ_1M
 /*
  * ----------------------------------------------------------------------------
  * Omap specific register access
diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
index 151d8bb..cb2fa10 100644
--- a/arch/arm/plat-omap/include/mach/omap44xx.h
+++ b/arch/arm/plat-omap/include/mach/omap44xx.h
@@ -22,6 +22,9 @@
 #define L4_PER_44XX_BASE		0x48000000
 #define L4_EMU_44XX_BASE		0x54000000
 #define L3_44XX_BASE			0x44000000
+#define OMAP44XX_EMIF1_BASE		0x4c000000
+#define OMAP44XX_EMIF2_BASE		0x4d000000
+#define OMAP44XX_DMM_BASE		0x4e000000
 #define OMAP4430_32KSYNCT_BASE		0x4a304000
 #define OMAP4430_CM_BASE		0x4a004000
 #define OMAP4430_PRM_BASE		0x48306000
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index 35adca8..1079545 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -114,6 +114,14 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 			return XLATE(p, L4_WK_44XX_PHYS, L4_WK_44XX_VIRT);
 		if (BETWEEN(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_SIZE))
 			return XLATE(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_VIRT);
+		if (BETWEEN(p, OMAP44XX_EMIF1_PHYS, OMAP44XX_EMIF1_SIZE))
+			return XLATE(p, OMAP44XX_EMIF1_PHYS,		\
+							OMAP44XX_EMIF1_VIRT);
+		if (BETWEEN(p, OMAP44XX_EMIF2_PHYS, OMAP44XX_EMIF2_SIZE))
+			return XLATE(p, OMAP44XX_EMIF2_PHYS,		\
+							OMAP44XX_EMIF2_VIRT);
+		if (BETWEEN(p, OMAP44XX_DMM_PHYS, OMAP44XX_DMM_SIZE))
+			return XLATE(p, OMAP44XX_DMM_PHYS, OMAP44XX_DMM_VIRT);
 		if (BETWEEN(p, L4_PER_44XX_PHYS, L4_PER_44XX_SIZE))
 			return XLATE(p, L4_PER_44XX_PHYS, L4_PER_44XX_VIRT);
 		if (BETWEEN(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_SIZE))
-- 
1.5.4.7

