From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/13] ARM: OMAP2+: PRCM: consolidate PRCM-related timeout
 macros
Date: Thu, 25 Oct 2012 17:21:21 -0600
Message-ID: <20121025232120.17558.82198.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38297 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab2JYXYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:05 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Consolidate all of the copies of MAX_MODULE_HARDRESET_WAIT and
MAX_MODULE_SOFTRESET_WAIT into one place, arch/arm/mach-omap2/prm.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/display.c      |    2 +-
 arch/arm/mach-omap2/hdq1w.c        |    4 +---
 arch/arm/mach-omap2/i2c.c          |    6 ++----
 arch/arm/mach-omap2/msdi.c         |    4 +---
 arch/arm/mach-omap2/omap_hwmod.c   |    4 +---
 arch/arm/mach-omap2/prcm-common.h  |    6 ------
 arch/arm/mach-omap2/prm.h          |   17 +++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    7 -------
 arch/arm/mach-omap2/wd_timer.c     |    5 ++---
 9 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 1011995..8a92ee6 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -34,6 +34,7 @@
 #include "mux.h"
 #include "control.h"
 #include "display.h"
+#include "prm.h"
 
 #define DISPC_CONTROL		0x0040
 #define DISPC_CONTROL2		0x0238
@@ -473,7 +474,6 @@ static void dispc_disable_outputs(void)
 	}
 }
 
-#define MAX_MODULE_SOFTRESET_WAIT	10000
 int omap_dss_reset(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_opt_clk *oc;
diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index e003f2b..0e30a97 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -31,11 +31,9 @@
 #include <plat/omap_device.h>
 #include "hdq1w.h"
 
+#include "prm.h"
 #include "common.h"
 
-/* Maximum microseconds to wait for OMAP module to softreset */
-#define MAX_MODULE_SOFTRESET_WAIT	10000
-
 /**
  * omap_hdq1w_reset - reset the OMAP HDQ1W module
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index fc57e67..aaaf09e 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -20,9 +20,10 @@
  */
 
 #include <plat/i2c.h>
-#include "common.h"
 #include <plat/omap_hwmod.h>
 
+#include "prm.h"
+#include "common.h"
 #include "mux.h"
 
 /* In register I2C_CON, Bit 15 is the I2C enable bit */
@@ -30,9 +31,6 @@
 #define OMAP2_I2C_CON_OFFSET			0x24
 #define OMAP4_I2C_CON_OFFSET			0xA4
 
-/* Maximum microseconds to wait for OMAP module to softreset */
-#define MAX_MODULE_SOFTRESET_WAIT	10000
-
 void __init omap2_i2c_mux_pins(int bus_id)
 {
 	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index 9e57b4a..5438c62 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -29,6 +29,7 @@
 #include <plat/omap_device.h>
 #include <plat/mmc.h>
 
+#include "prm.h"
 #include "common.h"
 #include "control.h"
 #include "mux.h"
@@ -44,9 +45,6 @@
 #define MSDI_CON_CLKD_MASK			(0x3f << 0)
 #define MSDI_CON_CLKD_SHIFT			0
 
-/* Maximum microseconds to wait for OMAP module to softreset */
-#define MAX_MODULE_SOFTRESET_WAIT	10000
-
 /* MSDI_TARGET_RESET_CLKD: clock divisor to use throughout the reset */
 #define MSDI_TARGET_RESET_CLKD		0x3ff
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 504e0e0..bc891e9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -151,6 +151,7 @@
 #include "cm3xxx.h"
 #include "cminst44xx.h"
 #include "cm33xx.h"
+#include "prm.h"
 #include "prm3xxx.h"
 #include "prm44xx.h"
 #include "prm33xx.h"
@@ -158,9 +159,6 @@
 #include "mux.h"
 #include "pm.h"
 
-/* Maximum microseconds to wait for OMAP module to softreset */
-#define MAX_MODULE_SOFTRESET_WAIT	10000
-
 /* Name of the OMAP hwmod for the MPU */
 #define MPU_INITIATOR_NAME		"mpu"
 
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index b25a32a..c7d355f 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -406,11 +406,6 @@
 #define OMAP3430_EN_CORE_MASK				(1 << 0)
 
 
-/*
- * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
- * submodule to exit hardreset
- */
-#define MAX_MODULE_HARDRESET_WAIT		10000
 
 /*
  * Maximum time(us) it takes to output the signal WUCLKOUT of the last
@@ -419,7 +414,6 @@
  * microseconds on OMAP4, so this timeout may be too high.
  */
 #define MAX_IOPAD_LATCH_TIME			100
-
 # ifndef __ASSEMBLER__
 
 /**
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index fb7dee2..a1a266c 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -20,6 +20,23 @@ extern void __iomem *prm_base;
 extern void omap2_set_globals_prm(void __iomem *prm);
 # endif
 
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
 /*
  * 24XX: PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP
  *
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 3330b1b..78532d6 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -241,11 +241,4 @@ extern int omap2_clkdm_clear_all_wkdeps(struct clockdomain *clkdm);
 #define OMAP_LOGICRETSTATE_MASK				(1 << 2)
 
 
-/*
- * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
- * submodule to exit hardreset
- */
-#define MAX_MODULE_HARDRESET_WAIT		10000
-
-
 #endif
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index 00ef54c..30e2cb9 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -1,6 +1,8 @@
 /*
  * OMAP2+ MPU WD_TIMER-specific code
  *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -30,9 +32,6 @@
 #define OMAP_WDT_WPS		0x34
 #define OMAP_WDT_SPR		0x48
 
-/* Maximum microseconds to wait for OMAP module to softreset */
-#define MAX_MODULE_SOFTRESET_WAIT	10000
-
 int omap2_wd_timer_disable(struct omap_hwmod *oh)
 {
 	void __iomem *base;


