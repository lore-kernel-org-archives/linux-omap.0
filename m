From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 01/26] ARM: OMAP: clock: Nuke plat/clock.c & reuse struct clk as clk_hw_omap
Date: Wed, 7 Nov 2012 17:12:36 -0800
Message-ID: <1352337181-29427-2-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53052 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab2KHBN2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:28 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

plat/clock.c which has most of usecounting/locking infrastructure will
be used only for OMAP1 until that is moved to use COMMON clk.

reuse most of what plat/clock.h has while we move to common clk, and
move most of what 'struct clk' was as 'struct clk_hw_omap' which
will then be used to define platform specific parameters.
All usecounting/locking related variables from 'struct clk' are
dropped as they will not be used with 'struct clk_hw_omap'.

Based on the original changes from Mike Turquette.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clock.h |   64 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index cfba1ff..1fb9ecb 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -52,6 +52,14 @@ struct omap_clk {
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
 #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
 
+#ifdef CONFIG_COMMON_CLK
+#include <linux/clk-provider.h>
+
+struct clockdomain;
+#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
+
+#else
+
 struct module;
 struct clk;
 struct clockdomain;
@@ -89,6 +97,7 @@ struct clkops {
 	void			(*allow_idle)(struct clk *);
 	void			(*deny_idle)(struct clk *);
 };
+#endif
 
 /* struct clksel_rate.flags possibilities */
 #define RATE_IN_242X		(1 << 0)
@@ -228,6 +237,60 @@ struct dpll_data {
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 #define CLOCK_CLKOUTX2		(1 << 5)
 
+#ifdef CONFIG_COMMON_CLK
+/**
+ * struct clk_hw_omap - OMAP struct clk
+ * @node: list_head connecting this clock into the full clock list
+ * @enable_reg: register to write to enable the clock (see @enable_bit)
+ * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
+ * @flags: see "struct clk.flags possibilities" above
+ * @clksel_reg: for clksel clks, register va containing src/divisor select
+ * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
+ * @clksel: for clksel clks, pointer to struct clksel for this clock
+ * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
+ * @clkdm_name: clockdomain name that this clock is contained in
+ * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
+ * @rate_offset: bitshift for rate selection bitfield (OMAP1 only)
+ * @src_offset: bitshift for source selection bitfield (OMAP1 only)
+ *
+ * XXX @rate_offset, @src_offset should probably be removed and OMAP1
+ * clock code converted to use clksel.
+ *
+ */
+
+struct clk_hw_omap_ops;
+
+struct clk_hw_omap {
+	struct clk_hw		hw;
+	struct list_head	node;
+	unsigned long		fixed_rate;
+	u8			fixed_div;
+	void __iomem		*enable_reg;
+	u8			enable_bit;
+	u8			flags;
+	void __iomem		*clksel_reg;
+	u32			clksel_mask;
+	const struct clksel	*clksel;
+	struct dpll_data	*dpll_data;
+	const char		*clkdm_name;
+	struct clockdomain	*clkdm;
+	const struct clk_hw_omap_ops	*ops;
+};
+
+struct clk_hw_omap_ops {
+	void			(*find_idlest)(struct clk_hw_omap *oclk,
+					void __iomem **idlest_reg,
+					u8 *idlest_bit, u8 *idlest_val);
+	void			(*find_companion)(struct clk_hw_omap *oclk,
+					void __iomem **other_reg,
+					u8 *other_bit);
+	void			(*allow_idle)(struct clk_hw_omap *oclk);
+	void			(*deny_idle)(struct clk_hw_omap *oclk);
+};
+
+unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
+		unsigned long parent_rate);
+#else
 /**
  * struct clk - OMAP struct clk
  * @node: list_head connecting this clock into the full clock list
@@ -484,4 +547,5 @@ extern struct clk virt_26000000_ck;
 
 extern int am33xx_clk_init(void);
 
+#endif /* CONFIG_COMMON_CLK */
 #endif
-- 
1.7.9.5

