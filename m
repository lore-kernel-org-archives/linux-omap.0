From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 1/1] ARM: OMAP: 243x: Add mappings for SDRC and SMS
Date: Tue, 13 Mar 2007 18:06:41 -0700
Message-ID: <20070314010641.009385000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add mappings for SDRC ans SMS so that omap2_memory_init() works on the
2430.  This also allows the mpurate= command-line option to work.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/io.c             |   17 ++++++++++++-----
 include/asm-arm/arch-omap/io.h       |    7 +++++++
 include/asm-arm/arch-omap/omap24xx.h |    3 ++-
 3 files changed, 21 insertions(+), 6 deletions(-)

Index: dev/arch/arm/mach-omap2/io.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/io.c
+++ dev/arch/arm/mach-omap2/io.c
@@ -61,6 +61,18 @@ static struct map_desc omap2_io_desc[] _
 		.length		= OMAP243X_GPMC_SIZE,
 		.type		= MT_DEVICE
 	},
+	{
+		.virtual	= OMAP243X_SDRC_VIRT,
+		.pfn		= __phys_to_pfn(OMAP243X_SDRC_PHYS),
+		.length		= OMAP243X_SDRC_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= OMAP243X_SMS_VIRT,
+		.pfn		= __phys_to_pfn(OMAP243X_SMS_PHYS),
+		.length		= OMAP243X_SMS_SIZE,
+		.type		= MT_DEVICE
+	},
 #endif
 	{
 		.virtual	= DSP_MEM_24XX_VIRT,
@@ -102,11 +114,6 @@ void __init omap2_init_common_hw(void)
 {
 	omap2_mux_init();
 	omap2_clk_init();
-/*
- * Need to Fix this for 2430
- */
-#ifndef CONFIG_ARCH_OMAP2430
 	omap2_init_memory();
-#endif
 	gpmc_init();
 }
Index: dev/include/asm-arm/arch-omap/io.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/io.h
+++ dev/include/asm-arm/arch-omap/io.h
@@ -80,6 +80,13 @@
 #define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE	/* 0x49000000 */
 #define OMAP243X_GPMC_VIRT	0xFE000000
 #define OMAP243X_GPMC_SIZE	SZ_1M
+#define OMAP243X_SDRC_PHYS      OMAP24XX_SDRC_BASE
+#define OMAP243X_SDRC_VIRT      0xFD000000
+#define OMAP243X_SDRC_SIZE      SZ_1M
+#define OMAP243X_SMS_PHYS       OMAP243X_SMS_BASE
+#define OMAP243X_SMS_VIRT       0xFC000000
+#define OMAP243X_SMS_SIZE       SZ_1M
+
 #endif
 
 #define IO_OFFSET	0x90000000
Index: dev/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/omap24xx.h
+++ dev/include/asm-arm/arch-omap/omap24xx.h
@@ -27,8 +27,9 @@
 #ifdef CONFIG_ARCH_OMAP2430
 #define OMAP24XX_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
 #define OMAP24XX_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
-#define OMAP24XX_SDRC_BASE	(0x6D000000)
 #define OMAP242X_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
+#define OMAP243X_SMS_BASE	0x6C000000
+#define OMAP24XX_SDRC_BASE	0x6D000000
 #define OMAP243X_GPMC_BASE	0x6E000000
 #endif
 
--
