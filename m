From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 08/27] ARM: OMAP36xx: remove clock36xx.c/.h files
Date: Mon, 25 May 2015 18:00:13 +0300
Message-ID: <1432566032-10860-9-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33864 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbbEYPBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2015 11:01:08 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These files contain legacy clock implementations which are no longer used
for anything, thus remove them completely.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    2 +-
 arch/arm/mach-omap2/clock36xx.c |   69 ---------------------------------------
 arch/arm/mach-omap2/clock36xx.h |   13 --------
 3 files changed, 1 insertion(+), 83 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock36xx.c
 delete mode 100644 arch/arm/mach-omap2/clock36xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 98d5030..f33d011 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -188,7 +188,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o
 obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o
diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/clock36xx.c
deleted file mode 100644
index 91ccb96..0000000
--- a/arch/arm/mach-omap2/clock36xx.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * OMAP36xx-specific clkops
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- * Copyright (C) 2010 Nokia Corporation
- *
- * Mike Turquette
- * Vijaykumar GN
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
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-
-#include "clock.h"
-#include "clock36xx.h"
-#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
-
-/**
- * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
- *         from HSDivider PWRDN problem Implements Errata ID: i556.
- * @clk: DPLL output struct clk
- *
- * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
- * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
- * valueafter their respective PWRDN bits are set.  Any dummy write
- * (Any other value different from the Read value) to the
- * corresponding CM_CLKSEL register will refresh the dividers.
- */
-int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
-{
-	struct clk_divider *parent;
-	struct clk_hw *parent_hw;
-	u32 dummy_v, orig_v;
-	struct clk_hw_omap *omap_clk = to_clk_hw_omap(clk);
-	int ret;
-
-	/* Clear PWRDN bit of HSDIVIDER */
-	ret = omap2_dflt_clk_enable(clk);
-
-	parent_hw = __clk_get_hw(__clk_get_parent(clk->clk));
-	parent = to_clk_divider(parent_hw);
-
-	/* Restore the dividers */
-	if (!ret) {
-		orig_v = omap2_clk_readl(omap_clk, parent->reg);
-		dummy_v = orig_v;
-
-		/* Write any other value different from the Read value */
-		dummy_v ^= (1 << parent->shift);
-		omap2_clk_writel(dummy_v, omap_clk, parent->reg);
-
-		/* Write the original divider */
-		omap2_clk_writel(orig_v, omap_clk, parent->reg);
-	}
-
-	return ret;
-}
diff --git a/arch/arm/mach-omap2/clock36xx.h b/arch/arm/mach-omap2/clock36xx.h
deleted file mode 100644
index 945bb7f..0000000
--- a/arch/arm/mach-omap2/clock36xx.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * OMAP36xx clock function prototypes and macros
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- * Copyright (C) 2010 Nokia Corporation
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK36XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK36XX_H
-
-extern int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *hw);
-
-#endif
-- 
1.7.9.5

