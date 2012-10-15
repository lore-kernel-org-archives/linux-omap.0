From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] ARM: OMAP2+: CM/hwmod: split CM functions into OMAP2,
 OMAP3-specific files
Date: Mon, 15 Oct 2012 17:05:45 -0600
Message-ID: <20121015230544.18306.15215.stgit@dusk.lan>
References: <20121015224455.18306.89030.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42508 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2JOXG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 19:06:58 -0400
In-Reply-To: <20121015224455.18306.89030.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move OMAP3xxx-specific CM functions & macros into cm3xxx.[ch] and
OMAP2xxx-specific macros into cm2xxx.[ch].  Move basic CM register
access functions into static inline functions in cm2xxx_3xxx.h,
leaving only OMAP2/3 hardreset functions in cm2xxx_3xxx.c.

As part of this, split the CM and hwmod code that waits for devices to
become ready into SoC-specific functions.

This is in preparation for the upcoming move of this code to drivers/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile               |    6 -
 arch/arm/mach-omap2/clkt2xxx_apll.c        |    2 
 arch/arm/mach-omap2/clkt2xxx_dpll.c        |    2 
 arch/arm/mach-omap2/clock.c                |    3 -
 arch/arm/mach-omap2/clock2420_data.c       |    2 
 arch/arm/mach-omap2/clock2430.c            |    2 
 arch/arm/mach-omap2/clock2430_data.c       |    2 
 arch/arm/mach-omap2/clock34xx.c            |    2 
 arch/arm/mach-omap2/clock3517.c            |    2 
 arch/arm/mach-omap2/clock3xxx_data.c       |    2 
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   27 ++---
 arch/arm/mach-omap2/cm2xxx.c               |  167 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm2xxx.h               |   68 +++++++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h          |  112 +++++--------------
 arch/arm/mach-omap2/cm3xxx.c               |  160 ++-------------------------
 arch/arm/mach-omap2/cm3xxx.h               |   86 +-------------
 arch/arm/mach-omap2/control.c              |    2 
 arch/arm/mach-omap2/omap_hwmod.c           |   49 +++++++-
 arch/arm/mach-omap2/pm24xx.c               |    2 
 arch/arm/mach-omap2/pm34xx.c               |    3 -
 arch/arm/mach-omap2/sleep34xx.S            |    2 
 arch/arm/mach-omap2/sram242x.S             |    2 
 arch/arm/mach-omap2/sram243x.S             |    2 
 arch/arm/mach-omap2/sram34xx.S             |    2 
 24 files changed, 360 insertions(+), 349 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm2xxx.c
 create mode 100644 arch/arm/mach-omap2/cm2xxx.h
 rename arch/arm/mach-omap2/{cm2xxx_3xxx.c => cm3xxx.c} (80%)
 copy arch/arm/mach-omap2/{cm2xxx_3xxx.h => cm3xxx.h} (50%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7404e3d..56a3386 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -94,10 +94,8 @@ endif
 
 # PRCM
 obj-y					+= prcm.o prm_common.o
-obj-$(CONFIG_ARCH_OMAP2)		+= cm2xxx_3xxx.o prm2xxx_3xxx.o
-obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= cm2xxx_3xxx.o prm2xxx_3xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= prm3xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= prm33xx.o cm33xx.o
 omap-prcm-4-5-common			=  cminst44xx.o cm44xx.o prm44xx.o \
diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index c2d15212..3d2f67e 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -26,7 +26,7 @@
 
 #include "clock.h"
 #include "clock2xxx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
 #include "cm-regbits-24xx.h"
 
 /* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpll.c b/arch/arm/mach-omap2/clkt2xxx_dpll.c
index 1502a7b..0f58779 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpll.c
@@ -17,7 +17,7 @@
 #include <plat/clock.h>
 
 #include "clock.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
 #include "cm-regbits-24xx.h"
 
 /* Private functions */
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 961ac8f..d0c6d9b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -33,7 +33,8 @@
 #include "soc.h"
 #include "clockdomain.h"
 #include "clock.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
+#include "cm3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index c3cde1a..969bc58 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -25,7 +25,7 @@
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index a8e3261..e786733 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -27,7 +27,7 @@
 #include "iomap.h"
 #include "clock.h"
 #include "clock2xxx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
 #include "cm-regbits-24xx.h"
 
 /**
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 22404fe..186f06a 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -24,7 +24,7 @@
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 1fc96b9..150f42b 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -25,7 +25,7 @@
 
 #include "clock.h"
 #include "clock34xx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 
 /**
diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/clock3517.c
index 2e97d08..3e610c8 100644
--- a/arch/arm/mach-omap2/clock3517.c
+++ b/arch/arm/mach-omap2/clock3517.c
@@ -25,7 +25,7 @@
 
 #include "clock.h"
 #include "clock3517.h"
-#include "cm2xxx_3xxx.h"
+#include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1f42c9d..7879c84 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -30,7 +30,7 @@
 #include "clock34xx.h"
 #include "clock36xx.h"
 #include "clock3517.h"
-#include "cm2xxx_3xxx.h"
+#include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index 70294f5..658487c 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -17,7 +17,8 @@
 #include "prm.h"
 #include "prm2xxx_3xxx.h"
 #include "cm.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
+#include "cm3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-24xx.h"
@@ -176,15 +177,15 @@ static int omap3_clkdm_wakeup(struct clockdomain *clkdm)
 	return 0;
 }
 
-static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
+static int omap2xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 {
 	bool hwsup = false;
 
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
-	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
-				clkdm->clktrctrl_mask);
+	hwsup = omap3xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+					      clkdm->clktrctrl_mask);
 
 	if (hwsup) {
 		/* Disable HW transitions when we are changing deps */
@@ -199,15 +200,15 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
 	return 0;
 }
 
-static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
+static int omap2xxx_clkdm_clk_disable(struct clockdomain *clkdm)
 {
 	bool hwsup = false;
 
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
-	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
-				clkdm->clktrctrl_mask);
+	hwsup = omap3xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+					      clkdm->clktrctrl_mask);
 
 	if (hwsup) {
 		/* Disable HW transitions when we are changing deps */
@@ -258,8 +259,8 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 		return 0;
 	}
 
-	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
-				clkdm->clktrctrl_mask);
+	hwsup = omap2xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+					      clkdm->clktrctrl_mask);
 
 	if (hwsup) {
 		/* Disable HW transitions when we are changing deps */
@@ -292,8 +293,8 @@ static int omap3xxx_clkdm_clk_disable(struct clockdomain *clkdm)
 		return 0;
 	}
 
-	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
-				clkdm->clktrctrl_mask);
+	hwsup = omap2xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+					      clkdm->clktrctrl_mask);
 
 	if (hwsup) {
 		/* Disable HW transitions when we are changing deps */
@@ -317,8 +318,8 @@ struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_wakeup		= omap2_clkdm_wakeup,
 	.clkdm_allow_idle	= omap2_clkdm_allow_idle,
 	.clkdm_deny_idle	= omap2_clkdm_deny_idle,
-	.clkdm_clk_enable	= omap2_clkdm_clk_enable,
-	.clkdm_clk_disable	= omap2_clkdm_clk_disable,
+	.clkdm_clk_enable	= omap2xxx_clkdm_clk_enable,
+	.clkdm_clk_disable	= omap2xxx_clkdm_clk_disable,
 };
 
 struct clkdm_ops omap3_clkdm_operations = {
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
new file mode 100644
index 0000000..19cee91
--- /dev/null
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -0,0 +1,167 @@
+/*
+ * OMAP2/3 CM module functions
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include "soc.h"
+#include "iomap.h"
+#include "common.h"
+#include "cm.h"
+#include "cm2xxx.h"
+#include "cm-regbits-24xx.h"
+
+/* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
+#define DPLL_AUTOIDLE_DISABLE				0x0
+#define OMAP2XXX_DPLL_AUTOIDLE_LOW_POWER_STOP		0x3
+
+/* CM_AUTOIDLE_PLL.AUTO_* bit values for APLLs (OMAP2xxx only) */
+#define OMAP2XXX_APLL_AUTOIDLE_DISABLE			0x0
+#define OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP		0x3
+
+static const u8 omap2xxx_cm_idlest_offs[] = {
+	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3, OMAP24XX_CM_IDLEST4
+};
+
+/*
+ *
+ */
+
+static void _write_clktrctrl(u8 c, s16 module, u32 mask)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(module, OMAP2_CM_CLKSTCTRL);
+	v &= ~mask;
+	v |= c << __ffs(mask);
+	omap2_cm_write_mod_reg(v, module, OMAP2_CM_CLKSTCTRL);
+}
+
+bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(module, OMAP2_CM_CLKSTCTRL);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return (v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
+}
+
+void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
+{
+	_write_clktrctrl(OMAP24XX_CLKSTCTRL_ENABLE_AUTO, module, mask);
+}
+
+void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
+{
+	_write_clktrctrl(OMAP24XX_CLKSTCTRL_DISABLE_AUTO, module, mask);
+}
+
+/*
+ * DPLL autoidle control
+ */
+
+static void _omap2xxx_set_dpll_autoidle(u8 m)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
+	v &= ~OMAP24XX_AUTO_DPLL_MASK;
+	v |= m << OMAP24XX_AUTO_DPLL_SHIFT;
+	omap2_cm_write_mod_reg(v, PLL_MOD, CM_AUTOIDLE);
+}
+
+void omap2xxx_cm_set_dpll_disable_autoidle(void)
+{
+	_omap2xxx_set_dpll_autoidle(OMAP2XXX_DPLL_AUTOIDLE_LOW_POWER_STOP);
+}
+
+void omap2xxx_cm_set_dpll_auto_low_power_stop(void)
+{
+	_omap2xxx_set_dpll_autoidle(DPLL_AUTOIDLE_DISABLE);
+}
+
+/*
+ * APLL autoidle control
+ */
+
+static void _omap2xxx_set_apll_autoidle(u8 m, u32 mask)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
+	v &= ~mask;
+	v |= m << __ffs(mask);
+	omap2_cm_write_mod_reg(v, PLL_MOD, CM_AUTOIDLE);
+}
+
+void omap2xxx_cm_set_apll54_disable_autoidle(void)
+{
+	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP,
+				    OMAP24XX_AUTO_54M_MASK);
+}
+
+void omap2xxx_cm_set_apll54_auto_low_power_stop(void)
+{
+	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_DISABLE,
+				    OMAP24XX_AUTO_54M_MASK);
+}
+
+void omap2xxx_cm_set_apll96_disable_autoidle(void)
+{
+	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP,
+				    OMAP24XX_AUTO_96M_MASK);
+}
+
+void omap2xxx_cm_set_apll96_auto_low_power_stop(void)
+{
+	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_DISABLE,
+				    OMAP24XX_AUTO_96M_MASK);
+}
+
+/*
+ *
+ */
+
+/**
+ * omap2xxx_cm_wait_module_ready - wait for a module to leave idle or standby
+ * @prcm_mod: PRCM module offset
+ * @idlest_id: CM_IDLESTx register ID (i.e., x = 1, 2, 3)
+ * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
+ *
+ * Wait for the PRCM to indicate that the module identified by
+ * (@prcm_mod, @idlest_id, @idlest_shift) is clocked.  Return 0 upon
+ * success or -EBUSY if the module doesn't enable in time.
+ */
+int omap2xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
+{
+	int ena = 0, i = 0;
+	u8 cm_idlest_reg;
+	u32 mask;
+
+	if (!idlest_id || (idlest_id > ARRAY_SIZE(omap2xxx_cm_idlest_offs)))
+		return -EINVAL;
+
+	cm_idlest_reg = omap2xxx_cm_idlest_offs[idlest_id - 1];
+
+	mask = 1 << idlest_shift;
+	ena = mask;
+
+	omap_test_timeout(((omap2_cm_read_mod_reg(prcm_mod, cm_idlest_reg) &
+			    mask) == ena), MAX_MODULE_READY_TIME, i);
+
+	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
new file mode 100644
index 0000000..99e8557
--- /dev/null
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -0,0 +1,68 @@
+/*
+ * OMAP2/3 Clock Management (CM) register definitions
+ *
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The CM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The CM modules/instances on OMAP4 are quite different, so
+ * they are handled in a separate file.
+ */
+#ifndef __ARCH_ASM_MACH_OMAP2_CM2XXX_H
+#define __ARCH_ASM_MACH_OMAP2_CM2XXX_H
+
+#include "prcm-common.h"
+#include "cm2xxx_3xxx.h"
+
+#define OMAP2420_CM_REGADDR(module, reg)				\
+			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
+#define OMAP2430_CM_REGADDR(module, reg)				\
+			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
+
+/*
+ * Module specific CM register offsets from CM_BASE + domain offset
+ * Use cm_{read,write}_mod_reg() with these registers.
+ * These register offsets generally appear in more than one PRCM submodule.
+ */
+
+/* OMAP2-specific register offsets */
+
+#define OMAP24XX_CM_FCLKEN2				0x0004
+#define OMAP24XX_CM_ICLKEN4				0x001c
+#define OMAP24XX_CM_AUTOIDLE4				0x003c
+#define OMAP24XX_CM_IDLEST4				0x002c
+
+#define OMAP2430_CM_IDLEST3				0x0028
+
+/* CM_IDLEST bit field values to indicate deasserted IdleReq */
+
+#define OMAP24XX_CM_IDLEST_VAL				0
+
+
+/* Clock management domain register get/set */
+
+#ifndef __ASSEMBLER__
+
+extern void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
+extern void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
+
+extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
+extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
+
+extern void omap2xxx_cm_set_apll54_disable_autoidle(void);
+extern void omap2xxx_cm_set_apll54_auto_low_power_stop(void);
+extern void omap2xxx_cm_set_apll96_disable_autoidle(void);
+extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
+
+extern bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
+extern int omap2xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
+					 u8 idlest_shift);
+
+#endif
+
+#endif
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index 57b2f3c..64df725 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -18,27 +18,6 @@
 
 #include "prcm-common.h"
 
-#define OMAP2420_CM_REGADDR(module, reg)				\
-			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
-#define OMAP2430_CM_REGADDR(module, reg)				\
-			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
-#define OMAP34XX_CM_REGADDR(module, reg)				\
-			OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
-
-
-/*
- * OMAP3-specific global CM registers
- * Use cm_{read,write}_reg() with these registers.
- * These registers appear once per CM module.
- */
-
-#define OMAP3430_CM_REVISION		OMAP34XX_CM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP3430_CM_SYSCONFIG		OMAP34XX_CM_REGADDR(OCP_MOD, 0x0010)
-#define OMAP3430_CM_POLCTRL		OMAP34XX_CM_REGADDR(OCP_MOD, 0x009c)
-
-#define OMAP3_CM_CLKOUT_CTRL_OFFSET	0x0070
-#define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
-
 /*
  * Module specific CM register offsets from CM_BASE + domain offset
  * Use cm_{read,write}_mod_reg() with these registers.
@@ -66,70 +45,43 @@
 #define CM_CLKSEL2					0x0044
 #define OMAP2_CM_CLKSTCTRL				0x0048
 
-/* OMAP2-specific register offsets */
-
-#define OMAP24XX_CM_FCLKEN2				0x0004
-#define OMAP24XX_CM_ICLKEN4				0x001c
-#define OMAP24XX_CM_AUTOIDLE4				0x003c
-#define OMAP24XX_CM_IDLEST4				0x002c
-
-#define OMAP2430_CM_IDLEST3				0x0028
-
-/* OMAP3-specific register offsets */
-
-#define OMAP3430_CM_CLKEN_PLL				0x0004
-#define OMAP3430ES2_CM_CLKEN2				0x0004
-#define OMAP3430ES2_CM_FCLKEN3				0x0008
-#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
-#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
-#define OMAP3430ES2_CM_AUTOIDLE2_PLL			CM_AUTOIDLE2
-#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
-#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
-#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
-#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
-#define OMAP3430_CM_CLKSEL3				OMAP2_CM_CLKSTCTRL
-#define OMAP3430_CM_CLKSTST				0x004c
-#define OMAP3430ES2_CM_CLKSEL4				0x004c
-#define OMAP3430ES2_CM_CLKSEL5				0x0050
-#define OMAP3430_CM_CLKSEL2_EMU				0x0050
-#define OMAP3430_CM_CLKSEL3_EMU				0x0054
-
-
-/* CM_IDLEST bit field values to indicate deasserted IdleReq */
-
-#define OMAP24XX_CM_IDLEST_VAL				0
-#define OMAP34XX_CM_IDLEST_VAL				1
-
+#ifndef __ASSEMBLER__
 
-/* Clock management domain register get/set */
+#include <linux/io.h>
 
-#ifndef __ASSEMBLER__
+static inline u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
+{
+	return __raw_readl(cm_base + module + idx);
+}
 
-extern u32 omap2_cm_read_mod_reg(s16 module, u16 idx);
-extern void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx);
-extern u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+static inline void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	__raw_writel(val, cm_base + module + idx);
+}
 
-extern int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
-				      u8 idlest_shift);
-extern u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
-extern u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
+/* Read-modify-write a register in a CM module. Caller must lock */
+static inline u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module,
+					    s16 idx)
+{
+	u32 v;
 
-extern bool omap2_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
-extern void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
-extern void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
+	v = omap2_cm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	omap2_cm_write_mod_reg(v, module, idx);
 
-extern void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
+	return v;
+}
 
-extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
-extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
+static inline u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return omap2_cm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
 
-extern void omap2xxx_cm_set_apll54_disable_autoidle(void);
-extern void omap2xxx_cm_set_apll54_auto_low_power_stop(void);
-extern void omap2xxx_cm_set_apll96_disable_autoidle(void);
-extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
+static inline u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
 
 #endif
 
@@ -147,10 +99,4 @@ extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
 #define OMAP_ST_GFX_MASK				(1 << 0)
 
 
-/* Function prototypes */
-# ifndef __ASSEMBLER__
-extern void omap3_cm_save_context(void);
-extern void omap3_cm_restore_context(void);
-# endif
-
 #endif
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
similarity index 80%
rename from arch/arm/mach-omap2/cm2xxx_3xxx.c
rename to arch/arm/mach-omap2/cm3xxx.c
index 7f07ab0..075cabe 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -12,8 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/delay.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -22,54 +20,10 @@
 #include "iomap.h"
 #include "common.h"
 #include "cm.h"
-#include "cm2xxx_3xxx.h"
-#include "cm-regbits-24xx.h"
+#include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 
-/* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
-#define DPLL_AUTOIDLE_DISABLE				0x0
-#define OMAP2XXX_DPLL_AUTOIDLE_LOW_POWER_STOP		0x3
-
-/* CM_AUTOIDLE_PLL.AUTO_* bit values for APLLs (OMAP2xxx only) */
-#define OMAP2XXX_APLL_AUTOIDLE_DISABLE			0x0
-#define OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP		0x3
-
-static const u8 cm_idlest_offs[] = {
-	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3, OMAP24XX_CM_IDLEST4
-};
-
-u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
-{
-	return __raw_readl(cm_base + module + idx);
-}
-
-void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	__raw_writel(val, cm_base + module + idx);
-}
-
-/* Read-modify-write a register in a CM module. Caller must lock */
-u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
-{
-	u32 v;
-
-	v = omap2_cm_read_mod_reg(module, idx);
-	v &= ~mask;
-	v |= bits;
-	omap2_cm_write_mod_reg(v, module, idx);
-
-	return v;
-}
-
-u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_cm_rmw_mod_reg_bits(bits, bits, module, idx);
-}
-
-u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
-}
+static const u8 omap3xxx_cm_idlest_offs[] = { CM_IDLEST1, CM_IDLEST2 };
 
 /*
  *
@@ -85,33 +39,15 @@ static void _write_clktrctrl(u8 c, s16 module, u32 mask)
 	omap2_cm_write_mod_reg(v, module, OMAP2_CM_CLKSTCTRL);
 }
 
-bool omap2_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
+bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
 {
 	u32 v;
-	bool ret = 0;
-
-	BUG_ON(!cpu_is_omap24xx() && !cpu_is_omap34xx());
 
 	v = omap2_cm_read_mod_reg(module, OMAP2_CM_CLKSTCTRL);
 	v &= mask;
 	v >>= __ffs(mask);
 
-	if (cpu_is_omap24xx())
-		ret = (v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
-	else
-		ret = (v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
-
-	return ret;
-}
-
-void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
-{
-	_write_clktrctrl(OMAP24XX_CLKSTCTRL_ENABLE_AUTO, module, mask);
-}
-
-void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
-{
-	_write_clktrctrl(OMAP24XX_CLKSTCTRL_DISABLE_AUTO, module, mask);
+	return (v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
 }
 
 void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
@@ -135,101 +71,35 @@ void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask)
 }
 
 /*
- * DPLL autoidle control
- */
-
-static void _omap2xxx_set_dpll_autoidle(u8 m)
-{
-	u32 v;
-
-	v = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
-	v &= ~OMAP24XX_AUTO_DPLL_MASK;
-	v |= m << OMAP24XX_AUTO_DPLL_SHIFT;
-	omap2_cm_write_mod_reg(v, PLL_MOD, CM_AUTOIDLE);
-}
-
-void omap2xxx_cm_set_dpll_disable_autoidle(void)
-{
-	_omap2xxx_set_dpll_autoidle(OMAP2XXX_DPLL_AUTOIDLE_LOW_POWER_STOP);
-}
-
-void omap2xxx_cm_set_dpll_auto_low_power_stop(void)
-{
-	_omap2xxx_set_dpll_autoidle(DPLL_AUTOIDLE_DISABLE);
-}
-
-/*
- * APLL autoidle control
- */
-
-static void _omap2xxx_set_apll_autoidle(u8 m, u32 mask)
-{
-	u32 v;
-
-	v = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
-	v &= ~mask;
-	v |= m << __ffs(mask);
-	omap2_cm_write_mod_reg(v, PLL_MOD, CM_AUTOIDLE);
-}
-
-void omap2xxx_cm_set_apll54_disable_autoidle(void)
-{
-	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP,
-				    OMAP24XX_AUTO_54M_MASK);
-}
-
-void omap2xxx_cm_set_apll54_auto_low_power_stop(void)
-{
-	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_DISABLE,
-				    OMAP24XX_AUTO_54M_MASK);
-}
-
-void omap2xxx_cm_set_apll96_disable_autoidle(void)
-{
-	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP,
-				    OMAP24XX_AUTO_96M_MASK);
-}
-
-void omap2xxx_cm_set_apll96_auto_low_power_stop(void)
-{
-	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_DISABLE,
-				    OMAP24XX_AUTO_96M_MASK);
-}
-
-/*
  *
  */
 
 /**
- * omap2_cm_wait_idlest_ready - wait for a module to leave idle or standby
+ * omap3xxx_cm_wait_module_ready - wait for a module to leave idle or standby
  * @prcm_mod: PRCM module offset
  * @idlest_id: CM_IDLESTx register ID (i.e., x = 1, 2, 3)
  * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
  *
- * XXX document
+ * Wait for the PRCM to indicate that the module identified by
+ * (@prcm_mod, @idlest_id, @idlest_shift) is clocked.  Return 0 upon
+ * success or -EBUSY if the module doesn't enable in time.
  */
-int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
+int omap3xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 {
 	int ena = 0, i = 0;
 	u8 cm_idlest_reg;
 	u32 mask;
 
-	if (!idlest_id || (idlest_id > ARRAY_SIZE(cm_idlest_offs)))
+	if (!idlest_id || (idlest_id > ARRAY_SIZE(omap3xxx_cm_idlest_offs)))
 		return -EINVAL;
 
-	cm_idlest_reg = cm_idlest_offs[idlest_id - 1];
+	cm_idlest_reg = omap3xxx_cm_idlest_offs[idlest_id - 1];
 
 	mask = 1 << idlest_shift;
+	ena = 0;
 
-	if (cpu_is_omap24xx())
-		ena = mask;
-	else if (cpu_is_omap34xx())
-		ena = 0;
-	else
-		BUG();
-
-	omap_test_timeout(((omap2_cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) == ena),
-			  MAX_MODULE_READY_TIME, i);
+	omap_test_timeout(((omap2_cm_read_mod_reg(prcm_mod, cm_idlest_reg) &
+			    mask) == ena), MAX_MODULE_READY_TIME, i);
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
@@ -237,7 +107,6 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 /*
  * Context save/restore code - OMAP3 only
  */
-#ifdef CONFIG_ARCH_OMAP3
 struct omap3_cm_regs {
 	u32 iva2_cm_clksel1;
 	u32 iva2_cm_clksel2;
@@ -555,4 +424,3 @@ void omap3_cm_restore_context(void)
 	omap2_cm_write_mod_reg(cm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
 			       OMAP3_CM_CLKOUT_CTRL_OFFSET);
 }
-#endif
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
similarity index 50%
copy from arch/arm/mach-omap2/cm2xxx_3xxx.h
copy to arch/arm/mach-omap2/cm3xxx.h
index 57b2f3c..4a6ac81 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -13,15 +13,12 @@
  * other.  The CM modules/instances on OMAP4 are quite different, so
  * they are handled in a separate file.
  */
-#ifndef __ARCH_ASM_MACH_OMAP2_CM2XXX_3XXX_H
-#define __ARCH_ASM_MACH_OMAP2_CM2XXX_3XXX_H
+#ifndef __ARCH_ASM_MACH_OMAP2_CM3XXX_H
+#define __ARCH_ASM_MACH_OMAP2_CM3XXX_H
 
 #include "prcm-common.h"
+#include "cm2xxx_3xxx.h"
 
-#define OMAP2420_CM_REGADDR(module, reg)				\
-			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
-#define OMAP2430_CM_REGADDR(module, reg)				\
-			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
 #define OMAP34XX_CM_REGADDR(module, reg)				\
 			OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
 
@@ -45,36 +42,6 @@
  * These register offsets generally appear in more than one PRCM submodule.
  */
 
-/* Common between OMAP2 and OMAP3 */
-
-#define CM_FCLKEN					0x0000
-#define CM_FCLKEN1					CM_FCLKEN
-#define CM_CLKEN					CM_FCLKEN
-#define CM_ICLKEN					0x0010
-#define CM_ICLKEN1					CM_ICLKEN
-#define CM_ICLKEN2					0x0014
-#define CM_ICLKEN3					0x0018
-#define CM_IDLEST					0x0020
-#define CM_IDLEST1					CM_IDLEST
-#define CM_IDLEST2					0x0024
-#define CM_AUTOIDLE					0x0030
-#define CM_AUTOIDLE1					CM_AUTOIDLE
-#define CM_AUTOIDLE2					0x0034
-#define CM_AUTOIDLE3					0x0038
-#define CM_CLKSEL					0x0040
-#define CM_CLKSEL1					CM_CLKSEL
-#define CM_CLKSEL2					0x0044
-#define OMAP2_CM_CLKSTCTRL				0x0048
-
-/* OMAP2-specific register offsets */
-
-#define OMAP24XX_CM_FCLKEN2				0x0004
-#define OMAP24XX_CM_ICLKEN4				0x001c
-#define OMAP24XX_CM_AUTOIDLE4				0x003c
-#define OMAP24XX_CM_IDLEST4				0x002c
-
-#define OMAP2430_CM_IDLEST3				0x0028
-
 /* OMAP3-specific register offsets */
 
 #define OMAP3430_CM_CLKEN_PLL				0x0004
@@ -97,60 +64,23 @@
 
 /* CM_IDLEST bit field values to indicate deasserted IdleReq */
 
-#define OMAP24XX_CM_IDLEST_VAL				0
 #define OMAP34XX_CM_IDLEST_VAL				1
 
 
-/* Clock management domain register get/set */
-
 #ifndef __ASSEMBLER__
 
-extern u32 omap2_cm_read_mod_reg(s16 module, u16 idx);
-extern void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx);
-extern u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
-
-extern int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
-				      u8 idlest_shift);
-extern u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
-extern u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
-
-extern bool omap2_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
-extern void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
-extern void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
-
 extern void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
 
-extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
-extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
-
-extern void omap2xxx_cm_set_apll54_disable_autoidle(void);
-extern void omap2xxx_cm_set_apll54_auto_low_power_stop(void);
-extern void omap2xxx_cm_set_apll96_disable_autoidle(void);
-extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
-
-#endif
+extern bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
+extern int omap3xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
+					 u8 idlest_shift);
 
-/* CM register bits shared between 24XX and 3430 */
-
-/* CM_CLKSEL_GFX */
-#define OMAP_CLKSEL_GFX_SHIFT				0
-#define OMAP_CLKSEL_GFX_MASK				(0x7 << 0)
-
-/* CM_ICLKEN_GFX */
-#define OMAP_EN_GFX_SHIFT				0
-#define OMAP_EN_GFX_MASK				(1 << 0)
-
-/* CM_IDLEST_GFX */
-#define OMAP_ST_GFX_MASK				(1 << 0)
-
-
-/* Function prototypes */
-# ifndef __ASSEMBLER__
 extern void omap3_cm_save_context(void);
 extern void omap3_cm_restore_context(void);
-# endif
+
+#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1220e0e..a7d1eb8 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -23,7 +23,7 @@
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
 #include "prm3xxx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm3xxx.h"
 #include "sdrc.h"
 #include "pm.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 525c58d..504e0e0 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -147,7 +147,8 @@
 #include "common.h"
 #include "clockdomain.h"
 #include "powerdomain.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
+#include "cm3xxx.h"
 #include "cminst44xx.h"
 #include "cm33xx.h"
 #include "prm3xxx.h"
@@ -2668,7 +2669,7 @@ static int __init _alloc_linkspace(struct omap_hwmod_ocp_if **ois)
 /* Static functions intended only for use in soc_ops field function pointers */
 
 /**
- * _omap2_wait_target_ready - wait for a module to leave slave idle
+ * _omap2xxx_wait_target_ready - wait for a module to leave slave idle
  * @oh: struct omap_hwmod *
  *
  * Wait for a module @oh to leave slave idle.  Returns 0 if the module
@@ -2676,7 +2677,7 @@ static int __init _alloc_linkspace(struct omap_hwmod_ocp_if **ois)
  * slave idle; otherwise, pass along the return value of the
  * appropriate *_cm*_wait_module_ready() function.
  */
-static int _omap2_wait_target_ready(struct omap_hwmod *oh)
+static int _omap2xxx_wait_target_ready(struct omap_hwmod *oh)
 {
 	if (!oh)
 		return -EINVAL;
@@ -2689,9 +2690,36 @@ static int _omap2_wait_target_ready(struct omap_hwmod *oh)
 
 	/* XXX check module SIDLEMODE, hardreset status, enabled clocks */
 
-	return omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-					  oh->prcm.omap2.idlest_reg_id,
-					  oh->prcm.omap2.idlest_idle_bit);
+	return omap2xxx_cm_wait_module_ready(oh->prcm.omap2.module_offs,
+					     oh->prcm.omap2.idlest_reg_id,
+					     oh->prcm.omap2.idlest_idle_bit);
+}
+
+/**
+ * _omap3xxx_wait_target_ready - wait for a module to leave slave idle
+ * @oh: struct omap_hwmod *
+ *
+ * Wait for a module @oh to leave slave idle.  Returns 0 if the module
+ * does not have an IDLEST bit or if the module successfully leaves
+ * slave idle; otherwise, pass along the return value of the
+ * appropriate *_cm*_wait_module_ready() function.
+ */
+static int _omap3xxx_wait_target_ready(struct omap_hwmod *oh)
+{
+	if (!oh)
+		return -EINVAL;
+
+	if (oh->flags & HWMOD_NO_IDLEST)
+		return 0;
+
+	if (!_find_mpu_rt_port(oh))
+		return 0;
+
+	/* XXX check module SIDLEMODE, hardreset status, enabled clocks */
+
+	return omap3xxx_cm_wait_module_ready(oh->prcm.omap2.module_offs,
+					     oh->prcm.omap2.idlest_reg_id,
+					     oh->prcm.omap2.idlest_idle_bit);
 }
 
 /**
@@ -3959,8 +3987,13 @@ int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
  */
 void __init omap_hwmod_init(void)
 {
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		soc_ops.wait_target_ready = _omap2_wait_target_ready;
+	if (cpu_is_omap24xx()) {
+		soc_ops.wait_target_ready = _omap2xxx_wait_target_ready;
+		soc_ops.assert_hardreset = _omap2_assert_hardreset;
+		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
+	} else if (cpu_is_omap34xx()) {
+		soc_ops.wait_target_ready = _omap3xxx_wait_target_ready;
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 78405a7..02dca24 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -43,7 +43,7 @@
 #include "common.h"
 #include "prm2xxx.h"
 #include "prm-regbits-24xx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c02c9ca..c0f8a78 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -44,10 +44,9 @@
 #include <plat/dma.h>
 
 #include "common.h"
-#include "cm2xxx_3xxx.h"
+#include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
-
 #include "prm3xxx.h"
 #include "pm.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index d83b918..b5bc4b1 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -30,7 +30,7 @@
 
 #include "omap34xx.h"
 #include "iomap.h"
-#include "cm2xxx_3xxx.h"
+#include "cm3xxx.h"
 #include "prm3xxx.h"
 #include "sdrc.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index c720443..680a7c5 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -35,7 +35,7 @@
 #include "soc.h"
 #include "iomap.h"
 #include "prm2xxx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
 #include "sdrc.h"
 
 	.text
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index cfdc0bc..a1e9edd 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -35,7 +35,7 @@
 #include "soc.h"
 #include "iomap.h"
 #include "prm2xxx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx.h"
 #include "sdrc.h"
 
 	.text
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 2d0ceaa..1446331 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -32,7 +32,7 @@
 #include "soc.h"
 #include "iomap.h"
 #include "sdrc.h"
-#include "cm2xxx_3xxx.h"
+#include "cm3xxx.h"
 
 /*
  * This file needs be built unconditionally as ARM to interoperate correctly


