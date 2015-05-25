From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 22/27] clk: ti: am3517: move remaining am3517 clock support code to clock driver
Date: Mon, 25 May 2015 18:00:27 +0300
Message-ID: <1432566032-10860-23-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49004 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbbEYPBr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:01:47 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With legacy clock support gone, this is no longer needed under platform,
so move it under the clock driver itself. Make some exports be driver
internal definitions at the same time.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    1 -
 arch/arm/mach-omap2/clock3517.c |  118 ---------------------------------------
 arch/arm/mach-omap2/clock3517.h |   14 -----
 drivers/clk/ti/clk-3xxx.c       |   94 +++++++++++++++++++++++++++++++
 drivers/clk/ti/clock.h          |    2 +
 include/linux/clk/ti.h          |    2 -
 6 files changed, 96 insertions(+), 135 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock3517.c
 delete mode 100644 arch/arm/mach-omap2/clock3517.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 22d2e48..d424920 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -187,7 +187,6 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= clkt34xx_dpll3m2.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common)
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/clock3517.c
deleted file mode 100644
index 4d79ae2..0000000
--- a/arch/arm/mach-omap2/clock3517.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * OMAP3517/3505-specific clock framework functions
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- * Copyright (C) 2011 Nokia Corporation
- *
- * Ranjith Lohithakshan
- * Paul Walmsley
- *
- * Parts of this code are based on code written by
- * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu,
- * Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include "clock.h"
-#include "clock3517.h"
-#include "cm3xxx.h"
-#include "cm-regbits-34xx.h"
-
-/*
- * In AM35xx IPSS, the {ICK,FCK} enable bits for modules are exported
- * in the same register at a bit offset of 0x8. The EN_ACK for ICK is
- * at an offset of 4 from ICK enable bit.
- */
-#define AM35XX_IPSS_ICK_MASK			0xF
-#define AM35XX_IPSS_ICK_EN_ACK_OFFSET 		0x4
-#define AM35XX_IPSS_ICK_FCK_OFFSET		0x8
-#define AM35XX_IPSS_CLK_IDLEST_VAL		0
-
-/**
- * am35xx_clk_find_idlest - return clock ACK info for AM35XX IPSS
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * The interface clocks on AM35xx IPSS reflects the clock idle status
- * in the enable register itsel at a bit offset of 4 from the enable
- * bit. A value of 1 indicates that clock is enabled.
- */
-static void am35xx_clk_find_idlest(struct clk_hw_omap *clk,
-					    void __iomem **idlest_reg,
-					    u8 *idlest_bit,
-					    u8 *idlest_val)
-{
-	*idlest_reg = (__force void __iomem *)(clk->enable_reg);
-	*idlest_bit = clk->enable_bit + AM35XX_IPSS_ICK_EN_ACK_OFFSET;
-	*idlest_val = AM35XX_IPSS_CLK_IDLEST_VAL;
-}
-
-/**
- * am35xx_clk_find_companion - find companion clock to @clk
- * @clk: struct clk * to find the companion clock of
- * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va in
- * @other_bit: u8 ** to return the companion clock bit shift in
- *
- * Some clocks don't have companion clocks.  For example, modules with
- * only an interface clock (such as HECC) don't have a companion
- * clock.  Right now, this code relies on the hardware exporting a bit
- * in the correct companion register that indicates that the
- * nonexistent 'companion clock' is active.  Future patches will
- * associate this type of code with per-module data structures to
- * avoid this issue, and remove the casts.  No return value.
- */
-static void am35xx_clk_find_companion(struct clk_hw_omap *clk,
-				      void __iomem **other_reg,
-				      u8 *other_bit)
-{
-	*other_reg = (__force void __iomem *)(clk->enable_reg);
-	if (clk->enable_bit & AM35XX_IPSS_ICK_MASK)
-		*other_bit = clk->enable_bit + AM35XX_IPSS_ICK_FCK_OFFSET;
-	else
-		*other_bit = clk->enable_bit - AM35XX_IPSS_ICK_FCK_OFFSET;
-}
-const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait = {
-	.find_idlest	= am35xx_clk_find_idlest,
-	.find_companion	= am35xx_clk_find_companion,
-};
-
-/**
- * am35xx_clk_ipss_find_idlest - return CM_IDLEST info for IPSS
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * The IPSS target CM_IDLEST bit is at a different shift from the
- * CM_{I,F}CLKEN bit.  Pass back the correct info via @idlest_reg
- * and @idlest_bit.  No return value.
- */
-static void am35xx_clk_ipss_find_idlest(struct clk_hw_omap *clk,
-					    void __iomem **idlest_reg,
-					    u8 *idlest_bit,
-					    u8 *idlest_val)
-{
-	u32 r;
-
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
-	*idlest_bit = AM35XX_ST_IPSS_SHIFT;
-	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
-}
-
-const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait = {
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-	.find_idlest	= am35xx_clk_ipss_find_idlest,
-	.find_companion	= omap2_clk_dflt_find_companion,
-};
diff --git a/arch/arm/mach-omap2/clock3517.h b/arch/arm/mach-omap2/clock3517.h
deleted file mode 100644
index ca5e5a6..0000000
--- a/arch/arm/mach-omap2/clock3517.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * OMAP3517/3505 clock function prototypes and macros
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- * Copyright (C) 2010 Nokia Corporation
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK3517_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK3517_H
-
-extern const struct clkops clkops_am35xx_ipss_module_wait;
-extern const struct clkops clkops_am35xx_ipss_wait;
-
-#endif
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 58879f0..6e33332 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -34,6 +34,18 @@
 
 #define OMAP34XX_CM_IDLEST_VAL				1
 
+/*
+ * In AM35xx IPSS, the {ICK,FCK} enable bits for modules are exported
+ * in the same register at a bit offset of 0x8. The EN_ACK for ICK is
+ * at an offset of 4 from ICK enable bit.
+ */
+#define AM35XX_IPSS_ICK_MASK			0xF
+#define AM35XX_IPSS_ICK_EN_ACK_OFFSET		0x4
+#define AM35XX_IPSS_ICK_FCK_OFFSET		0x8
+#define AM35XX_IPSS_CLK_IDLEST_VAL		0
+
+#define AM35XX_ST_IPSS_SHIFT			5
+
 /**
  * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
  * @clk: struct clk * being enabled
@@ -146,6 +158,88 @@ const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait = {
 	.find_companion	= omap2_clk_dflt_find_companion,
 };
 
+/**
+ * am35xx_clk_find_idlest - return clock ACK info for AM35XX IPSS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * The interface clocks on AM35xx IPSS reflects the clock idle status
+ * in the enable register itsel at a bit offset of 4 from the enable
+ * bit. A value of 1 indicates that clock is enabled.
+ */
+static void am35xx_clk_find_idlest(struct clk_hw_omap *clk,
+				   void __iomem **idlest_reg,
+				   u8 *idlest_bit,
+				   u8 *idlest_val)
+{
+	*idlest_reg = (__force void __iomem *)(clk->enable_reg);
+	*idlest_bit = clk->enable_bit + AM35XX_IPSS_ICK_EN_ACK_OFFSET;
+	*idlest_val = AM35XX_IPSS_CLK_IDLEST_VAL;
+}
+
+/**
+ * am35xx_clk_find_companion - find companion clock to @clk
+ * @clk: struct clk * to find the companion clock of
+ * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va in
+ * @other_bit: u8 ** to return the companion clock bit shift in
+ *
+ * Some clocks don't have companion clocks.  For example, modules with
+ * only an interface clock (such as HECC) don't have a companion
+ * clock.  Right now, this code relies on the hardware exporting a bit
+ * in the correct companion register that indicates that the
+ * nonexistent 'companion clock' is active.  Future patches will
+ * associate this type of code with per-module data structures to
+ * avoid this issue, and remove the casts.  No return value.
+ */
+static void am35xx_clk_find_companion(struct clk_hw_omap *clk,
+				      void __iomem **other_reg,
+				      u8 *other_bit)
+{
+	*other_reg = (__force void __iomem *)(clk->enable_reg);
+	if (clk->enable_bit & AM35XX_IPSS_ICK_MASK)
+		*other_bit = clk->enable_bit + AM35XX_IPSS_ICK_FCK_OFFSET;
+	else
+	*other_bit = clk->enable_bit - AM35XX_IPSS_ICK_FCK_OFFSET;
+}
+
+const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait = {
+	.find_idlest	= am35xx_clk_find_idlest,
+	.find_companion	= am35xx_clk_find_companion,
+};
+
+/**
+ * am35xx_clk_ipss_find_idlest - return CM_IDLEST info for IPSS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * The IPSS target CM_IDLEST bit is at a different shift from the
+ * CM_{I,F}CLKEN bit.  Pass back the correct info via @idlest_reg
+ * and @idlest_bit.  No return value.
+ */
+static void am35xx_clk_ipss_find_idlest(struct clk_hw_omap *clk,
+					void __iomem **idlest_reg,
+					u8 *idlest_bit,
+					u8 *idlest_val)
+{
+	u32 r;
+
+	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg = (__force void __iomem *)r;
+	*idlest_bit = AM35XX_ST_IPSS_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
+}
+
+const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait = {
+	.allow_idle	= omap2_clkt_iclk_allow_idle,
+	.deny_idle	= omap2_clkt_iclk_deny_idle,
+	.find_idlest	= am35xx_clk_ipss_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+
 static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "apb_pclk", "dummy_apb_pclk"),
 	DT_CLK(NULL, "omap_32k_fck", "omap_32k_fck"),
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index c6fbd15..0ca5a36 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -183,6 +183,8 @@ extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
+extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
+extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
 
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 813b809..fc8e9ad 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -331,8 +331,6 @@ void ti_clk_setup_features(struct ti_clk_features *features);
 struct ti_clk_features *ti_clk_get_features(void);
 
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
-extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
-extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
 
 #ifdef CONFIG_ATAGS
 int omap3430_clk_legacy_init(void);
-- 
1.7.9.5

