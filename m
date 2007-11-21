From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH RESEND 2/4] Runtime constants: use runtime-computed SDRC base
Date: Tue, 20 Nov 2007 17:16:22 -0700
Message-ID: <20071121002108.084787740@pwsan.com>
References: <20071121001620.571082090@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=mb-convert-omap2-sdrc-base.patch
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

Create a global variable, omap2_sdrc_base, that is initialized with
the appropriate SDRC base address at runtime during architecture
initialization.  Convert users of the preprocessor define,
OMAP2_SDRC_BASE, to use the runtime-computed address.  Create
sdrc_{read,write}_reg() to handle register access to these functions -
these live in a newly-created file, asm/arch/mach-omap2/sdrc.h.  Move
the SDRC register definitions into include/asm-arm/arch-omap/sdrc.h,
so they can be included in assembly language files.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/memory.c         |    2 +
 arch/arm/mach-omap2/sdrc.h           |   47 ++-----------------------
 arch/arm/plat-omap/common.c          |    7 +++
 include/asm-arm/arch-omap/omap24xx.h |    2 -
 include/asm-arm/arch-omap/omap34xx.h |    1 
 include/asm-arm/arch-omap/sdrc.h     |   65 +++++++++++++++++++++++++++++++++++
 6 files changed, 78 insertions(+), 46 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/sdrc.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sdrc.h	2007-11-20 17:10:21.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/sdrc.h	2007-11-20 17:12:46.000000000 -0700
@@ -13,23 +13,14 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
 
 #include <linux/kernel.h>
-#include <asm/arch/io.h>
+#include <asm/arch/sdrc.h>
 
+extern unsigned long omap2_sdrc_base;
 
-#define OMAP_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP2_SDRC_BASE + reg)
-
-/* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
-
-#define SDRC_SYSCONFIG		0x010
-#define SDRC_DLLA_CTRL		0x060
-#define SDRC_DLLA_STATUS	0x064
-#define SDRC_DLLB_CTRL		0x068
-#define SDRC_DLLB_STATUS	0x06C
-#define SDRC_POWER		0x070
-#define SDRC_MR_0		0x084
-#define SDRC_RFR_CTRL_0		0x0a4
+#define OMAP_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_sdrc_base + reg)
 
 /* SDRC global register get/set */
 
@@ -46,35 +37,5 @@
 	return __raw_readl(OMAP_SDRC_REGADDR(reg));
 }
 
-/*
- * These values represent the number of memory clock cycles between
- * autorefresh initiation.  They assume 1 refresh per 64 ms (JEDEC), 8192
- * rows per device, and include a subtraction of a 50 cycle window in the
- * event that the autorefresh command is delayed due to other SDRC activity.
- * The '| 1' sets the ARE field to send one autorefresh when the autorefresh
- * counter reaches 0.
- *
- * These represent optimal values for common parts, it won't work for all.
- * As long as you scale down, most parameters are still work, they just
- * become sub-optimal. The RFR value goes in the opposite direction. If you
- * don't adjust it down as your clock period increases the refresh interval
- * will not be met. Setting all parameters for complete worst case may work,
- * but may cut memory performance by 2x. Due to errata the DLLs need to be
- * unlocked and their value needs run time calibration.	A dynamic call is
- * need for that as no single right value exists acorss production samples.
- *
- * Only the FULL speed values are given. Current code is such that rate
- * changes must be made at DPLLoutx2. The actual value adjustment for low
- * frequency operation will be handled by omap_set_performance()
- *
- * By having the boot loader boot up in the fastest L4 speed available likely
- * will result in something which you can switch between.
- */
-#define SDRC_RFR_CTRL_165MHz	(0x00044c00 | 1)
-#define SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
-#define SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
-#define SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
-#define SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
-
 
 #endif
Index: linux-omap/arch/arm/mach-omap2/memory.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/memory.c	2007-11-20 17:10:21.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/memory.c	2007-11-20 17:12:46.000000000 -0700
@@ -34,6 +34,8 @@
 
 #define SMS_SYSCONFIG			(OMAP2_SMS_BASE + 0x010)
 
+unsigned long omap2_sdrc_base;
+
 static struct memory_timings mem_timings;
 static u32 curr_perf_level = CORE_CLK_SRC_DPLL_X2;
 
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h	2007-11-20 17:12:45.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h	2007-11-20 17:12:46.000000000 -0700
@@ -83,7 +83,6 @@
 #define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2420_CM_BASE
 #define OMAP2_PRM_BASE		OMAP2420_PRM_BASE
-#define OMAP2_SDRC_BASE		OMAP2420_SDRC_BASE
 #define OMAP2_SMS_BASE		OMAP2420_SMS_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP2420_CTRL_BASE
@@ -94,7 +93,6 @@
 #define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2430_CM_BASE
 #define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
-#define OMAP2_SDRC_BASE		OMAP243X_SDRC_BASE
 #define OMAP2_SMS_BASE		OMAP243X_SMS_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
Index: linux-omap/include/asm-arm/arch-omap/omap34xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap34xx.h	2007-11-20 17:12:45.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/omap34xx.h	2007-11-20 17:12:46.000000000 -0700
@@ -64,7 +64,6 @@
 #define OMAP2_32KSYNCT_BASE		OMAP3430_32KSYNCT_BASE
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
-#define OMAP2_SDRC_BASE			OMAP343X_SDRC_BASE
 #define OMAP2_SMS_BASE			OMAP343X_SMS_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
 #define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
Index: linux-omap/include/asm-arm/arch-omap/sdrc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/include/asm-arm/arch-omap/sdrc.h	2007-11-20 17:12:47.000000000 -0700
@@ -0,0 +1,65 @@
+#ifndef ____ASM_ARCH_SDRC_H
+#define ____ASM_ARCH_SDRC_H
+
+/*
+ * OMAP2 SDRC register definitions
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/arch/io.h>
+
+#define OMAP242X_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP242X_SDRC_BASE + reg)
+#define OMAP243X_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP243X_SDRC_BASE + reg)
+#define OMAP343X_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP343X_SDRC_BASE + reg)
+
+/* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
+
+#define SDRC_SYSCONFIG		0x010
+#define SDRC_DLLA_CTRL		0x060
+#define SDRC_DLLA_STATUS	0x064
+#define SDRC_DLLB_CTRL		0x068
+#define SDRC_DLLB_STATUS	0x06C
+#define SDRC_POWER		0x070
+#define SDRC_MR_0		0x084
+#define SDRC_RFR_CTRL_0		0x0a4
+
+/*
+ * These values represent the number of memory clock cycles between
+ * autorefresh initiation.  They assume 1 refresh per 64 ms (JEDEC), 8192
+ * rows per device, and include a subtraction of a 50 cycle window in the
+ * event that the autorefresh command is delayed due to other SDRC activity.
+ * The '| 1' sets the ARE field to send one autorefresh when the autorefresh
+ * counter reaches 0.
+ *
+ * These represent optimal values for common parts, it won't work for all.
+ * As long as you scale down, most parameters are still work, they just
+ * become sub-optimal. The RFR value goes in the opposite direction. If you
+ * don't adjust it down as your clock period increases the refresh interval
+ * will not be met. Setting all parameters for complete worst case may work,
+ * but may cut memory performance by 2x. Due to errata the DLLs need to be
+ * unlocked and their value needs run time calibration.	A dynamic call is
+ * need for that as no single right value exists acorss production samples.
+ *
+ * Only the FULL speed values are given. Current code is such that rate
+ * changes must be made at DPLLoutx2. The actual value adjustment for low
+ * frequency operation will be handled by omap_set_performance()
+ *
+ * By having the boot loader boot up in the fastest L4 speed available likely
+ * will result in something which you can switch between.
+ */
+#define SDRC_RFR_CTRL_165MHz	(0x00044c00 | 1)
+#define SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
+#define SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
+#define SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
+#define SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
+
+
+#endif
Index: linux-omap/arch/arm/plat-omap/common.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/common.c	2007-11-20 17:12:45.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/common.c	2007-11-20 17:12:47.000000000 -0700
@@ -32,6 +32,10 @@
 
 #include <asm/arch/clock.h>
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+# include "../mach-omap2/sdrc.h"
+#endif
+
 #define NO_LENGTH_CHECK 0xffffffff
 
 unsigned char omap_bootloader_tag[512];
@@ -236,18 +240,21 @@
 #if defined(CONFIG_ARCH_OMAP2420)
 void __init omap2_set_globals_242x(void)
 {
+	omap2_sdrc_base = OMAP2420_SDRC_BASE;
 }
 #endif
 
 #if defined(CONFIG_ARCH_OMAP2430)
 void __init omap2_set_globals_243x(void)
 {
+	omap2_sdrc_base = OMAP243X_SDRC_BASE;
 }
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3430)
 void __init omap2_set_globals_343x(void)
 {
+	omap2_sdrc_base = OMAP343X_SDRC_BASE;
 }
 #endif
 

-- 
