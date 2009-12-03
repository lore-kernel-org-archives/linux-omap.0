From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP2xxx IO mapping: mark DSP mappings as being 2420-only
Date: Thu, 03 Dec 2009 01:15:58 -0700
Message-ID: <20091203081555.1004.39576.stgit@localhost.localdomain>
References: <20091203081337.1004.51309.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60922 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbZLCIQt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 03:16:49 -0500
In-Reply-To: <20091203081337.1004.51309.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Out of the three major OMAP2 chip types, OMAP2420, OMAP2430, and OMAP3430,
we only map the IVA on OMAP2420.  The memory mapping is not shared between
OMAP2420 and OMAP2430, so it is inappropriate to label those macros as
'24XX'; this patch changes them to '2420'.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c             |   18 +++++++++---------
 arch/arm/plat-omap/include/plat/io.h |   33 +++++++++++++--------------------
 arch/arm/plat-omap/io.c              |   12 ++++++------
 3 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6a4d8e4..cb09e87 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -74,21 +74,21 @@ static struct map_desc omap24xx_io_desc[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP2420
 static struct map_desc omap242x_io_desc[] __initdata = {
 	{
-		.virtual	= DSP_MEM_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_MEM_24XX_PHYS),
-		.length		= DSP_MEM_24XX_SIZE,
+		.virtual	= DSP_MEM_2420_VIRT,
+		.pfn		= __phys_to_pfn(DSP_MEM_2420_PHYS),
+		.length		= DSP_MEM_2420_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= DSP_IPI_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_IPI_24XX_PHYS),
-		.length		= DSP_IPI_24XX_SIZE,
+		.virtual	= DSP_IPI_2420_VIRT,
+		.pfn		= __phys_to_pfn(DSP_IPI_2420_PHYS),
+		.length		= DSP_IPI_2420_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= DSP_MMU_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_MMU_24XX_PHYS),
-		.length		= DSP_MMU_24XX_SIZE,
+		.virtual	= DSP_MMU_2420_VIRT,
+		.pfn		= __phys_to_pfn(DSP_MMU_2420_PHYS),
+		.length		= DSP_MMU_2420_SIZE,
 		.type		= MT_DEVICE
 	},
 };
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 7e5319f..7d6f45f 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -122,16 +122,18 @@
 #define OMAP243X_SMS_VIRT	(OMAP243X_SMS_PHYS + OMAP2_L3_IO_OFFSET)
 #define OMAP243X_SMS_SIZE	SZ_1M
 
-/* DSP */
-#define DSP_MEM_24XX_PHYS	OMAP2420_DSP_MEM_BASE	/* 0x58000000 */
-#define DSP_MEM_24XX_VIRT	0xe0000000
-#define DSP_MEM_24XX_SIZE	0x28000
-#define DSP_IPI_24XX_PHYS	OMAP2420_DSP_IPI_BASE	/* 0x59000000 */
-#define DSP_IPI_24XX_VIRT	0xe1000000
-#define DSP_IPI_24XX_SIZE	SZ_4K
-#define DSP_MMU_24XX_PHYS	OMAP2420_DSP_MMU_BASE	/* 0x5a000000 */
-#define DSP_MMU_24XX_VIRT	0xe2000000
-#define DSP_MMU_24XX_SIZE	SZ_4K
+/* 2420 IVA */
+#define DSP_MEM_2420_PHYS	OMAP2420_DSP_MEM_BASE	/* 0x58000000 */
+#define DSP_MEM_2420_VIRT	0xe0000000
+#define DSP_MEM_2420_SIZE	0x28000
+#define DSP_IPI_2420_PHYS	OMAP2420_DSP_IPI_BASE	/* 0x59000000 */
+#define DSP_IPI_2420_VIRT	0xe1000000
+#define DSP_IPI_2420_SIZE	SZ_4K
+#define DSP_MMU_2420_PHYS	OMAP2420_DSP_MMU_BASE	/* 0x5a000000 */
+#define DSP_MMU_2420_VIRT	0xe2000000
+#define DSP_MMU_2420_SIZE	SZ_4K
+
+/* 2430 IVA2.1 - currently unmapped */
 
 /*
  * ----------------------------------------------------------------------------
@@ -182,16 +184,7 @@
 #define OMAP343X_SDRC_VIRT	(OMAP343X_SDRC_PHYS + OMAP2_L3_IO_OFFSET)
 #define OMAP343X_SDRC_SIZE	SZ_1M
 
-/* DSP */
-#define DSP_MEM_34XX_PHYS	OMAP34XX_DSP_MEM_BASE	/* 0x58000000 */
-#define DSP_MEM_34XX_VIRT	0xe0000000
-#define DSP_MEM_34XX_SIZE	0x28000
-#define DSP_IPI_34XX_PHYS	OMAP34XX_DSP_IPI_BASE	/* 0x59000000 */
-#define DSP_IPI_34XX_VIRT	0xe1000000
-#define DSP_IPI_34XX_SIZE	SZ_4K
-#define DSP_MMU_34XX_PHYS	OMAP34XX_DSP_MMU_BASE	/* 0x5a000000 */
-#define DSP_MMU_34XX_VIRT	0xe2000000
-#define DSP_MMU_34XX_SIZE	SZ_4K
+/* 3430 IVA - currently unmapped */
 
 /*
  * ----------------------------------------------------------------------------
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index 11f5d79..0cfd54f 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -66,12 +66,12 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 			return XLATE(p, L4_24XX_PHYS, L4_24XX_VIRT);
 	}
 	if (cpu_is_omap2420()) {
-		if (BETWEEN(p, DSP_MEM_24XX_PHYS, DSP_MEM_24XX_SIZE))
-			return XLATE(p, DSP_MEM_24XX_PHYS, DSP_MEM_24XX_VIRT);
-		if (BETWEEN(p, DSP_IPI_24XX_PHYS, DSP_IPI_24XX_SIZE))
-			return XLATE(p, DSP_IPI_24XX_PHYS, DSP_IPI_24XX_SIZE);
-		if (BETWEEN(p, DSP_MMU_24XX_PHYS, DSP_MMU_24XX_SIZE))
-			return XLATE(p, DSP_MMU_24XX_PHYS, DSP_MMU_24XX_VIRT);
+		if (BETWEEN(p, DSP_MEM_2420_PHYS, DSP_MEM_2420_SIZE))
+			return XLATE(p, DSP_MEM_2420_PHYS, DSP_MEM_2420_VIRT);
+		if (BETWEEN(p, DSP_IPI_2420_PHYS, DSP_IPI_2420_SIZE))
+			return XLATE(p, DSP_IPI_2420_PHYS, DSP_IPI_2420_SIZE);
+		if (BETWEEN(p, DSP_MMU_2420_PHYS, DSP_MMU_2420_SIZE))
+			return XLATE(p, DSP_MMU_2420_PHYS, DSP_MMU_2420_VIRT);
 	}
 	if (cpu_is_omap2430()) {
 		if (BETWEEN(p, L4_WK_243X_PHYS, L4_WK_243X_SIZE))


