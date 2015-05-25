From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 24/27] ARM: OMAP2+: clock: remove dead definitions from the clock header file
Date: Mon, 25 May 2015 18:00:29 +0300
Message-ID: <1432566032-10860-25-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59957 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbbEYPB5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:01:57 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Cleanup the mess in clock.h by removing all definitions that are no longer
used for anything.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |    1 -
 arch/arm/mach-omap2/clock.h            |  124 --------------------------------
 arch/arm/mach-omap2/clock34xx.h        |   18 -----
 3 files changed, 143 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock34xx.h

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 6cd2961..07e1956 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -23,7 +23,6 @@
 
 #include "clock.h"
 #include "clock3xxx.h"
-#include "clock34xx.h"
 #include "sdrc.h"
 #include "sram.h"
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a7e9511..1986ab2 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -23,90 +23,6 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 
-struct omap_clk {
-	u16				cpu;
-	struct clk_lookup		lk;
-};
-
-#define CLK(dev, con, ck)		\
-	{				\
-		.lk = {			\
-			.dev_id = dev,	\
-			.con_id = con,	\
-			.clk = ck,	\
-		},			\
-	}
-
-struct clockdomain;
-
-#define DEFINE_STRUCT_CLK(_name, _parent_array_name, _clkops_name)	\
-	static struct clk_core _name##_core = {			\
-		.name = #_name,					\
-		.hw = &_name##_hw.hw,				\
-		.parent_names = _parent_array_name,		\
-		.num_parents = ARRAY_SIZE(_parent_array_name),	\
-		.ops = &_clkops_name,				\
-	};							\
-	static struct clk _name = {				\
-		.core = &_name##_core,				\
-	};
-
-#define DEFINE_STRUCT_CLK_FLAGS(_name, _parent_array_name,	\
-				_clkops_name, _flags)		\
-	static struct clk_core _name##_core = {			\
-		.name = #_name,					\
-		.hw = &_name##_hw.hw,				\
-		.parent_names = _parent_array_name,		\
-		.num_parents = ARRAY_SIZE(_parent_array_name),	\
-		.ops = &_clkops_name,				\
-		.flags = _flags,				\
-	};							\
-	static struct clk _name = {				\
-		.core = &_name##_core,				\
-	};
-
-#define DEFINE_STRUCT_CLK_HW_OMAP(_name, _clkdm_name)		\
-	static struct clk_hw_omap _name##_hw = {		\
-		.hw = {						\
-			.clk = &_name,				\
-		},						\
-		.clkdm_name = _clkdm_name,			\
-	};
-
-#define DEFINE_CLK_OMAP_MUX(_name, _clkdm_name, _clksel,	\
-			    _clksel_reg, _clksel_mask,		\
-			    _parent_names, _ops)		\
-	static struct clk _name;				\
-	static struct clk_hw_omap _name##_hw = {		\
-		.hw = {						\
-			.clk = &_name,				\
-		},						\
-		.clksel		= _clksel,			\
-		.clksel_reg	= _clksel_reg,			\
-		.clksel_mask	= _clksel_mask,			\
-		.clkdm_name	= _clkdm_name,			\
-	};							\
-	DEFINE_STRUCT_CLK(_name, _parent_names, _ops);
-
-#define DEFINE_CLK_OMAP_MUX_GATE(_name, _clkdm_name, _clksel,	\
-				 _clksel_reg, _clksel_mask,	\
-				 _enable_reg, _enable_bit,	\
-				 _hwops, _parent_names, _ops)	\
-	static struct clk _name;				\
-	static struct clk_hw_omap _name##_hw = {		\
-		.hw = {						\
-			.clk = &_name,				\
-		},						\
-		.ops		= _hwops,			\
-		.enable_reg	= _enable_reg,			\
-		.enable_bit	= _enable_bit,			\
-		.clksel		= _clksel,			\
-		.clksel_reg	= _clksel_reg,			\
-		.clksel_mask	= _clksel_mask,			\
-		.clkdm_name	= _clkdm_name,			\
-	};							\
-	DEFINE_STRUCT_CLK(_name, _parent_names, _ops);
-
 /* struct clksel_rate.flags possibilities */
 #define RATE_IN_242X		(1 << 0)
 #define RATE_IN_243X		(1 << 1)
@@ -127,38 +43,6 @@ struct clockdomain;
 /* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, and all 36xx/37xx */
 #define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | RATE_IN_36XX)
 
-
-/**
- * struct clksel_rate - register bitfield values corresponding to clk divisors
- * @val: register bitfield value (shifted to bit 0)
- * @div: clock divisor corresponding to @val
- * @flags: (see "struct clksel_rate.flags possibilities" above)
- *
- * @val should match the value of a read from struct clk.clksel_reg
- * AND'ed with struct clk.clksel_mask, shifted right to bit 0.
- *
- * @div is the divisor that should be applied to the parent clock's rate
- * to produce the current clock's rate.
- */
-struct clksel_rate {
-	u32			val;
-	u8			div;
-	u16			flags;
-};
-
-/**
- * struct clksel - available parent clocks, and a pointer to their divisors
- * @parent: struct clk * to a possible parent clock
- * @rates: available divisors for this parent clock
- *
- * A struct clksel is always associated with one or more struct clks
- * and one or more struct clksel_rates.
- */
-struct clksel {
-	struct clk		 *parent;
-	const struct clksel_rate *rates;
-};
-
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
 #define CORE_CLK_SRC_32K		0x0
 #define CORE_CLK_SRC_DPLL		0x1
@@ -194,14 +78,6 @@ extern const struct clkops clkops_omap2_dflt;
 
 extern struct clk_functions omap2_clk_functions;
 
-extern const struct clk_hw_omap_ops clkhwops_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait;
-extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
-extern const struct clk_hw_omap_ops clkhwops_apll54;
-extern const struct clk_hw_omap_ops clkhwops_apll96;
-
 struct regmap;
 
 int __init omap2_clk_provider_init(struct device_node *np, int index,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
deleted file mode 100644
index 084ba71..0000000
--- a/arch/arm/mach-omap2/clock34xx.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * OMAP34xx clock function prototypes and macros
- *
- * Copyright (C) 2007-2010 Texas Instruments, Inc.
- * Copyright (C) 2007-2011 Nokia Corporation
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
-
-extern const struct clkops clkops_omap3430es2_ssi_wait;
-extern const struct clkops clkops_omap3430es2_iclk_ssi_wait;
-extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
-extern const struct clkops clkops_omap3430es2_iclk_hsotgusb_wait;
-extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
-extern const struct clkops clkops_omap3430es2_iclk_dss_usbhost_wait;
-
-#endif
-- 
1.7.9.5

