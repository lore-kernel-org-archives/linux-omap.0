From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/13] ARM: OMAP2+: common: remove mach-omap2/common.c and
 map_common_io code
Date: Thu, 25 Oct 2012 17:21:13 -0600
Message-ID: <20121025232111.17558.10543.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38275 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2JYXYC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:02 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Get rid of mach-omap2/common.c by moving the global initialization for
IP block addresses that must occur early into mach-omap2/io.c.  In the
process, remove the *_map_common_io*() and SoC-specific *set_globals*
functions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile           |    2 
 arch/arm/mach-omap2/am33xx.h           |    1 
 arch/arm/mach-omap2/common.c           |  202 --------------------------------
 arch/arm/mach-omap2/common.h           |  104 ++--------------
 arch/arm/mach-omap2/control.c          |   10 +-
 arch/arm/mach-omap2/control.h          |    2 
 arch/arm/mach-omap2/id.c               |    7 +
 arch/arm/mach-omap2/io.c               |   78 ++++++++++--
 arch/arm/mach-omap2/omap4-common.c     |    1 
 arch/arm/mach-omap2/prcm.c             |   15 +-
 arch/arm/mach-omap2/sdrc.c             |    8 -
 arch/arm/mach-omap2/sdrc.h             |    3 
 arch/arm/mach-omap2/ti81xx.h           |    9 +
 arch/arm/plat-omap/include/plat/prcm.h |    5 +
 14 files changed, 115 insertions(+), 332 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/common.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f7cf382..7a628e7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o
+	 gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o
 
 omap-2-3-common				= irq.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/am33xx.h b/arch/arm/mach-omap2/am33xx.h
index 06c19bb..43296c1 100644
--- a/arch/arm/mach-omap2/am33xx.h
+++ b/arch/arm/mach-omap2/am33xx.h
@@ -21,5 +21,6 @@
 #define AM33XX_SCM_BASE		0x44E10000
 #define AM33XX_CTRL_BASE	AM33XX_SCM_BASE
 #define AM33XX_PRCM_BASE	0x44E00000
+#define AM33XX_TAP_BASE		(AM33XX_CTRL_BASE + 0x3FC)
 
 #endif /* __ASM_ARCH_AM33XX_H */
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
deleted file mode 100644
index 17950c6..0000000
--- a/arch/arm/mach-omap2/common.c
+++ /dev/null
@@ -1,202 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/common.c
- *
- * Code common to all OMAP2+ machines.
- *
- * Copyright (C) 2009 Texas Instruments
- * Copyright (C) 2010 Nokia Corporation
- * Tony Lindgren <tony@atomide.com>
- * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <plat/clock.h>
-
-#include "soc.h"
-#include "iomap.h"
-#include "common.h"
-#include "sdrc.h"
-#include "control.h"
-
-/* Global address base setup code */
-
-static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
-{
-	omap2_set_globals_tap(omap2_globals);
-	omap2_set_globals_sdrc(omap2_globals);
-	omap2_set_globals_control(omap2_globals);
-	omap2_set_globals_prcm(omap2_globals);
-}
-
-#if defined(CONFIG_SOC_OMAP2420)
-
-static struct omap_globals omap242x_globals = {
-	.class	= OMAP242X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(0x48014000),
-	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
-	.sms	= OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
-};
-
-void __init omap2_set_globals_242x(void)
-{
-	__omap2_set_globals(&omap242x_globals);
-}
-
-void __init omap242x_map_io(void)
-{
-	omap242x_map_common_io();
-}
-#endif
-
-#if defined(CONFIG_SOC_OMAP2430)
-
-static struct omap_globals omap243x_globals = {
-	.class	= OMAP243X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(0x4900a000),
-	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
-	.sms	= OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
-};
-
-void __init omap2_set_globals_243x(void)
-{
-	__omap2_set_globals(&omap243x_globals);
-}
-
-void __init omap243x_map_io(void)
-{
-	omap243x_map_common_io();
-}
-#endif
-
-#if defined(CONFIG_ARCH_OMAP3)
-
-static struct omap_globals omap3_globals = {
-	.class	= OMAP343X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(0x4830A000),
-	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
-	.sms	= OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
-};
-
-void __init omap2_set_globals_3xxx(void)
-{
-	__omap2_set_globals(&omap3_globals);
-}
-
-void __init omap3_map_io(void)
-{
-	omap34xx_map_common_io();
-}
-
-/*
- * Adjust TAP register base such that omap3_check_revision accesses the correct
- * TI81XX register for checking device ID (it adds 0x204 to tap base while
- * TI81XX DEVICE ID register is at offset 0x600 from control base).
- */
-#define TI81XX_TAP_BASE		(TI81XX_CTRL_BASE + \
-				TI81XX_CONTROL_DEVICE_ID - 0x204)
-
-static struct omap_globals ti81xx_globals = {
-	.class  = OMAP343X_CLASS,
-	.tap    = OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE),
-	.ctrl   = OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
-	.prm    = OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE),
-	.cm     = OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE),
-};
-
-void __init omap2_set_globals_ti81xx(void)
-{
-	__omap2_set_globals(&ti81xx_globals);
-}
-
-void __init ti81xx_map_io(void)
-{
-	omapti81xx_map_common_io();
-}
-#endif
-
-#if defined(CONFIG_SOC_AM33XX)
-#define AM33XX_TAP_BASE		(AM33XX_CTRL_BASE + \
-				TI81XX_CONTROL_DEVICE_ID - 0x204)
-
-static struct omap_globals am33xx_globals = {
-	.class  = AM335X_CLASS,
-	.tap    = AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE),
-	.ctrl   = AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
-	.prm    = AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE),
-	.cm     = AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE),
-};
-
-void __init omap2_set_globals_am33xx(void)
-{
-	__omap2_set_globals(&am33xx_globals);
-}
-
-void __init am33xx_map_io(void)
-{
-	omapam33xx_map_common_io();
-}
-#endif
-
-#if defined(CONFIG_ARCH_OMAP4)
-static struct omap_globals omap4_globals = {
-	.class	= OMAP443X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-	.ctrl_pad	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
-	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
-	.prcm_mpu	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
-};
-
-void __init omap2_set_globals_443x(void)
-{
-	__omap2_set_globals(&omap4_globals);
-}
-
-void __init omap4_map_io(void)
-{
-	omap44xx_map_common_io();
-}
-#endif
-
-#if defined(CONFIG_SOC_OMAP5)
-static struct omap_globals omap5_globals = {
-	.class	= OMAP54XX_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
-	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
-	.ctrl_pad	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE),
-	.prm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE),
-	.cm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
-	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE),
-	.prcm_mpu = OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE),
-};
-
-void __init omap2_set_globals_5xxx(void)
-{
-	omap2_set_globals_tap(&omap5_globals);
-	omap2_set_globals_control(&omap5_globals);
-	omap2_set_globals_prcm(&omap5_globals);
-}
-
-void __init omap5_map_io(void)
-{
-	omap5_map_common_io();
-}
-#endif
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 7045e4d..320f0d7 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -38,54 +38,6 @@
 
 #define OMAP_INTC_START		NR_IRQS
 
-#ifdef CONFIG_SOC_OMAP2420
-extern void omap242x_map_common_io(void);
-#else
-static inline void omap242x_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_SOC_OMAP2430
-extern void omap243x_map_common_io(void);
-#else
-static inline void omap243x_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-extern void omap34xx_map_common_io(void);
-#else
-static inline void omap34xx_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_SOC_TI81XX
-extern void omapti81xx_map_common_io(void);
-#else
-static inline void omapti81xx_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_SOC_AM33XX
-extern void omapam33xx_map_common_io(void);
-#else
-static inline void omapam33xx_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-extern void omap44xx_map_common_io(void);
-#else
-static inline void omap44xx_map_common_io(void)
-{
-}
-#endif
-
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP2)
 int omap2_pm_init(void);
 #else
@@ -164,50 +116,18 @@ void omap4430_init_late(void);
 int omap2_common_pm_late_init(void);
 void omap_prcm_restart(char, const char *);
 
-/*
- * IO bases for various OMAP processors
- * Except the tap base, rest all the io bases
- * listed are physical addresses.
- */
-struct omap_globals {
-	u32		class;		/* OMAP class to detect */
-	void __iomem	*tap;		/* Control module ID code */
-	void __iomem	*sdrc;           /* SDRAM Controller */
-	void __iomem	*sms;            /* SDRAM Memory Scheduler */
-	void __iomem	*ctrl;           /* System Control Module */
-	void __iomem	*ctrl_pad;	/* PAD Control Module */
-	void __iomem	*prm;            /* Power and Reset Management */
-	void __iomem	*cm;             /* Clock Management */
-	void __iomem	*cm2;
-	void __iomem	*prcm_mpu;
-};
-
-void omap2_set_globals_242x(void);
-void omap2_set_globals_243x(void);
-void omap2_set_globals_3xxx(void);
-void omap2_set_globals_443x(void);
-void omap2_set_globals_5xxx(void);
-void omap2_set_globals_ti81xx(void);
-void omap2_set_globals_am33xx(void);
-
-/* These get called from omap2_set_globals_xxxx(), do not call these */
-void omap2_set_globals_tap(struct omap_globals *);
-#if defined(CONFIG_SOC_HAS_OMAP2_SDRC)
-void omap2_set_globals_sdrc(struct omap_globals *);
-#else
-static inline void omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
-{ }
-#endif
-void omap2_set_globals_control(struct omap_globals *);
-void omap2_set_globals_prcm(struct omap_globals *);
-
-void omap242x_map_io(void);
-void omap243x_map_io(void);
-void omap3_map_io(void);
-void am33xx_map_io(void);
-void omap4_map_io(void);
-void omap5_map_io(void);
-void ti81xx_map_io(void);
+/* This gets called from mach-omap2/io.c, do not call this */
+void __init omap2_set_globals_tap(u32 class, void __iomem *tap);
+
+void __init omap242x_map_io(void);
+void __init omap243x_map_io(void);
+void __init omap3_map_io(void);
+void __init am33xx_map_io(void);
+void __init omap4_map_io(void);
+void __init omap5_map_io(void);
+void __init ti81xx_map_io(void);
+
+/* omap_barriers_init() is OMAP4 only */
 void omap_barriers_init(void);
 
 /**
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a7d1eb8..ef0a044 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -149,13 +149,11 @@ static struct omap3_control_regs control_context;
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 #define OMAP4_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
 
-void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
+void __init omap2_set_globals_control(void __iomem *ctrl,
+				      void __iomem *ctrl_pad)
 {
-	if (omap2_globals->ctrl)
-		omap2_ctrl_base = omap2_globals->ctrl;
-
-	if (omap2_globals->ctrl_pad)
-		omap4_ctrl_pad_base = omap2_globals->ctrl_pad;
+	omap2_ctrl_base = ctrl;
+	omap4_ctrl_pad_base = ctrl_pad;
 }
 
 void __iomem *omap_ctrl_base_get(void)
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a89e825..4ca8747 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -414,6 +414,8 @@ extern void omap_ctrl_write_dsp_boot_addr(u32 bootaddr);
 extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
+extern void omap2_set_globals_control(void __iomem *ctrl,
+				      void __iomem *ctrl_pad);
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index cf2362c..f1e1215 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -559,11 +559,12 @@ void __init omap5xxx_check_revision(void)
  * detect the exact revision later on in omap2_detect_revision() once map_io
  * is done.
  */
-void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
+void __init omap2_set_globals_tap(u32 class, void __iomem *tap)
 {
-	omap_revision = omap2_globals->class;
-	tap_base = omap2_globals->tap;
+	omap_revision = class;
+	tap_base = tap;
 
+	/* XXX What is this intended to do? */
 	if (cpu_is_omap34xx())
 		tap_prod_id = 0x0210;
 	else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4234d28..b853401 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -32,6 +32,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
 #include <plat/dma.h>
+#include <plat/prcm.h>
 
 #include "soc.h"
 #include "iomap.h"
@@ -43,6 +44,8 @@
 #include "clock2xxx.h"
 #include "clock3xxx.h"
 #include "clock44xx.h"
+#include "sdrc.h"
+#include "control.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -265,7 +268,7 @@ static struct map_desc omap54xx_io_desc[] __initdata = {
 #endif
 
 #ifdef CONFIG_SOC_OMAP2420
-void __init omap242x_map_common_io(void)
+void __init omap242x_map_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
@@ -273,7 +276,7 @@ void __init omap242x_map_common_io(void)
 #endif
 
 #ifdef CONFIG_SOC_OMAP2430
-void __init omap243x_map_common_io(void)
+void __init omap243x_map_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
@@ -281,28 +284,28 @@ void __init omap243x_map_common_io(void)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-void __init omap34xx_map_common_io(void)
+void __init omap3_map_io(void)
 {
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
 }
 #endif
 
 #ifdef CONFIG_SOC_TI81XX
-void __init omapti81xx_map_common_io(void)
+void __init ti81xx_map_io(void)
 {
 	iotable_init(omapti81xx_io_desc, ARRAY_SIZE(omapti81xx_io_desc));
 }
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-void __init omapam33xx_map_common_io(void)
+void __init am33xx_map_io(void)
 {
 	iotable_init(omapam33xx_io_desc, ARRAY_SIZE(omapam33xx_io_desc));
 }
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-void __init omap44xx_map_common_io(void)
+void __init omap4_map_io(void)
 {
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
 	omap_barriers_init();
@@ -310,7 +313,7 @@ void __init omap44xx_map_common_io(void)
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
-void __init omap5_map_common_io(void)
+void __init omap5_map_io(void)
 {
 	iotable_init(omap54xx_io_desc, ARRAY_SIZE(omap54xx_io_desc));
 }
@@ -377,7 +380,14 @@ static void __init omap_hwmod_init_postsetup(void)
 #ifdef CONFIG_SOC_OMAP2420
 void __init omap2420_init_early(void)
 {
-	omap2_set_globals_242x();
+	omap2_set_globals_tap(OMAP242X_CLASS, OMAP2_L4_IO_ADDRESS(0x48014000));
+	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
+			       OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
+				  NULL);
+	omap2_set_globals_prcm(OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
+			       NULL, NULL);
 	omap2xxx_check_revision();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
@@ -399,7 +409,14 @@ void __init omap2420_init_late(void)
 #ifdef CONFIG_SOC_OMAP2430
 void __init omap2430_init_early(void)
 {
-	omap2_set_globals_243x();
+	omap2_set_globals_tap(OMAP243X_CLASS, OMAP2_L4_IO_ADDRESS(0x4900a000));
+	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
+			       OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
+				  NULL);
+	omap2_set_globals_prcm(OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
+			       NULL, NULL);
 	omap2xxx_check_revision();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
@@ -425,7 +442,14 @@ void __init omap2430_init_late(void)
 #ifdef CONFIG_ARCH_OMAP3
 void __init omap3_init_early(void)
 {
-	omap2_set_globals_3xxx();
+	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
+	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
+			       OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
+				  NULL);
+	omap2_set_globals_prcm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
+			       NULL, NULL);
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
 	omap_common_init_early();
@@ -459,7 +483,13 @@ void __init am35xx_init_early(void)
 
 void __init ti81xx_init_early(void)
 {
-	omap2_set_globals_ti81xx();
+	omap2_set_globals_tap(OMAP343X_CLASS,
+			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
+				  NULL);
+	omap2_set_globals_prcm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE),
+			       OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE),
+			       NULL, NULL);
 	omap3xxx_check_revision();
 	ti81xx_check_features();
 	omap_common_init_early();
@@ -517,7 +547,13 @@ void __init ti81xx_init_late(void)
 #ifdef CONFIG_SOC_AM33XX
 void __init am33xx_init_early(void)
 {
-	omap2_set_globals_am33xx();
+	omap2_set_globals_tap(AM335X_CLASS,
+			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
+	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
+				  NULL);
+	omap2_set_globals_prcm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE),
+			       AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE),
+			       NULL, NULL);
 	omap3xxx_check_revision();
 	ti81xx_check_features();
 	omap_common_init_early();
@@ -533,7 +569,14 @@ void __init am33xx_init_early(void)
 #ifdef CONFIG_ARCH_OMAP4
 void __init omap4430_init_early(void)
 {
-	omap2_set_globals_443x();
+	omap2_set_globals_tap(OMAP443X_CLASS,
+			      OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
+				  OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE));
+	omap2_set_globals_prcm(OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
 	omap_common_init_early();
@@ -556,7 +599,14 @@ void __init omap4430_init_late(void)
 #ifdef CONFIG_SOC_OMAP5
 void __init omap5_init_early(void)
 {
-	omap2_set_globals_5xxx();
+	omap2_set_globals_tap(OMAP54XX_CLASS,
+			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
+				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
+	omap2_set_globals_prcm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE),
+			       OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap5xxx_check_revision();
 	omap_common_init_early();
 }
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index e1f2897..6560e99 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -32,6 +32,7 @@
 #include "omap-wakeupgen.h"
 
 #include "soc.h"
+#include "iomap.h"
 #include "common.h"
 #include "hsmmc.h"
 #include "omap4-sar-layout.h"
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 0a2c33b..118dc87 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -136,16 +136,13 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 	return (i < MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
 };
 
-void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
+void __init omap2_set_globals_prcm(void __iomem *prm, void __iomem *cm,
+				   void __iomem *cm2, void __iomem *prcm_mpu)
 {
-	if (omap2_globals->prm)
-		prm_base = omap2_globals->prm;
-	if (omap2_globals->cm)
-		cm_base = omap2_globals->cm;
-	if (omap2_globals->cm2)
-		cm2_base = omap2_globals->cm2;
-	if (omap2_globals->prcm_mpu)
-		prcm_mpu_base = omap2_globals->prcm_mpu;
+	prm_base = prm;
+	cm_base = cm;
+	cm2_base = cm2;
+	prcm_mpu_base = prcm_mpu;
 
 	if (cpu_is_omap44xx() || soc_is_omap54xx()) {
 		omap_prm_base_init();
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index e3d345f..2ff0891 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -115,12 +115,10 @@ int omap2_sdrc_get_params(unsigned long r,
 }
 
 
-void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
+void __init omap2_set_globals_sdrc(void __iomem *sdrc, void __iomem *sms)
 {
-	if (omap2_globals->sdrc)
-		omap2_sdrc_base = omap2_globals->sdrc;
-	if (omap2_globals->sms)
-		omap2_sms_base = omap2_globals->sms;
+	omap2_sdrc_base = sdrc;
+	omap2_sms_base = sms;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index b3f8379..06ebd6e5 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -50,6 +50,9 @@ static inline u32 sms_read_reg(u16 reg)
 {
 	return __raw_readl(OMAP_SMS_REGADDR(reg));
 }
+
+extern void omap2_set_globals_sdrc(void __iomem *sdrc, void __iomem *sms);
+
 #else
 #define OMAP242X_SDRC_REGADDR(reg)					\
 			OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
diff --git a/arch/arm/mach-omap2/ti81xx.h b/arch/arm/mach-omap2/ti81xx.h
index 8f9843f..a1e6caf 100644
--- a/arch/arm/mach-omap2/ti81xx.h
+++ b/arch/arm/mach-omap2/ti81xx.h
@@ -22,6 +22,15 @@
 #define TI81XX_CTRL_BASE	TI81XX_SCM_BASE
 #define TI81XX_PRCM_BASE	0x48180000
 
+/*
+ * Adjust TAP register base such that omap3_check_revision accesses the correct
+ * TI81XX register for checking device ID (it adds 0x204 to tap base while
+ * TI81XX DEVICE ID register is at offset 0x600 from control base).
+ */
+#define TI81XX_TAP_BASE		(TI81XX_CTRL_BASE + \
+				 TI81XX_CONTROL_DEVICE_ID - 0x204)
+
+
 #define TI81XX_ARM_INTC_BASE	0x48200000
 
 #endif /* __ASM_ARCH_TI81XX_H */
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index a76cbd4..a950a83 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -27,8 +27,13 @@
 #ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
 #define __ASM_ARM_ARCH_OMAP_PRCM_H
 
+#include <linux/kernel.h>
+#include <linux/io.h>
+
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 			 const char *name);
+void __init omap2_set_globals_prcm(void __iomem *prm, void __iomem *cm,
+				   void __iomem *cm2, void __iomem *prcm_mpu);
 
 #endif
 


