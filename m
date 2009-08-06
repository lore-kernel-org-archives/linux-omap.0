From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] OMAP: Remove ifdefs for io.h
Date: Thu, 06 Aug 2009 13:13:02 +0300
Message-ID: <20090806101302.2569.25069.stgit@localhost>
References: <20090806100614.2569.8531.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61822 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZHFKNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 06:13:04 -0400
In-Reply-To: <20090806100614.2569.8531.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Remove ifdefs for io.h

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/io.c             |    6 +++---
 arch/arm/plat-omap/include/mach/io.h |   37 +++++++++++++++++++++++++++-------
 arch/arm/plat-omap/io.c              |    4 ++--
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 3afe540..7030f92 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -29,9 +29,9 @@ extern void omapfb_reserve_sdram(void);
  */
 static struct map_desc omap_io_desc[] __initdata = {
 	{
-		.virtual	= IO_VIRT,
-		.pfn		= __phys_to_pfn(IO_PHYS),
-		.length		= IO_SIZE,
+		.virtual	= OMAP1_IO_VIRT,
+		.pfn		= __phys_to_pfn(OMAP1_IO_PHYS),
+		.length		= OMAP1_IO_SIZE,
 		.type		= MT_DEVICE
 	}
 };
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 8541388..c4886f9 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -66,13 +66,21 @@
 #define OMAP2_IO_OFFSET		0x90000000
 #define OMAP2_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_IO_OFFSET) /* L3 and L4 */
 
-#if defined(CONFIG_ARCH_OMAP1)
+/*
+ * ----------------------------------------------------------------------------
+ * Omap1 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
 
-#define IO_PHYS			0xFFFB0000
-#define IO_SIZE			0x40000
-#define IO_VIRT			(IO_PHYS - OMAP1_IO_OFFSET)
+#define OMAP1_IO_PHYS		0xFFFB0000
+#define OMAP1_IO_SIZE		0x40000
+#define OMAP1_IO_VIRT		(OMAP1_IO_PHYS - OMAP1_IO_OFFSET)
 
-#elif defined(CONFIG_ARCH_OMAP2)
+/*
+ * ----------------------------------------------------------------------------
+ * Omap2 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
 
 /* We map both L3 and L4 on OMAP2 */
 #define L3_24XX_PHYS	L3_24XX_BASE	/* 0x68000000 */
@@ -106,7 +114,11 @@
 #define DSP_MMU_24XX_VIRT	0xe2000000
 #define DSP_MMU_24XX_SIZE	SZ_4K
 
-#elif defined(CONFIG_ARCH_OMAP3)
+/*
+ * ----------------------------------------------------------------------------
+ * Omap3 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
 
 /* We map both L3 and L4 on OMAP3 */
 #define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 */
@@ -157,8 +169,12 @@
 #define DSP_MMU_34XX_VIRT	0xe2000000
 #define DSP_MMU_34XX_SIZE	SZ_4K
 
+/*
+ * ----------------------------------------------------------------------------
+ * Omap4 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
 
-#elif defined(CONFIG_ARCH_OMAP4)
 /* We map both L3 and L4 on OMAP4 */
 #define L3_44XX_PHYS		L3_44XX_BASE
 #define L3_44XX_VIRT		0xd4000000
@@ -185,7 +201,12 @@
 #define OMAP44XX_GPMC_VIRT	0xe0000000
 #define OMAP44XX_GPMC_SIZE	SZ_1M
 
-#endif
+
+/*
+ * ----------------------------------------------------------------------------
+ * Omap specific register access
+ * ----------------------------------------------------------------------------
+ */
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index d491ad1..b6defa2 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -30,8 +30,8 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 {
 #ifdef CONFIG_ARCH_OMAP1
 	if (cpu_class_is_omap1()) {
-		if (BETWEEN(p, IO_PHYS, IO_SIZE))
-			return XLATE(p, IO_PHYS, IO_VIRT);
+		if (BETWEEN(p, OMAP1_IO_PHYS, OMAP1_IO_SIZE))
+			return XLATE(p, OMAP1_IO_PHYS, OMAP1_IO_VIRT);
 	}
 	if (cpu_is_omap730()) {
 		if (BETWEEN(p, OMAP730_DSP_BASE, OMAP730_DSP_SIZE))

