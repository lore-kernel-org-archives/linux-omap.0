From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP2/3/4: Convert bases in omap_globals to physical address
Date: Tue, 26 Jan 2010 14:10:09 +0530
Message-ID: <1264495210-17344-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52205 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab0AZIkT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 03:40:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This is a clean-up patch towards dynamic allocation of IO space
instead of using harcoded macros to calculate virtual addresses.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/common.c                |   46 ++++++++++++++--------------
 arch/arm/plat-omap/include/plat/common.h   |   14 ++++----
 arch/arm/plat-omap/include/plat/omap24xx.h |    2 +
 arch/arm/plat-omap/include/plat/omap34xx.h |    1 +
 4 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index bf1eaf3..d1ed69c 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -227,12 +227,12 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 
 static struct omap_globals omap242x_globals = {
 	.class	= OMAP242X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(0x48014000),
-	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
-	.sms	= OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP2420_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
+	.tap	= OMAP2420_IDCODE_BASE,
+	.sdrc	= OMAP2420_SDRC_BASE,
+	.sms	= OMAP2420_SMS_BASE,
+	.ctrl	= OMAP2420_CTRL_BASE,
+	.prm	= OMAP2420_PRM_BASE,
+	.cm	= OMAP2420_CM_BASE,
 };
 
 void __init omap2_set_globals_242x(void)
@@ -245,12 +245,12 @@ void __init omap2_set_globals_242x(void)
 
 static struct omap_globals omap243x_globals = {
 	.class	= OMAP243X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(0x4900a000),
-	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
-	.sms	= OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
+	.tap	= OMAP243X_IDCODE_BASE,
+	.sdrc	= OMAP243X_SDRC_BASE,
+	.sms	= OMAP243X_SMS_BASE,
+	.ctrl	= OMAP243X_CTRL_BASE,
+	.prm	= OMAP2430_PRM_BASE,
+	.cm	= OMAP2430_CM_BASE,
 };
 
 void __init omap2_set_globals_243x(void)
@@ -263,12 +263,12 @@ void __init omap2_set_globals_243x(void)
 
 static struct omap_globals omap343x_globals = {
 	.class	= OMAP343X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(0x4830A000),
-	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
-	.sms	= OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
+	.tap	= OMAP343X_IDCODE_BASE,
+	.sdrc	= OMAP343X_SDRC_BASE,
+	.sms	= OMAP343X_SMS_BASE,
+	.ctrl	= OMAP343X_CTRL_BASE,
+	.prm	= OMAP3430_PRM_BASE,
+	.cm	= OMAP3430_CM_BASE,
 };
 
 void __init omap2_set_globals_343x(void)
@@ -280,11 +280,11 @@ void __init omap2_set_globals_343x(void)
 #if defined(CONFIG_ARCH_OMAP4)
 static struct omap_globals omap4_globals = {
 	.class	= OMAP443X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
-	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
+	.tap	= OMAP443X_SCM_BASE,
+	.ctrl	= OMAP443X_CTRL_BASE,
+	.prm	= OMAP4430_PRM_BASE,
+	.cm	= OMAP4430_CM_BASE,
+	.cm2	= OMAP4430_CM2_BASE,
 };
 
 void __init omap2_set_globals_443x(void)
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 32c2227..c486fda 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -40,13 +40,13 @@ extern struct sys_timer omap_timer;
 /* IO bases for various OMAP processors */
 struct omap_globals {
 	u32		class;		/* OMAP class to detect */
-	void __iomem	*tap;		/* Control module ID code */
-	void __iomem	*sdrc;		/* SDRAM Controller */
-	void __iomem	*sms;		/* SDRAM Memory Scheduler */
-	void __iomem	*ctrl;		/* System Control Module */
-	void __iomem	*prm;		/* Power and Reset Management */
-	void __iomem	*cm;		/* Clock Management */
-	void __iomem	*cm2;
+	unsigned long	tap;		/* Control module ID code */
+	unsigned long	sdrc;		/* SDRAM Controller */
+	unsigned long	sms;		/* SDRAM Memory Scheduler */
+	unsigned long	ctrl;		/* System Control Module */
+	unsigned long	prm;		/* Power and Reset Management */
+	unsigned long	cm;		/* Clock Management */
+	unsigned long	cm2;
 };
 
 void omap2_set_globals_242x(void);
diff --git a/arch/arm/plat-omap/include/plat/omap24xx.h b/arch/arm/plat-omap/include/plat/omap24xx.h
index 696edfc..c04a5d7 100644
--- a/arch/arm/plat-omap/include/plat/omap24xx.h
+++ b/arch/arm/plat-omap/include/plat/omap24xx.h
@@ -48,6 +48,7 @@
 #define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
 #define OMAP2420_SMS_BASE	0x68008000
 #define OMAP2420_GPMC_BASE	0x6800a000
+#define OMAP2420_IDCODE_BASE	0x48014000
 
 #define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
 #define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
@@ -60,6 +61,7 @@
 #define OMAP243X_SCM_BASE	(L4_WK_243X_BASE + 0x2000)
 #define OMAP243X_CTRL_BASE	OMAP243X_SCM_BASE
 #define OMAP243X_HS_BASE	(L4_24XX_BASE + 0x000ac000)
+#define OMAP243X_IDCODE_BASE	0x4900a000
 
 /* DSP SS */
 #define OMAP2420_DSP_BASE	0x58000000
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index 077f059..e5cc8d2 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -43,6 +43,7 @@
 #define OMAP34XX_GPMC_BASE	0x6E000000
 #define OMAP343X_SCM_BASE	0x48002000
 #define OMAP343X_CTRL_BASE	OMAP343X_SCM_BASE
+#define OMAP343X_IDCODE_BASE	0x4830a000
 
 #define OMAP34XX_IC_BASE	0x48200000
 
-- 
1.6.0.4

