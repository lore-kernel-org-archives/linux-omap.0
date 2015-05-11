From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 18/27] clk: ti: omap2430: move clock support code under clock driver
Date: Mon, 11 May 2015 11:54:44 +0300
Message-ID: <1431334493-24455-19-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49524 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbbEKIzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 04:55:35 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With the legacy clock support gone, this is no longer needed under
platform code-base. Thus, move this under the TI clock driver, and
remove the exported API from the public header.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    1 -
 arch/arm/mach-omap2/clock2430.c |   57 ---------------------------------------
 drivers/clk/ti/clkt_iclk.c      |   35 ++++++++++++++++++++++++
 drivers/clk/ti/clock.h          |    1 +
 include/linux/clk/ti.h          |    1 -
 5 files changed, 36 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock2430.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 07052656..695d58f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -185,7 +185,6 @@ obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common)
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o
-obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
deleted file mode 100644
index cef0c8d..0000000
--- a/arch/arm/mach-omap2/clock2430.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * clock2430.c - OMAP2430-specific clock integration code
- *
- * Copyright (C) 2005-2008 Texas Instruments, Inc.
- * Copyright (C) 2004-2010 Nokia Corporation
- *
- * Contacts:
- * Richard Woodruff <r-woodruff2@ti.com>
- * Paul Walmsley
- *
- * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
- * Gordon McNutt and RidgeRun, Inc.
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
-#include "soc.h"
-#include "iomap.h"
-#include "clock.h"
-#include "clock2xxx.h"
-#include "cm2xxx.h"
-#include "cm-regbits-24xx.h"
-
-/**
- * omap2430_clk_i2chs_find_idlest - return CM_IDLEST info for 2430 I2CHS
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
- * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
- * passes back the correct CM_IDLEST register address for I2CHS
- * modules.  No return value.
- */
-static void omap2430_clk_i2chs_find_idlest(struct clk_hw_omap *clk,
-					   void __iomem **idlest_reg,
-					   u8 *idlest_bit,
-					   u8 *idlest_val)
-{
-	*idlest_reg = OMAP2430_CM_REGADDR(CORE_MOD, CM_IDLEST);
-	*idlest_bit = clk->enable_bit;
-	*idlest_val = OMAP24XX_CM_IDLEST_VAL;
-}
-
-/* 2430 I2CHS has non-standard IDLEST register */
-const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait = {
-	.find_idlest	= omap2430_clk_i2chs_find_idlest,
-	.find_companion	= omap2_clk_dflt_find_companion,
-};
diff --git a/drivers/clk/ti/clkt_iclk.c b/drivers/clk/ti/clkt_iclk.c
index a03919d..38c3690 100644
--- a/drivers/clk/ti/clkt_iclk.c
+++ b/drivers/clk/ti/clkt_iclk.c
@@ -18,8 +18,12 @@
 #include "clock.h"
 
 /* Register offsets */
+#define OMAP24XX_CM_FCLKEN2		0x04
 #define CM_AUTOIDLE			0x30
 #define CM_ICLKEN			0x10
+#define CM_IDLEST			0x20
+
+#define OMAP24XX_CM_IDLEST_VAL		0
 
 /* Private functions */
 
@@ -51,6 +55,31 @@ void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk)
 	ti_clk_ll_ops->clk_writel(v, r);
 }
 
+/**
+ * omap2430_clk_i2chs_find_idlest - return CM_IDLEST info for 2430 I2CHS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
+ * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
+ * passes back the correct CM_IDLEST register address for I2CHS
+ * modules.  No return value.
+ */
+static void omap2430_clk_i2chs_find_idlest(struct clk_hw_omap *clk,
+					   void __iomem **idlest_reg,
+					   u8 *idlest_bit,
+					   u8 *idlest_val)
+{
+	u32 r;
+
+	r = ((__force u32)clk->enable_reg ^ (OMAP24XX_CM_FCLKEN2 ^ CM_IDLEST));
+	*idlest_reg = (__force void __iomem *)r;
+	*idlest_bit = clk->enable_bit;
+	*idlest_val = OMAP24XX_CM_IDLEST_VAL;
+}
+
 /* Public data */
 
 const struct clk_hw_omap_ops clkhwops_iclk = {
@@ -64,3 +93,9 @@ const struct clk_hw_omap_ops clkhwops_iclk_wait = {
 	.find_idlest	= omap2_clk_dflt_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
 };
+
+/* 2430 I2CHS has non-standard IDLEST register */
+const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait = {
+	.find_idlest	= omap2430_clk_i2chs_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index f215383..3652c26 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -178,6 +178,7 @@ extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
 
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 891fe0f..a7728f7 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -333,7 +333,6 @@ void ti_clk_setup_features(struct ti_clk_features *features);
 struct ti_clk_features *ti_clk_get_features(void);
 
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
-extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
-- 
1.7.9.5

