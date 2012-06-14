From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 09/29] ARM: omap: clk: Nuke plat/clock.c & reuse struct clk as clk_hw_omap
Date: Thu, 14 Jun 2012 18:16:58 +0530
Message-ID: <1339678038-23082-10-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39646 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab2FNMrw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:47:52 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

plat/clock.c which has most of usecounting/locking infrastructure will
be used only for OMAP1 until that is moved to use COMMON clk.

reuse most of what plat/clock.h has while we move to common clk, and
move most of what 'struct clk' was as 'struct clk_hw_omap' which
will then be used to define platform specific parameters.
All usecounting/locking related variables from 'struct clk' are
dropped as they will not be used with 'struct clk_hw_omap'.

Based on the original changes from Mike Turquette.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/clock.c              |    2 +
 arch/arm/plat-omap/include/plat/clock.h |   69 +++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 62ec5c4..d311b7c 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -10,6 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifndef CONFIG_COMMON_CLK
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -567,3 +568,4 @@ err_out:
 late_initcall(clk_debugfs_init);
 
 #endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
+#endif /* CONFIG_COMMON_CLK */
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index d0ef57c..741275d 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -15,6 +15,14 @@
 
 #include <linux/list.h>
 
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
@@ -47,6 +55,7 @@ struct clkops {
 	void			(*allow_idle)(struct clk *);
 	void			(*deny_idle)(struct clk *);
 };
+#endif /* CONFIG_COMMON_CLK */
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
@@ -192,6 +201,65 @@ struct dpll_data {
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
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	void __iomem		*clksel_reg;
+	u32			clksel_mask;
+	const struct clksel	*clksel;
+	struct dpll_data	*dpll_data;
+	const char		*clkdm_name;
+	struct clockdomain	*clkdm;
+#else
+	u8			rate_offset;
+	u8			src_offset;
+#endif
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
@@ -303,4 +371,5 @@ extern const struct clkops clkops_null;
 
 extern struct clk dummy_ck;
 
+#endif /* CONFIG_COMMON_CLK */
 #endif
-- 
1.7.1

