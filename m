From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] Runtime constants: use runtime-computed SMS base
Date: Fri, 16 Nov 2007 16:22:02 -0700
Message-ID: <20071116232538.178535648@pwsan.com>
References: <20071116232159.713389488@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=mb-convert-omap2-sms-base.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Create a global variable, omap2_sms_base, that is initialized with the
appropriate SMS base address at runtime during architecture
initialization.  Convert users of the preprocessor define
OMAP2_SMS_BASE to use the runtime-computed address, and get rid of
OMAP2_SMS_BASE.  Create sms_{read,write}_reg() to handle register
access to these functions, located in arch/arm/mach-omap2/sdrc.h.
Define the only SMS register that we currently use, SMS_SYSCONFIG, in
include/asm-arm/arch-omap/sdrc.h, so it can be included in assembly
language files.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/memory.c         |    8 +++-----
 arch/arm/mach-omap2/sdrc.h           |   19 +++++++++++++++++++
 arch/arm/plat-omap/common.c          |    3 +++
 include/asm-arm/arch-omap/omap24xx.h |    2 --
 include/asm-arm/arch-omap/omap34xx.h |    5 ++---
 include/asm-arm/arch-omap/sdrc.h     |   16 +++++++++++++++-
 6 files changed, 42 insertions(+), 11 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/memory.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/memory.c	2007-11-16 16:18:26.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/memory.c	2007-11-16 16:18:28.000000000 -0700
@@ -32,9 +32,8 @@
 #include "memory.h"
 #include "sdrc.h"
 
-#define SMS_SYSCONFIG			(OMAP2_SMS_BASE + 0x010)
-
 unsigned long omap2_sdrc_base;
+unsigned long omap2_sms_base;
 
 static struct memory_timings mem_timings;
 static u32 curr_perf_level = CORE_CLK_SRC_DPLL_X2;
@@ -160,14 +159,13 @@
 {
 	u32 l;
 
-	l = omap_readl(SMS_SYSCONFIG);
+	l = sms_read_reg(SMS_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
-	omap_writel(l, SMS_SYSCONFIG);
+	sms_write_reg(l, SMS_SYSCONFIG);
 
 	l = sdrc_read_reg(SDRC_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
 	sdrc_write_reg(l, SDRC_SYSCONFIG);
-
 }
Index: linux-omap/arch/arm/mach-omap2/sdrc.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sdrc.h	2007-11-16 16:18:26.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/sdrc.h	2007-11-16 16:18:28.000000000 -0700
@@ -19,8 +19,11 @@
 #include <asm/arch/sdrc.h>
 
 extern unsigned long omap2_sdrc_base;
+extern unsigned long omap2_sms_base;
 
 #define OMAP_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_sdrc_base + reg)
+#define OMAP_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_sms_base + reg)
+
 
 /* SDRC global register get/set */
 
@@ -37,5 +40,21 @@
 	return __raw_readl(OMAP_SDRC_REGADDR(reg));
 }
 
+/* SMS global register get/set */
+
+static void __attribute__((unused)) sms_write_reg(u32 val, u16 reg)
+{
+	pr_debug("sms_write_reg: writing 0x%0x to 0x%0x\n", val,
+		 (u32)OMAP_SMS_REGADDR(reg));
+
+	__raw_writel(val, OMAP_SMS_REGADDR(reg));
+}
+
+static u32 __attribute__((unused)) sms_read_reg(u16 reg)
+{
+	return __raw_readl(OMAP_SMS_REGADDR(reg));
+}
+
+
 
 #endif
Index: linux-omap/include/asm-arm/arch-omap/sdrc.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/sdrc.h	2007-11-16 16:18:26.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/sdrc.h	2007-11-16 16:18:28.000000000 -0700
@@ -2,7 +2,7 @@
 #define ____ASM_ARCH_SDRC_H
 
 /*
- * OMAP2 SDRC register definitions
+ * OMAP2/3 SDRC/SMS register definitions
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Copyright (C) 2007 Nokia Corporation
@@ -62,4 +62,18 @@
 #define SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
 
 
+/*
+ * SMS register access
+ */
+
+
+#define OMAP242X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP2420_SMS_BASE + reg)
+#define OMAP243X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP243X_SMS_BASE + reg)
+#define OMAP343X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP343X_SMS_BASE + reg)
+
+/* SMS register offsets - read/write with sms_{read,write}_reg() */
+
+#define SMS_SYSCONFIG		0x010
+/* REVISIT: fill in other SMS registers here */
+
 #endif
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h	2007-11-16 16:18:26.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h	2007-11-16 16:18:28.000000000 -0700
@@ -83,7 +83,6 @@
 #define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2420_CM_BASE
 #define OMAP2_PRM_BASE		OMAP2420_PRM_BASE
-#define OMAP2_SMS_BASE		OMAP2420_SMS_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP2420_CTRL_BASE
 
@@ -93,7 +92,6 @@
 #define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2430_CM_BASE
 #define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
-#define OMAP2_SMS_BASE		OMAP243X_SMS_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
 
Index: linux-omap/include/asm-arm/arch-omap/omap34xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap34xx.h	2007-11-16 16:18:26.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/omap34xx.h	2007-11-16 16:18:28.000000000 -0700
@@ -45,8 +45,8 @@
 #define OMAP343X_SMS_BASE	0x6C000000
 #define OMAP343X_SDRC_BASE	0x6D000000
 #define OMAP34XX_GPMC_BASE	0x6E000000
-#define OMAP3430_SCM_BASE	0x48002000
-#define OMAP3430_CTRL_BASE	OMAP3430_SCM_BASE
+#define OMAP343X_SCM_BASE	0x48002000
+#define OMAP3430_CTRL_BASE	OMAP343X_SCM_BASE
 
 #define OMAP34XX_IC_BASE	0x48200000
 #define OMAP34XX_IVA_INTC_BASE	0x40000000
@@ -64,7 +64,6 @@
 #define OMAP2_32KSYNCT_BASE		OMAP3430_32KSYNCT_BASE
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
-#define OMAP2_SMS_BASE			OMAP343X_SMS_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
 #define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
 #define OMAP34XX_CONTROL_DEVCONF0	(L4_34XX_BASE + 0x2274)
Index: linux-omap/arch/arm/plat-omap/common.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/common.c	2007-11-16 16:18:26.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/common.c	2007-11-16 16:18:28.000000000 -0700
@@ -241,6 +241,7 @@
 void __init omap2_set_globals_242x(void)
 {
 	omap2_sdrc_base = OMAP2420_SDRC_BASE;
+	omap2_sms_base = OMAP2420_SMS_BASE;
 }
 #endif
 
@@ -248,6 +249,7 @@
 void __init omap2_set_globals_243x(void)
 {
 	omap2_sdrc_base = OMAP243X_SDRC_BASE;
+	omap2_sms_base = OMAP243X_SMS_BASE;
 }
 #endif
 
@@ -255,6 +257,7 @@
 void __init omap2_set_globals_343x(void)
 {
 	omap2_sdrc_base = OMAP343X_SDRC_BASE;
+	omap2_sms_base = OMAP343X_SMS_BASE;
 }
 #endif
 

-- 
