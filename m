From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 05/24] ARM: omap: clk: Nuke plat clock.c & clock.h if CONFIG_COMMON_CLK
Date: Fri, 1 Jun 2012 17:37:46 +0530
Message-ID: <1338552485-31325-6-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44474 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759511Ab2FAMIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 08:08:42 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Moving to COMMON clk, plat/clock.c and plat/clock.h files will no
longer be used. Move whatever is useful for OMAP2+ for implementing
platform code into mach/clock.h.

plat/clock.c which has most of usecounting/locking infrastructure will
be used only for OMAP1 until that is moved to use COMMON clk.
plat/clock.h will have the OMAP struct clk definition intact which
will also be used only on OMAP1.

A later patch which enables CONFIG_COMMON_CLK on OMAP2+ will get rid
of all OMAP2+ specific contents from plat/clock.h which are now moved
to mach/clock.h

Based on the original changes from Mike Turquette.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.h             |  227 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx.h         |    2 +
 arch/arm/mach-omap2/omap_hwmod.c        |    1 +
 arch/arm/mach-omap2/pm-debug.c          |    1 +
 arch/arm/plat-omap/clock.c              |    2 +
 arch/arm/plat-omap/include/plat/clock.h |    2 +
 6 files changed, 235 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a1bb23a..f18fe80 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -20,6 +20,233 @@
 
 #include <plat/clock.h>
 
+#ifdef CONFIG_COMMON_CLK
+
+#include <linux/clk-provider.h>
+#include <linux/list.h>
+
+#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
+
+struct clockdomain;
+
+#ifdef CONFIG_ARCH_OMAP2PLUS
+
+/* struct clksel_rate.flags possibilities */
+#define RATE_IN_242X		(1 << 0)
+#define RATE_IN_243X		(1 << 1)
+#define RATE_IN_3430ES1		(1 << 2)	/* 3430ES1 rates only */
+#define RATE_IN_3430ES2PLUS	(1 << 3)	/* 3430 ES >= 2 rates only */
+#define RATE_IN_36XX		(1 << 4)
+#define RATE_IN_4430		(1 << 5)
+#define RATE_IN_TI816X		(1 << 6)
+#define RATE_IN_4460		(1 << 7)
+#define RATE_IN_AM33XX		(1 << 8)
+#define RATE_IN_TI814X		(1 << 9)
+
+#define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
+#define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
+#define RATE_IN_3XXX		(RATE_IN_34XX | RATE_IN_36XX)
+#define RATE_IN_44XX		(RATE_IN_4430 | RATE_IN_4460)
+
+/* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, and all 36xx/37xx */
+#define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | RATE_IN_36XX)
+
+/* Platform flags for the clkdev-OMAP integration code */
+#define CK_242X		(1 << 4)
+#define CK_243X		(1 << 5)        /* 243x, 253x */
+#define CK_3430ES1	(1 << 6)        /* 34xxES1 only */
+#define CK_3430ES2PLUS	(1 << 7)        /* 34xxES2, ES3, non-Sitara 35xx only */
+#define CK_3505		(1 << 8)
+#define CK_3517		(1 << 9)
+#define CK_36XX		(1 << 10)       /* 36xx/37xx-specific clocks */
+#define CK_443X		(1 << 11)
+#define CK_TI816X	(1 << 12)
+#define CK_446X		(1 << 13)
+
+#define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
+#define CK_AM35XX	(CK_3505 | CK_3517)     /* all Sitara AM35xx */
+#define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
+
+/**
+ * struct clksel_rate - register bitfield values corresponding to clk divisors
+ * @val: register bitfield value (shifted to bit 0)
+ * @div: clock divisor corresponding to @val
+ * @flags: (see "struct clksel_rate.flags possibilities" above)
+ *
+ * @val should match the value of a read from struct clk.clksel_reg
+ * AND'ed with struct clk.clksel_mask, shifted right to bit 0.
+ *
+ * @div is the divisor that should be applied to the parent clock's rate
+ * to produce the current clock's rate.
+ */
+struct clksel_rate {
+	u32	val;
+	u8	div;
+	u8	flags;
+};
+
+/**
+ * struct clksel - available parent clocks, and a pointer to their divisors
+ * @parent: struct clk * to a possible parent clock
+ * @rates: available divisors for this parent clock
+ *
+ * A struct clksel is always associated with one or more struct clks
+ * and one or more struct clksel_rates.
+ */
+struct clksel {
+	struct clk			*parent;
+	const struct clksel_rate	*rates;
+};
+
+/**
+ * struct dpll_data - DPLL registers and integration data
+ * @mult_div1_reg: register containing the DPLL M and N bitfields
+ * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
+ * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
+ * @clk_bypass: struct clk pointer to the clock's bypass clock input
+ * @clk_ref: struct clk pointer to the clock's reference clock input
+ * @control_reg: register containing the DPLL mode bitfield
+ * @enable_mask: mask of the DPLL mode bitfield in @control_reg
+ * @last_rounded_rate: cache of the last rate result of omap2_dpll_round_rate()
+ * @last_rounded_m: cache of the last M result of omap2_dpll_round_rate()
+ * @max_multiplier: maximum valid non-bypass multiplier value (actual)
+ * @last_rounded_n: cache of the last N result of omap2_dpll_round_rate()
+ * @min_divider: minimum valid non-bypass divider value (actual)
+ * @max_divider: maximum valid non-bypass divider value (actual)
+ * @modes: possible values of @enable_mask
+ * @autoidle_reg: register containing the DPLL autoidle mode bitfield
+ * @idlest_reg: register containing the DPLL idle status bitfield
+ * @autoidle_mask: mask of the DPLL autoidle mode bitfield in @autoidle_reg
+ * @freqsel_mask: mask of the DPLL jitter correction bitfield in @control_reg
+ * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
+ * @auto_recal_bit: bitshift of the driftguard enable bit in @control_reg
+ * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for recalibration IRQs
+ * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for recalibration IRQs
+ * @flags: DPLL type/features (see below)
+ *
+ * Possible values for @flags:
+ * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
+ *
+ * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
+ *
+ * XXX Some DPLLs have multiple bypass inputs, so it's not technically
+ * correct to only have one @clk_bypass pointer.
+ *
+ * XXX The runtime-variable fields (@last_rounded_rate, @last_rounded_m,
+ * @last_rounded_n) should be separated from the runtime-fixed fields
+ * and placed into a different structure, so that the runtime-fixed data
+ * can be placed into read-only space.
+ */
+struct dpll_data {
+	void __iomem		*mult_div1_reg;
+	u32			mult_mask;
+	u32			div1_mask;
+	struct clk		*clk_bypass;
+	struct clk		*clk_ref;
+	void __iomem		*control_reg;
+	u32			enable_mask;
+	unsigned long		last_rounded_rate;
+	u16			last_rounded_m;
+	u16			max_multiplier;
+	u8			last_rounded_n;
+	u8			min_divider;
+	u16			max_divider;
+	u8			modes;
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	void __iomem		*autoidle_reg;
+	void __iomem		*idlest_reg;
+	u32			autoidle_mask;
+	u32			freqsel_mask;
+	u32			idlest_mask;
+	u32			dco_mask;
+	u32			sddiv_mask;
+	u8			auto_recal_bit;
+	u8			recal_en_bit;
+	u8			recal_st_bit;
+#  endif
+	u8                      flags;
+};
+
+#endif
+
+/*
+ * struct clk_hw_omap.flags possibilities
+ *
+ * XXX document the rest of the clock flags here
+ *
+ * CLOCK_CLKOUTX2: (OMAP4 only) DPLL CLKOUT and CLKOUTX2 GATE_CTRL
+ *     bits share the same register.  This flag allows the
+ *     omap4_dpllmx*() code to determine which GATE_CTRL bit field
+ *     should be used.  This is a temporary solution - a better approach
+ *     would be to associate clock type-specific data with the clock,
+ *     similar to the struct dpll_data approach.
+ */
+#define ENABLE_REG_32BIT	(1 << 0)        /* Use 32-bit access */
+#define CLOCK_IDLE_CONTROL	(1 << 1)
+#define CLOCK_NO_IDLE_PARENT	(1 << 2)
+#define ENABLE_ON_INIT		(1 << 3)        /* Enable upon framework init */
+#define INVERT_ENABLE		(1 << 4)        /* 0 enables, 1 disables */
+#define CLOCK_CLKOUTX2		(1 << 5)
+
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
+#endif /* CONFIG_COMMON_CLK */
+
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
 #define CORE_CLK_SRC_32K		0x0
 #define CORE_CLK_SRC_DPLL		0x1
diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xxx.h
index 8bbeeaf..3e7ec3e 100644
--- a/arch/arm/mach-omap2/clock3xxx.h
+++ b/arch/arm/mach-omap2/clock3xxx.h
@@ -8,6 +8,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
 
+#include "clock.h"
+
 int omap3xxx_clk_init(void);
 int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
 int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6c7c322..209857e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -152,6 +152,7 @@
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "mux.h"
+#include "clock.h"
 
 /* Maximum microseconds to wait for OMAP module to softreset */
 #define MAX_MODULE_SOFTRESET_WAIT	10000
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 814bcd9..6fa332c 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -37,6 +37,7 @@
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
+#include "clock.h"
 
 u32 enable_off_mode;
 
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
index d0ef57c..15a6d67 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -13,6 +13,7 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
+#ifndef CONFIG_COMMON_CLK
 #include <linux/list.h>
 
 struct module;
@@ -303,4 +304,5 @@ extern const struct clkops clkops_null;
 
 extern struct clk dummy_ck;
 
+#endif /* CONFIG_COMMON_CLK */
 #endif
-- 
1.7.1

