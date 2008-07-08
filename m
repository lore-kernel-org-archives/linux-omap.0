From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/9] OMAP2 SDRC: separate common OMAP2/3 code from OMAP2xxx
	code
Date: Mon, 07 Jul 2008 20:54:45 -0600
Message-ID: <20080708025443.11646.6987.stgit@localhost.localdomain>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40857 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778AbYGHC4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 22:56:37 -0400
In-Reply-To: <20080708025225.11646.55912.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Separate SDRC code common to OMAP2/3 from mach-omap2/sdrc2xxx.c to
mach-omap2/sdrc.c.  Rename the OMAP2xxx-specific functions to use an
'omap2xxx' prefix rather than an 'omap2' prefix, and use "sdrc" in the
function names rather than "memory."  Mark several functions
as static that should not be used outside the sdrc2xxx.c file.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/Makefile       |    6 +++-
 arch/arm/mach-omap2/clock24xx.c    |   23 ++++++++-------
 arch/arm/mach-omap2/io.c           |    2 +
 arch/arm/mach-omap2/sdrc.c         |   57 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sdrc2xxx.c     |   57 +++++++++++-------------------------
 arch/arm/plat-omap/common.c        |    2 +
 include/asm-arm/arch-omap/common.h |    2 +
 include/asm-arm/arch-omap/sdrc.h   |   19 +++++++-----
 8 files changed, 106 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdrc.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ad70a15..3d1b05a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sdrc2xxx.o control.o prcm.o clock.o mux.o \
+obj-y := irq.o id.o io.o sdrc.o control.o prcm.o clock.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
 		clockdomain.o
 
@@ -14,6 +14,10 @@ obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
 obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
+# SMS/SDRC
+obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
+# obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
+
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-y					+= pm.o
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index aa3027c..47782ba 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -192,9 +192,9 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
 	if ((rate == (cur_rate / 2)) && (mult == 2)) {
-		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL, 1);
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
 	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
-		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
 	} else if (rate != cur_rate) {
 		valid_rate = omap2_dpllcore_round_rate(rate);
 		if (valid_rate != rate)
@@ -233,15 +233,16 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
 			bypass = 1;
 
-		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1); /* For init_mem */
+		/* For omap2xxx_sdrc_init_params() */
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
 
 		/* Force dll lock mode */
 		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
 			       bypass);
 
 		/* Errata: ret dll entry state */
-		omap2_init_memory_params(omap2_dll_force_needed());
-		omap2_reprogram_sdrc(done_rate, 0);
+		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
+		omap2xxx_sdrc_reprogram(done_rate, 0);
 	}
 	omap2_dpllcore_recalc(&dpll_ck);
 	ret = 0;
@@ -328,9 +329,9 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
 
 	if (prcm->dpll_speed == cur_rate / 2) {
-		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL, 1);
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
 	} else if (prcm->dpll_speed == cur_rate * 2) {
-		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
 	} else if (prcm->dpll_speed != cur_rate) {
 		local_irq_save(flags);
 
@@ -361,14 +362,14 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 			cm_write_mod_reg(prcm->cm_clksel_mdm,
 					 OMAP2430_MDM_MOD, CM_CLKSEL);
 
-		/* x2 to enter init_mem */
-		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
+		/* x2 to enter omap2xxx_sdrc_init_params() */
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
 
 		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
 			       bypass);
 
-		omap2_init_memory_params(omap2_dll_force_needed());
-		omap2_reprogram_sdrc(done_rate, 0);
+		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
+		omap2xxx_sdrc_reprogram(done_rate, 0);
 
 		local_irq_restore(flags);
 	}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4aa1abf..e3dcff9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -200,6 +200,6 @@ void __init omap2_init_common_hw(void)
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
-	omap2_init_memory();
+	omap2_sdrc_init();
 	gpmc_init();
 }
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
new file mode 100644
index 0000000..0f17716
--- /dev/null
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -0,0 +1,57 @@
+/*
+ * SMS/SDRC (SDRAM controller) common code for OMAP2/3
+ *
+ * Copyright (C) 2005, 2008 Texas Instruments Inc.
+ * Copyright (C) 2005, 2008 Nokia Corporation
+ *
+ * Tony Lindgren <tony@atomide.com>
+ * Paul Walmsley
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/arch/common.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sram.h>
+
+#include "prm.h"
+
+#include <asm/arch/sdrc.h>
+#include "sdrc.h"
+
+void __iomem *omap2_sdrc_base;
+void __iomem *omap2_sms_base;
+
+void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
+{
+	omap2_sdrc_base = omap2_globals->sdrc;
+	omap2_sms_base = omap2_globals->sms;
+}
+
+/* turn on smart idle modes for SDRAM scheduler and controller */
+void __init omap2_sdrc_init(void)
+{
+	u32 l;
+
+	l = sms_read_reg(SMS_SYSCONFIG);
+	l &= ~(0x3 << 3);
+	l |= (0x2 << 3);
+	sms_write_reg(l, SMS_SYSCONFIG);
+
+	l = sdrc_read_reg(SDRC_SYSCONFIG);
+	l &= ~(0x3 << 3);
+	l |= (0x2 << 3);
+	sdrc_write_reg(l, SDRC_SYSCONFIG);
+}
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 1dc1425..e98da5c 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -1,13 +1,14 @@
 /*
  * linux/arch/arm/mach-omap2/memory.c
  *
- * Memory timing related functions for OMAP24XX
+ * Memory timing related functions for OMAP2xxx
  *
- * Copyright (C) 2005 Texas Instruments Inc.
- * Richard Woodruff <r-woodruff2@ti.com>
+ * Copyright (C) 2005, 2008 Texas Instruments Inc.
+ * Copyright (C) 2005, 2008 Nokia Corporation
  *
- * Copyright (C) 2005 Nokia Corporation
  * Tony Lindgren <tony@atomide.com>
+ * Paul Walmsley
+ * Richard Woodruff <r-woodruff2@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -39,23 +40,20 @@
 #define M_LOCK		1
 
 
-void __iomem *omap2_sdrc_base;
-void __iomem *omap2_sms_base;
-
 static struct memory_timings mem_timings;
 static u32 curr_perf_level = CORE_CLK_SRC_DPLL_X2;
 
-u32 omap2_memory_get_slow_dll_ctrl(void)
+static u32 omap2xxx_sdrc_get_slow_dll_ctrl(void)
 {
 	return mem_timings.slow_dll_ctrl;
 }
 
-u32 omap2_memory_get_fast_dll_ctrl(void)
+static u32 omap2xxx_sdrc_get_fast_dll_ctrl(void)
 {
 	return mem_timings.fast_dll_ctrl;
 }
 
-u32 omap2_memory_get_type(void)
+static u32 omap2xxx_sdrc_get_type(void)
 {
 	return mem_timings.m_type;
 }
@@ -64,7 +62,7 @@ u32 omap2_memory_get_type(void)
  * Check the DLL lock state, and return tue if running in unlock mode.
  * This is needed to compensate for the shifted DLL value in unlock mode.
  */
-u32 omap2_dll_force_needed(void)
+u32 omap2xxx_sdrc_dll_is_unlocked(void)
 {
 	/* dlla and dllb are a set */
 	u32 dll_state = sdrc_read_reg(SDRC_DLLA_CTRL);
@@ -79,8 +77,10 @@ u32 omap2_dll_force_needed(void)
  * 'level' is the value to store to CM_CLKSEL2_PLL.CORE_CLK_SRC.
  * Practical values are CORE_CLK_SRC_DPLL (for CORE_CLK = DPLL_CLK) or
  * CORE_CLK_SRC_DPLL_X2 (for CORE_CLK = * DPLL_CLK * 2)
+ *
+ * Used by the clock framework during CORE DPLL changes
  */
-u32 omap2_reprogram_sdrc(u32 level, u32 force)
+u32 omap2xxx_sdrc_reprogram(u32 level, u32 force)
 {
 	u32 dll_ctrl, m_type;
 	u32 prev = curr_perf_level;
@@ -90,13 +90,13 @@ u32 omap2_reprogram_sdrc(u32 level, u32 force)
 		return prev;
 
 	if (level == CORE_CLK_SRC_DPLL)
-		dll_ctrl = omap2_memory_get_slow_dll_ctrl();
-	else if (level == CORE_CLK_SRC_DPLL_X2) {
-		dll_ctrl = omap2_memory_get_fast_dll_ctrl();
+		dll_ctrl = omap2xxx_sdrc_get_slow_dll_ctrl();
+	else if (level == CORE_CLK_SRC_DPLL_X2)
+		dll_ctrl = omap2xxx_sdrc_get_fast_dll_ctrl();
 	else
 		return prev;
 
-	m_type = omap2_memory_get_type();
+	m_type = omap2xxx_sdrc_get_type();
 
 	local_irq_save(flags);
 	prm_write_mod_reg(0xffff, OMAP24XX_GR_MOD,
@@ -108,7 +108,8 @@ u32 omap2_reprogram_sdrc(u32 level, u32 force)
 	return prev;
 }
 
-void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
+/* Used by the clock framework during CORE DPLL changes */
+void omap2xxx_sdrc_init_params(u32 force_lock_to_unlock_mode)
 {
 	unsigned long dll_cnt;
 	u32 fast_dll = 0;
@@ -161,25 +162,3 @@ void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 	/* 90 degree phase for anything below 133Mhz + disable DLL filter */
 	mem_timings.slow_dll_ctrl |= ((1 << 1) | (3 << 8));
 }
-
-void __init omap2_set_globals_memory(struct omap_globals *omap2_globals)
-{
-	omap2_sdrc_base = omap2_globals->sdrc;
-	omap2_sms_base = omap2_globals->sms;
-}
-
-/* turn on smart idle modes for SDRAM scheduler and controller */
-void __init omap2_init_memory(void)
-{
-	u32 l;
-
-	l = sms_read_reg(SMS_SYSCONFIG);
-	l &= ~(0x3 << 3);
-	l |= (0x2 << 3);
-	sms_write_reg(l, SMS_SYSCONFIG);
-
-	l = sdrc_read_reg(SDRC_SYSCONFIG);
-	l &= ~(0x3 << 3);
-	l |= (0x2 << 3);
-	sdrc_write_reg(l, SDRC_SYSCONFIG);
-}
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 132a758..3a5f05e 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -269,7 +269,7 @@ static struct omap_globals *omap2_globals;
 static void __init __omap2_set_globals(void)
 {
 	omap2_set_globals_tap(omap2_globals);
-	omap2_set_globals_memory(omap2_globals);
+	omap2_set_globals_sdrc(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
 	omap2_set_globals_clock24xx(omap2_globals);
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index 7a48fc9..8a525ed 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -65,7 +65,7 @@ void omap2_set_globals_343x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
-void omap2_set_globals_memory(struct omap_globals *);
+void omap2_set_globals_sdrc(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
 #ifdef CONFIG_ARCH_OMAP24XX
diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-omap/sdrc.h
index 0edce1c..c75caf5 100644
--- a/include/asm-arm/arch-omap/sdrc.h
+++ b/include/asm-arm/arch-omap/sdrc.h
@@ -81,6 +81,10 @@
 
 #ifndef __ASSEMBLER__
 
+void __init omap2_sdrc_init(void);
+
+#ifdef CONFIG_ARCH_OMAP2
+
 struct memory_timings {
 	u32 m_type;		/* ddr = 1, sdr = 0 */
 	u32 dll_mode;		/* use lock mode = 1, unlock mode = 0 */
@@ -89,14 +93,13 @@ struct memory_timings {
 	u32 base_cs;		/* base chip select to use for calculations */
 };
 
-extern void omap2_init_memory_params(u32 force_lock_to_unlock_mode);
-extern u32 omap2_memory_get_slow_dll_ctrl(void);
-extern u32 omap2_memory_get_fast_dll_ctrl(void);
-extern u32 omap2_memory_get_type(void);
-u32 omap2_dll_force_needed(void);
-u32 omap2_reprogram_sdrc(u32 level, u32 force);
-void __init omap2_init_memory(void);
+extern void omap2xxx_sdrc_init_params(u32 force_lock_to_unlock_mode);
 
-#endif
+u32 omap2xxx_sdrc_dll_is_unlocked(void);
+u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
+
+#endif  /* CONFIG_ARCH_OMAP2 */
+
+#endif  /* __ASSEMBLER__ */
 
 #endif


