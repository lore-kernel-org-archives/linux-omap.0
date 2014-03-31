From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 48/55] ARM: OMAP2+: move prm.h header to public location
Date: Mon, 31 Mar 2014 18:16:27 +0300
Message-ID: <1396278994-12624-49-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49919 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbaCaPTA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:19:00 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c                 |    2 +-
 arch/arm/mach-omap2/cpuidle44xx.c                |    2 +-
 arch/arm/mach-omap2/display.c                    |    2 +-
 arch/arm/mach-omap2/hdq1w.c                      |    2 +-
 arch/arm/mach-omap2/i2c.c                        |    3 +-
 arch/arm/mach-omap2/io.c                         |    2 +-
 arch/arm/mach-omap2/msdi.c                       |    2 +-
 arch/arm/mach-omap2/mux.c                        |    3 +-
 arch/arm/mach-omap2/omap_hwmod.c                 |    2 +-
 arch/arm/mach-omap2/powerdomain.c                |    2 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/prm-regbits-33xx.h           |    2 +-
 arch/arm/mach-omap2/prm.h                        |  164 ----------------------
 arch/arm/mach-omap2/prm2xxx.h                    |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx_private.h       |    2 +-
 arch/arm/mach-omap2/prm33xx.c                    |    2 +-
 arch/arm/mach-omap2/prm33xx.h                    |    2 +-
 arch/arm/mach-omap2/prm3xxx.h                    |    2 +-
 arch/arm/mach-omap2/prm44xx.c                    |    2 +-
 arch/arm/mach-omap2/prm44xx.h                    |    2 +-
 arch/arm/mach-omap2/prm54xx.h                    |    2 +-
 arch/arm/mach-omap2/prm7xx.h                     |    2 +-
 arch/arm/mach-omap2/prm_common.c                 |    2 +-
 arch/arm/mach-omap2/prminst44xx.c                |    2 +-
 arch/arm/mach-omap2/wd_timer.c                   |    2 +-
 include/linux/power/omap/prm.h                   |  164 ++++++++++++++++++++++
 26 files changed, 189 insertions(+), 189 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/prm.h
 create mode 100644 include/linux/power/omap/prm.h

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 5ebd8e3..0fd50d7 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -21,7 +21,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include "clockdomain.h"
 #include <linux/power/omap/cm.h>
 #include "cm1_44xx.h"
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 4c158c8..4324e4e 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -20,7 +20,7 @@
 
 #include "common.h"
 #include "pm.h"
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include "clockdomain.h"
 
 /* Machine specific information */
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 4cf1655..64a1331 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/power/omap/prm.h>
 
 #include <video/omapdss.h>
 #include "omap_hwmod.h"
@@ -34,7 +35,6 @@
 #include "iomap.h"
 #include "control.h"
 #include "display.h"
-#include "prm.h"
 
 #define DISPC_CONTROL		0x0040
 #define DISPC_CONTROL2		0x0238
diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index cbc8e3c..4bbc313 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -26,13 +26,13 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/power/omap/prm.h>
 
 #include "soc.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include "hdq1w.h"
 
-#include "prm.h"
 #include "common.h"
 
 /**
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index b456b44..b8f9dd5 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -19,12 +19,13 @@
  *
  */
 
+#include <linux/power/omap/prm.h>
+
 #include "soc.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include "omap-pm.h"
 
-#include "prm.h"
 #include "common.h"
 #include "mux.h"
 #include "i2c.h"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 96d498f..e9f7db9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -45,7 +45,7 @@
 #include "sram.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/cm.h>
 #include "prcm_mpu44xx.h"
 #include <linux/power/omap/cm44xx.h>
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index 828e0db..5abf695 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -24,8 +24,8 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/power/omap/prm.h>
 
-#include "prm.h"
 #include "common.h"
 #include "control.h"
 #include "omap_hwmod.h"
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 48094b5..8e865eb 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -34,14 +34,13 @@
 #include <linux/uaccess.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-
+#include <linux/power/omap/prm.h>
 
 #include "omap_hwmod.h"
 
 #include "soc.h"
 #include "control.h"
 #include "mux.h"
-#include "prm.h"
 #include "common.h"
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 096c43d..df0c2a0 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -155,7 +155,7 @@
 #include "cm3xxx.h"
 #include <linux/power/omap/cm44xx.h>
 #include "cm33xx.h"
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include "prm3xxx.h"
 #include "prm44xx.h"
 #include "prm33xx.h"
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index a29d50c..7262b3d 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -29,7 +29,7 @@
 
 #include <asm/cpu.h>
 
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "voltage.h"
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index 57abec8..823bc4d 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -34,7 +34,7 @@
 #include "powerdomain.h"
 
 #include <linux/power/omap/prcm-common.h>
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 
 /* OMAP2/3-common powerdomains */
 
diff --git a/arch/arm/mach-omap2/prm-regbits-33xx.h b/arch/arm/mach-omap2/prm-regbits-33xx.h
index 84feece..70d22b6 100644
--- a/arch/arm/mach-omap2/prm-regbits-33xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-33xx.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
 
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 
 #define AM33XX_GFX_MEM_ONSTATE_MASK			(0x3 << 17)
 #define AM33XX_GFX_MEM_RETSTATE_MASK			(1 << 6)
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
deleted file mode 100644
index 6a02cf3..0000000
--- a/arch/arm/mach-omap2/prm.h
+++ /dev/null
@@ -1,164 +0,0 @@
-/*
- * OMAP2/3/4 Power/Reset Management (PRM) bitfield definitions
- *
- * Copyright (C) 2007-2009, 2012 Texas Instruments, Inc.
- * Copyright (C) 2010 Nokia Corporation
- *
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ARCH_ARM_MACH_OMAP2_PRM_H
-#define __ARCH_ARM_MACH_OMAP2_PRM_H
-
-#include <linux/power/omap/prcm-common.h>
-
-# ifndef __ASSEMBLER__
-extern void __iomem *prm_base;
-extern u16 prm_dev_inst;
-extern u16 prm_features;
-extern void omap2_set_globals_prm(void __iomem *prm);
-int of_prcm_init(void);
-# endif
-
-/*
- * prm_features flag values
- *
- * PRM_HAS_IO_WAKEUP: has IO wakeup capability
- * PRM_HAS_VOLTAGE: has voltage domains
- */
-#define PRM_HAS_IO_WAKEUP	(1 << 0)
-#define PRM_HAS_VOLTAGE		(1 << 1)
-
-#ifndef __ASSEMBLER__
-enum {
-	PRM_OMAP3430 = 0,
-	PRM_OMAP3630,
-	PRM_OMAP3_OTHER,
-	PRM_OMAP4,
-	PRM_OMAP5,
-	PRM_DRA7,
-};
-#endif
-
-/*
- * MAX_MODULE_SOFTRESET_WAIT: Maximum microseconds to wait for OMAP
- * module to softreset
- */
-#define MAX_MODULE_SOFTRESET_WAIT		10000
-
-/*
- * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
- * submodule to exit hardreset
- */
-#define MAX_MODULE_HARDRESET_WAIT		10000
-
-/*
- * Register bitfields
- */
-
-/*
- * 24XX: PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP
- *
- * 2430: PM_PWSTST_MDM
- *
- * 3430: PM_PWSTST_IVA2, PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_GFX,
- *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
- *	 PM_PWSTST_NEON
- */
-#define OMAP_INTRANSITION_MASK				(1 << 20)
-
-
-/*
- * 24XX: PM_PWSTST_GFX, PM_PWSTST_DSP
- *
- * 2430: PM_PWSTST_MDM
- *
- * 3430: PM_PWSTST_IVA2, PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_GFX,
- *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
- *	 PM_PWSTST_NEON
- */
-#define OMAP_POWERSTATEST_SHIFT				0
-#define OMAP_POWERSTATEST_MASK				(0x3 << 0)
-
-/*
- * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
- *       PM_PWSTCTRL_DSP, PM_PWSTST_MPU
- *
- * 2430: PM_PWSTCTRL_MDM shared bits
- *
- * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE,
- *	 PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
- *	 PM_PWSTCTRL_NEON shared bits
- */
-#define OMAP_POWERSTATE_SHIFT				0
-#define OMAP_POWERSTATE_MASK				(0x3 << 0)
-
-/*
- * Standardized OMAP reset source bits
- *
- * To the extent these happen to match the hardware register bit
- * shifts, it's purely coincidental.  Used by omap-wdt.c.
- * OMAP_UNKNOWN_RST_SRC_ID_SHIFT is a special value, used whenever
- * there are any bits remaining in the global PRM_RSTST register that
- * haven't been identified, or when the PRM code for the current SoC
- * doesn't know how to interpret the register.
- */
-#define OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT			0
-#define OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT			1
-#define OMAP_SECU_VIOL_RST_SRC_ID_SHIFT				2
-#define OMAP_MPU_WD_RST_SRC_ID_SHIFT				3
-#define OMAP_SECU_WD_RST_SRC_ID_SHIFT				4
-#define OMAP_EXTWARM_RST_SRC_ID_SHIFT				5
-#define OMAP_VDD_MPU_VM_RST_SRC_ID_SHIFT			6
-#define OMAP_VDD_IVA_VM_RST_SRC_ID_SHIFT			7
-#define OMAP_VDD_CORE_VM_RST_SRC_ID_SHIFT			8
-#define OMAP_ICEPICK_RST_SRC_ID_SHIFT				9
-#define OMAP_ICECRUSHER_RST_SRC_ID_SHIFT			10
-#define OMAP_C2C_RST_SRC_ID_SHIFT				11
-#define OMAP_UNKNOWN_RST_SRC_ID_SHIFT				12
-
-#ifndef __ASSEMBLER__
-
-/**
- * struct prm_reset_src_map - map register bitshifts to standard bitshifts
- * @reg_shift: bitshift in the PRM reset source register
- * @std_shift: bitshift equivalent in the standard reset source list
- *
- * The fields are signed because -1 is used as a terminator.
- */
-struct prm_reset_src_map {
-	s8 reg_shift;
-	s8 std_shift;
-};
-
-/**
- * struct prm_ll_data - fn ptrs to per-SoC PRM function implementations
- * @read_reset_sources: ptr to the SoC PRM-specific get_reset_source impl
- * @was_any_context_lost_old: ptr to the SoC PRM context loss test fn
- * @clear_context_loss_flags_old: ptr to the SoC PRM context loss flag clear fn
- * @late_init: ptr to the late init function
- *
- * XXX @was_any_context_lost_old and @clear_context_loss_flags_old are
- * deprecated.
- */
-struct prm_ll_data {
-	u32 (*read_reset_sources)(void);
-	bool (*was_any_context_lost_old)(u8 part, s16 inst, u16 idx);
-	void (*clear_context_loss_flags_old)(u8 part, s16 inst, u16 idx);
-	int (*late_init)(void);
-};
-
-extern int prm_register(struct prm_ll_data *pld);
-extern int prm_unregister(struct prm_ll_data *pld);
-
-extern u32 prm_read_reset_sources(void);
-extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
-extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
-
-#endif
-
-
-#endif
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index b86486b..8f8a515 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -17,7 +17,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM2XXX_H
 
 #include <linux/power/omap/prcm-common.h>
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prm2xxx.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
index c02a267..5d6861a 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
@@ -17,7 +17,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_PRIVATE_H
 
 #include <linux/power/omap/prcm-common.h>
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 436cd12..b5864c9 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -21,7 +21,7 @@
 #include <linux/power/omap/prm33xx.h>
 
 #include "powerdomain.h"
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 
 #define AM33XX_LASTPOWERSTATEENTERED_SHIFT	24
 #define AM33XX_LASTPOWERSTATEENTERED_MASK	(0x3 << 24)
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 598ba48..c27b5a0 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -17,7 +17,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM33XX_H
 
 #include <linux/power/omap/prcm-common.h>
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prm33xx.h>
 
 #define AM33XX_PRM_BASE               0x44E00000
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 693b5ad..e48f7be 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -17,7 +17,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM3XXX_H
 
 #include <linux/power/omap/prcm-common.h>
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/prm3xxx.h>
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 705509a..cf312a8 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -25,7 +25,7 @@
 #include "prcm44xx.h"
 #include "prminst44xx_private.h"
 #include "powerdomain.h"
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm44xx_54xx.h>
 
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index b7066fd..dc9d21c 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -27,7 +27,7 @@
 
 #include <linux/power/omap/prm44xx_54xx.h>
 #include <linux/power/omap/prcm-common.h>
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prm44xx.h>
 
 #define OMAP4430_PRM_BASE		0x4a306000
diff --git a/arch/arm/mach-omap2/prm54xx.h b/arch/arm/mach-omap2/prm54xx.h
index 250c2d5..a3895f7 100644
--- a/arch/arm/mach-omap2/prm54xx.h
+++ b/arch/arm/mach-omap2/prm54xx.h
@@ -23,7 +23,7 @@
 
 #include <linux/power/omap/prm44xx_54xx.h>
 #include <linux/power/omap/prcm-common.h>
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prm54xx.h>
 
 #define OMAP54XX_PRM_BASE		0x4ae06000
diff --git a/arch/arm/mach-omap2/prm7xx.h b/arch/arm/mach-omap2/prm7xx.h
index 6e84906..de2ce3d 100644
--- a/arch/arm/mach-omap2/prm7xx.h
+++ b/arch/arm/mach-omap2/prm7xx.h
@@ -24,7 +24,7 @@
 
 #include <linux/power/omap/prm44xx_54xx.h>
 #include <linux/power/omap/prcm-common.h>
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prm7xx.h>
 
 #define DRA7XX_PRM_BASE		0x4ae06000
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index acdd0f1..fb377e1 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -33,7 +33,7 @@
 #include <linux/power/omap/prm3xxx.h>
 #include <linux/power/omap/prm44xx.h>
 
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prcm-common.h>
 
 /*
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 50c660d..30015d1 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -16,7 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "prm.h"
+#include <linux/power/omap/prm.h>
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm44xx.h>
 #include <linux/power/omap/prm54xx.h>
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index d15c7bb..9d528c6 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -14,12 +14,12 @@
 #include <linux/err.h>
 
 #include <linux/platform_data/omap-wd-timer.h>
+#include <linux/power/omap/prm.h>
 
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include "wd_timer.h"
 #include "common.h"
-#include "prm.h"
 #include "soc.h"
 
 /*
diff --git a/include/linux/power/omap/prm.h b/include/linux/power/omap/prm.h
new file mode 100644
index 0000000..4bc93ca
--- /dev/null
+++ b/include/linux/power/omap/prm.h
@@ -0,0 +1,164 @@
+/*
+ * OMAP2/3/4 Power/Reset Management (PRM) bitfield definitions
+ *
+ * Copyright (C) 2007-2009, 2012 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __LINUX_POWER_OMAP_PRM_H
+#define __LINUX_POWER_OMAP_PRM_H
+
+#include <linux/power/omap/prcm-common.h>
+
+# ifndef __ASSEMBLER__
+extern void __iomem *prm_base;
+extern u16 prm_dev_inst;
+extern u16 prm_features;
+void omap2_set_globals_prm(void __iomem *prm);
+int of_prcm_init(void);
+# endif
+
+/*
+ * prm_features flag values
+ *
+ * PRM_HAS_IO_WAKEUP: has IO wakeup capability
+ * PRM_HAS_VOLTAGE: has voltage domains
+ */
+#define PRM_HAS_IO_WAKEUP	(1 << 0)
+#define PRM_HAS_VOLTAGE		(1 << 1)
+
+#ifndef __ASSEMBLER__
+enum {
+	PRM_OMAP3430 = 0,
+	PRM_OMAP3630,
+	PRM_OMAP3_OTHER,
+	PRM_OMAP4,
+	PRM_OMAP5,
+	PRM_DRA7,
+};
+#endif
+
+/*
+ * MAX_MODULE_SOFTRESET_WAIT: Maximum microseconds to wait for OMAP
+ * module to softreset
+ */
+#define MAX_MODULE_SOFTRESET_WAIT		10000
+
+/*
+ * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
+ * submodule to exit hardreset
+ */
+#define MAX_MODULE_HARDRESET_WAIT		10000
+
+/*
+ * Register bitfields
+ */
+
+/*
+ * 24XX: PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP
+ *
+ * 2430: PM_PWSTST_MDM
+ *
+ * 3430: PM_PWSTST_IVA2, PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_GFX,
+ *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
+ *	 PM_PWSTST_NEON
+ */
+#define OMAP_INTRANSITION_MASK				(1 << 20)
+
+
+/*
+ * 24XX: PM_PWSTST_GFX, PM_PWSTST_DSP
+ *
+ * 2430: PM_PWSTST_MDM
+ *
+ * 3430: PM_PWSTST_IVA2, PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_GFX,
+ *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
+ *	 PM_PWSTST_NEON
+ */
+#define OMAP_POWERSTATEST_SHIFT				0
+#define OMAP_POWERSTATEST_MASK				(0x3 << 0)
+
+/*
+ * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *       PM_PWSTCTRL_DSP, PM_PWSTST_MPU
+ *
+ * 2430: PM_PWSTCTRL_MDM shared bits
+ *
+ * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE,
+ *	 PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
+ *	 PM_PWSTCTRL_NEON shared bits
+ */
+#define OMAP_POWERSTATE_SHIFT				0
+#define OMAP_POWERSTATE_MASK				(0x3 << 0)
+
+/*
+ * Standardized OMAP reset source bits
+ *
+ * To the extent these happen to match the hardware register bit
+ * shifts, it's purely coincidental.  Used by omap-wdt.c.
+ * OMAP_UNKNOWN_RST_SRC_ID_SHIFT is a special value, used whenever
+ * there are any bits remaining in the global PRM_RSTST register that
+ * haven't been identified, or when the PRM code for the current SoC
+ * doesn't know how to interpret the register.
+ */
+#define OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT			0
+#define OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT			1
+#define OMAP_SECU_VIOL_RST_SRC_ID_SHIFT				2
+#define OMAP_MPU_WD_RST_SRC_ID_SHIFT				3
+#define OMAP_SECU_WD_RST_SRC_ID_SHIFT				4
+#define OMAP_EXTWARM_RST_SRC_ID_SHIFT				5
+#define OMAP_VDD_MPU_VM_RST_SRC_ID_SHIFT			6
+#define OMAP_VDD_IVA_VM_RST_SRC_ID_SHIFT			7
+#define OMAP_VDD_CORE_VM_RST_SRC_ID_SHIFT			8
+#define OMAP_ICEPICK_RST_SRC_ID_SHIFT				9
+#define OMAP_ICECRUSHER_RST_SRC_ID_SHIFT			10
+#define OMAP_C2C_RST_SRC_ID_SHIFT				11
+#define OMAP_UNKNOWN_RST_SRC_ID_SHIFT				12
+
+#ifndef __ASSEMBLER__
+
+/**
+ * struct prm_reset_src_map - map register bitshifts to standard bitshifts
+ * @reg_shift: bitshift in the PRM reset source register
+ * @std_shift: bitshift equivalent in the standard reset source list
+ *
+ * The fields are signed because -1 is used as a terminator.
+ */
+struct prm_reset_src_map {
+	s8 reg_shift;
+	s8 std_shift;
+};
+
+/**
+ * struct prm_ll_data - fn ptrs to per-SoC PRM function implementations
+ * @read_reset_sources: ptr to the SoC PRM-specific get_reset_source impl
+ * @was_any_context_lost_old: ptr to the SoC PRM context loss test fn
+ * @clear_context_loss_flags_old: ptr to the SoC PRM context loss flag clear fn
+ * @late_init: ptr to the late init function
+ *
+ * XXX @was_any_context_lost_old and @clear_context_loss_flags_old are
+ * deprecated.
+ */
+struct prm_ll_data {
+	u32 (*read_reset_sources)(void);
+	bool (*was_any_context_lost_old)(u8 part, s16 inst, u16 idx);
+	void (*clear_context_loss_flags_old)(u8 part, s16 inst, u16 idx);
+	int (*late_init)(void);
+};
+
+int prm_register(struct prm_ll_data *pld);
+int prm_unregister(struct prm_ll_data *pld);
+
+u32 prm_read_reset_sources(void);
+bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
+void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
+
+#endif
+
+
+#endif
-- 
1.7.9.5

