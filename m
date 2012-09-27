From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/6] ARM: OMAP: remove plat/clock.h
Date: Thu, 27 Sep 2012 10:33:34 -0600
Message-ID: <20120927163333.21755.48035.stgit@dusk.lan>
References: <20120927162800.21755.62891.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46756 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2I0Qf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 12:35:57 -0400
In-Reply-To: <20120927162800.21755.62891.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove arch/arm/plat-omap/include/plat/clock.h by merging it into
arch/arm/mach-omap1/clock.h and arch/arm/mach-omap2/clock.h.
The goal here is to facilitate ARM single image kernels by removing
includes via the "plat/" symlink.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/board-nokia770.c         |    2 
 arch/arm/mach-omap1/clock.c                  |    2 
 arch/arm/mach-omap1/clock.h                  |  153 +++++++++++++
 arch/arm/mach-omap1/clock_data.c             |    2 
 arch/arm/mach-omap1/pm.c                     |    2 
 arch/arm/mach-omap2/clkt2xxx_apll.c          |    2 
 arch/arm/mach-omap2/clkt2xxx_dpll.c          |    2 
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |    2 
 arch/arm/mach-omap2/clkt2xxx_osc.c           |    2 
 arch/arm/mach-omap2/clkt2xxx_sys.c           |    2 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |    2 
 arch/arm/mach-omap2/clkt_clksel.c            |    2 
 arch/arm/mach-omap2/clkt_dpll.c              |    2 
 arch/arm/mach-omap2/clkt_iclk.c              |    2 
 arch/arm/mach-omap2/clock.c                  |    2 
 arch/arm/mach-omap2/clock.h                  |  284 ++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2430.c              |    2 
 arch/arm/mach-omap2/clock2xxx.c              |    2 
 arch/arm/mach-omap2/clock34xx.c              |    2 
 arch/arm/mach-omap2/clock3517.c              |    2 
 arch/arm/mach-omap2/clock36xx.c              |    2 
 arch/arm/mach-omap2/clock3xxx.c              |    2 
 arch/arm/mach-omap2/clockdomain.c            |    2 
 arch/arm/mach-omap2/clockdomain.h            |    2 
 arch/arm/mach-omap2/common.c                 |    2 
 arch/arm/mach-omap2/dpll3xxx.c               |    2 
 arch/arm/mach-omap2/dpll44xx.c               |    2 
 arch/arm/mach-omap2/omap_hwmod.c             |    2 
 arch/arm/mach-omap2/pm-debug.c               |    2 
 arch/arm/mach-omap2/pm24xx.c                 |    2 
 arch/arm/mach-omap2/sdram-nokia.c            |    2 
 arch/arm/mach-omap2/sdrc.c                   |    2 
 arch/arm/mach-omap2/sdrc2xxx.c               |    2 
 arch/arm/plat-omap/counter_32k.c             |    1 
 arch/arm/plat-omap/include/plat/clock.h      |  309 --------------------------
 arch/arm/plat-omap/omap_device.c             |    1 
 37 files changed, 467 insertions(+), 345 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/clock.h

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index ec01f03..fef0a93 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -29,7 +29,7 @@
 #include <plat/keypad.h>
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
-#include <plat/clock.h>
+#include "clock.h"
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 76c3f13..847b38a 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -24,7 +24,7 @@
 
 #include <plat/cpu.h>
 #include <plat/usb.h>
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sram.h>
 #include <plat/clkdev_omap.h>
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 3d04f4f..155ddd9 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -14,8 +14,159 @@
 #define __ARCH_ARM_MACH_OMAP1_CLOCK_H
 
 #include <linux/clk.h>
+#include <linux/list.h>
 
-#include <plat/clock.h>
+struct module;
+struct clk;
+
+/* Temporary, needed during the common clock framework conversion */
+#define __clk_get_name(clk)	(clk->name)
+#define __clk_get_parent(clk)	(clk->parent)
+#define __clk_get_rate(clk)	(clk->rate)
+
+/**
+ * struct clkops - some clock function pointers
+ * @enable: fn ptr that enables the current clock in hardware
+ * @disable: fn ptr that enables the current clock in hardware
+ * @find_idlest: function returning the IDLEST register for the clock's IP blk
+ * @find_companion: function returning the "companion" clk reg for the clock
+ * @allow_idle: fn ptr that enables autoidle for the current clock in hardware
+ * @deny_idle: fn ptr that disables autoidle for the current clock in hardware
+ *
+ * A "companion" clk is an accompanying clock to the one being queried
+ * that must be enabled for the IP module connected to the clock to
+ * become accessible by the hardware.  Neither @find_idlest nor
+ * @find_companion should be needed; that information is IP
+ * block-specific; the hwmod code has been created to handle this, but
+ * until hwmod data is ready and drivers have been converted to use PM
+ * runtime calls in place of clk_enable()/clk_disable(), @find_idlest and
+ * @find_companion must, unfortunately, remain.
+ */
+struct clkops {
+	int			(*enable)(struct clk *);
+	void			(*disable)(struct clk *);
+	void			(*find_idlest)(struct clk *, void __iomem **,
+					       u8 *, u8 *);
+	void			(*find_companion)(struct clk *, void __iomem **,
+						  u8 *);
+	void			(*allow_idle)(struct clk *);
+	void			(*deny_idle)(struct clk *);
+};
+
+/*
+ * struct clk.flags possibilities
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
+#define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
+#define CLOCK_IDLE_CONTROL	(1 << 1)
+#define CLOCK_NO_IDLE_PARENT	(1 << 2)
+#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
+#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
+#define CLOCK_CLKOUTX2		(1 << 5)
+
+/**
+ * struct clk - OMAP struct clk
+ * @node: list_head connecting this clock into the full clock list
+ * @ops: struct clkops * for this clock
+ * @name: the name of the clock in the hardware (used in hwmod data and debug)
+ * @parent: pointer to this clock's parent struct clk
+ * @children: list_head connecting to the child clks' @sibling list_heads
+ * @sibling: list_head connecting this clk to its parent clk's @children
+ * @rate: current clock rate
+ * @enable_reg: register to write to enable the clock (see @enable_bit)
+ * @recalc: fn ptr that returns the clock's current rate
+ * @set_rate: fn ptr that can change the clock's current rate
+ * @round_rate: fn ptr that can round the clock's current rate
+ * @init: fn ptr to do clock-specific initialization
+ * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
+ * @usecount: number of users that have requested this clock to be enabled
+ * @fixed_div: when > 0, this clock's rate is its parent's rate / @fixed_div
+ * @flags: see "struct clk.flags possibilities" above
+ * @rate_offset: bitshift for rate selection bitfield (OMAP1 only)
+ * @src_offset: bitshift for source selection bitfield (OMAP1 only)
+ *
+ * XXX @rate_offset, @src_offset should probably be removed and OMAP1
+ * clock code converted to use clksel.
+ *
+ * XXX @usecount is poorly named.  It should be "enable_count" or
+ * something similar.  "users" in the description refers to kernel
+ * code (core code or drivers) that have called clk_enable() and not
+ * yet called clk_disable(); the usecount of parent clocks is also
+ * incremented by the clock code when clk_enable() is called on child
+ * clocks and decremented by the clock code when clk_disable() is
+ * called on child clocks.
+ *
+ * XXX @clkdm, @usecount, @children, @sibling should be marked for
+ * internal use only.
+ *
+ * @children and @sibling are used to optimize parent-to-child clock
+ * tree traversals.  (child-to-parent traversals use @parent.)
+ *
+ * XXX The notion of the clock's current rate probably needs to be
+ * separated from the clock's target rate.
+ */
+struct clk {
+	struct list_head	node;
+	const struct clkops	*ops;
+	const char		*name;
+	struct clk		*parent;
+	struct list_head	children;
+	struct list_head	sibling;	/* node for children */
+	unsigned long		rate;
+	void __iomem		*enable_reg;
+	unsigned long		(*recalc)(struct clk *);
+	int			(*set_rate)(struct clk *, unsigned long);
+	long			(*round_rate)(struct clk *, unsigned long);
+	void			(*init)(struct clk *);
+	u8			enable_bit;
+	s8			usecount;
+	u8			fixed_div;
+	u8			flags;
+	u8			rate_offset;
+	u8			src_offset;
+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
+	struct dentry		*dent;	/* For visible tree hierarchy */
+#endif
+};
+
+struct clk_functions {
+	int		(*clk_enable)(struct clk *clk);
+	void		(*clk_disable)(struct clk *clk);
+	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
+	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
+	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
+	void		(*clk_allow_idle)(struct clk *clk);
+	void		(*clk_deny_idle)(struct clk *clk);
+	void		(*clk_disable_unused)(struct clk *clk);
+};
+
+extern int mpurate;
+
+extern int clk_init(struct clk_functions *custom_clocks);
+extern void clk_preinit(struct clk *clk);
+extern int clk_register(struct clk *clk);
+extern void clk_reparent(struct clk *child, struct clk *parent);
+extern void clk_unregister(struct clk *clk);
+extern void propagate_rate(struct clk *clk);
+extern void recalculate_root_clocks(void);
+extern unsigned long followparent_recalc(struct clk *clk);
+extern void clk_enable_init_clocks(void);
+unsigned long omap_fixed_divisor_recalc(struct clk *clk);
+extern struct clk *omap_clk_get_by_name(const char *name);
+extern int omap_clk_enable_autoidle_all(void);
+extern int omap_clk_disable_autoidle_all(void);
+
+extern const struct clkops clkops_null;
+
+extern struct clk dummy_ck;
 
 int omap1_clk_init(void);
 void omap1_clk_late_init(void);
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 53e166c..9c376f5 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -22,7 +22,7 @@
 
 #include <asm/mach-types.h>  /* for machine_is_* */
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/cpu.h>
 #include <plat/clkdev_omap.h>
 #include <plat/sram.h>	/* for omap_sram_reprogram_clock() */
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index b2560d3..7049415 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -50,7 +50,7 @@
 #include <asm/mach/irq.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sram.h>
 #include <plat/tc.h>
 #include <plat/mux.h>
diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index c2d15212..54bc276 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/prcm.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpll.c b/arch/arm/mach-omap2/clkt2xxx_dpll.c
index 1502a7b..377e786 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpll.c
@@ -14,7 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 4ae4392..408307d7 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -25,7 +25,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_osc.c b/arch/arm/mach-omap2/clkt2xxx_osc.c
index c346092..175d036 100644
--- a/arch/arm/mach-omap2/clkt2xxx_osc.c
+++ b/arch/arm/mach-omap2/clkt2xxx_osc.c
@@ -23,7 +23,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_sys.c b/arch/arm/mach-omap2/clkt2xxx_sys.c
index 8693cfd..701a518 100644
--- a/arch/arm/mach-omap2/clkt2xxx_sys.c
+++ b/arch/arm/mach-omap2/clkt2xxx_sys.c
@@ -22,7 +22,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 3524f0e..7a79d22 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -33,7 +33,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 7c6da2f..84f5815 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index eaed390..40c744b 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -45,7 +45,7 @@
 #include <linux/io.h>
 #include <linux/bug.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "clock.h"
 
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 8041114..dd82114 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -21,7 +21,7 @@
 
 #include <asm/div64.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "soc.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 3d43fba..0f66529 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -14,7 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/prcm.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 33f5b5d..d0345c6 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -26,7 +26,7 @@
 
 #include <asm/cpu.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/prcm.h>
 
 #include <trace/events/power.h>
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 35ec5f3..c3bf8c2 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -17,8 +17,290 @@
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_H
 
 #include <linux/kernel.h>
+#include <linux/list.h>
+
+struct module;
+struct clk;
+struct clockdomain;
+
+/* Temporary, needed during the common clock framework conversion */
+#define __clk_get_name(clk)	(clk->name)
+#define __clk_get_parent(clk)	(clk->parent)
+#define __clk_get_rate(clk)	(clk->rate)
+
+/**
+ * struct clkops - some clock function pointers
+ * @enable: fn ptr that enables the current clock in hardware
+ * @disable: fn ptr that enables the current clock in hardware
+ * @find_idlest: function returning the IDLEST register for the clock's IP blk
+ * @find_companion: function returning the "companion" clk reg for the clock
+ * @allow_idle: fn ptr that enables autoidle for the current clock in hardware
+ * @deny_idle: fn ptr that disables autoidle for the current clock in hardware
+ *
+ * A "companion" clk is an accompanying clock to the one being queried
+ * that must be enabled for the IP module connected to the clock to
+ * become accessible by the hardware.  Neither @find_idlest nor
+ * @find_companion should be needed; that information is IP
+ * block-specific; the hwmod code has been created to handle this, but
+ * until hwmod data is ready and drivers have been converted to use PM
+ * runtime calls in place of clk_enable()/clk_disable(), @find_idlest and
+ * @find_companion must, unfortunately, remain.
+ */
+struct clkops {
+	int			(*enable)(struct clk *);
+	void			(*disable)(struct clk *);
+	void			(*find_idlest)(struct clk *, void __iomem **,
+					       u8 *, u8 *);
+	void			(*find_companion)(struct clk *, void __iomem **,
+						  u8 *);
+	void			(*allow_idle)(struct clk *);
+	void			(*deny_idle)(struct clk *);
+};
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
+	u32			val;
+	u8			div;
+	u16			flags;
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
+	struct clk		 *parent;
+	const struct clksel_rate *rates;
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
+	u8			flags;
+};
+
+/*
+ * struct clk.flags possibilities
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
+#define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
+#define CLOCK_IDLE_CONTROL	(1 << 1)
+#define CLOCK_NO_IDLE_PARENT	(1 << 2)
+#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
+#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
+#define CLOCK_CLKOUTX2		(1 << 5)
+
+/**
+ * struct clk - OMAP struct clk
+ * @node: list_head connecting this clock into the full clock list
+ * @ops: struct clkops * for this clock
+ * @name: the name of the clock in the hardware (used in hwmod data and debug)
+ * @parent: pointer to this clock's parent struct clk
+ * @children: list_head connecting to the child clks' @sibling list_heads
+ * @sibling: list_head connecting this clk to its parent clk's @children
+ * @rate: current clock rate
+ * @enable_reg: register to write to enable the clock (see @enable_bit)
+ * @recalc: fn ptr that returns the clock's current rate
+ * @set_rate: fn ptr that can change the clock's current rate
+ * @round_rate: fn ptr that can round the clock's current rate
+ * @init: fn ptr to do clock-specific initialization
+ * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
+ * @usecount: number of users that have requested this clock to be enabled
+ * @fixed_div: when > 0, this clock's rate is its parent's rate / @fixed_div
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
+ * XXX @usecount is poorly named.  It should be "enable_count" or
+ * something similar.  "users" in the description refers to kernel
+ * code (core code or drivers) that have called clk_enable() and not
+ * yet called clk_disable(); the usecount of parent clocks is also
+ * incremented by the clock code when clk_enable() is called on child
+ * clocks and decremented by the clock code when clk_disable() is
+ * called on child clocks.
+ *
+ * XXX @clkdm, @usecount, @children, @sibling should be marked for
+ * internal use only.
+ *
+ * @children and @sibling are used to optimize parent-to-child clock
+ * tree traversals.  (child-to-parent traversals use @parent.)
+ *
+ * XXX The notion of the clock's current rate probably needs to be
+ * separated from the clock's target rate.
+ */
+struct clk {
+	struct list_head	node;
+	const struct clkops	*ops;
+	const char		*name;
+	struct clk		*parent;
+	struct list_head	children;
+	struct list_head	sibling;	/* node for children */
+	unsigned long		rate;
+	void __iomem		*enable_reg;
+	unsigned long		(*recalc)(struct clk *);
+	int			(*set_rate)(struct clk *, unsigned long);
+	long			(*round_rate)(struct clk *, unsigned long);
+	void			(*init)(struct clk *);
+	u8			enable_bit;
+	s8			usecount;
+	u8			fixed_div;
+	u8			flags;
+	void __iomem		*clksel_reg;
+	u32			clksel_mask;
+	const struct clksel	*clksel;
+	struct dpll_data	*dpll_data;
+	const char		*clkdm_name;
+	struct clockdomain	*clkdm;
+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
+	struct dentry		*dent;	/* For visible tree hierarchy */
+#endif
+};
+
+struct clk_functions {
+	int		(*clk_enable)(struct clk *clk);
+	void		(*clk_disable)(struct clk *clk);
+	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
+	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
+	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
+	void		(*clk_allow_idle)(struct clk *clk);
+	void		(*clk_deny_idle)(struct clk *clk);
+	void		(*clk_disable_unused)(struct clk *clk);
+};
+
+extern int mpurate;
+
+extern int clk_init(struct clk_functions *custom_clocks);
+extern void clk_preinit(struct clk *clk);
+extern int clk_register(struct clk *clk);
+extern void clk_reparent(struct clk *child, struct clk *parent);
+extern void clk_unregister(struct clk *clk);
+extern void propagate_rate(struct clk *clk);
+extern void recalculate_root_clocks(void);
+extern unsigned long followparent_recalc(struct clk *clk);
+extern void clk_enable_init_clocks(void);
+unsigned long omap_fixed_divisor_recalc(struct clk *clk);
+extern struct clk *omap_clk_get_by_name(const char *name);
+extern int omap_clk_enable_autoidle_all(void);
+extern int omap_clk_disable_autoidle_all(void);
+
+extern const struct clkops clkops_null;
+
+extern struct clk dummy_ck;
 
-#include <plat/clock.h>
 
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
 #define CORE_CLK_SRC_32K		0x0
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index a8e3261..5857967 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index e92be1fc..35680b5 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -22,7 +22,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "soc.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 1fc96b9..1c03b2f 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "clock.h"
 #include "clock34xx.h"
diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/clock3517.c
index 2e97d08..16fb83d 100644
--- a/arch/arm/mach-omap2/clock3517.c
+++ b/arch/arm/mach-omap2/clock3517.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "clock.h"
 #include "clock3517.h"
diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/clock36xx.c
index 0c5e25e..22932ef 100644
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -22,7 +22,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "clock.h"
 #include "clock36xx.h"
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 83bb014..06939dc 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "soc.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index cbb87913..32dbcbc 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -27,7 +27,7 @@
 
 #include <linux/bitops.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include "clockdomain.h"
 
 /* clkdm_list contains all registered struct clockdomains */
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 629576b..79e4503 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -18,7 +18,7 @@
 #include <linux/spinlock.h>
 
 #include "powerdomain.h"
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 8e43c4d8..bc2ea50 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -18,7 +18,7 @@
 #include <linux/io.h>
 
 #include <plat/mux.h>
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 814e180..75d87da 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -28,7 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/clkdev.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "soc.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 09d0ccc..9b8a5eb 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -15,7 +15,7 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 
 #include "soc.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6af64bb..1dd97fc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -139,7 +139,7 @@
 #include <linux/slab.h>
 #include <linux/bootmem.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/omap_hwmod.h>
 #include <plat/prcm.h>
 
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 3e1345f..66cdda3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 8af6cd6..0308692 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -36,7 +36,7 @@
 #include <asm/mach-types.h>
 #include <asm/system_misc.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sram.h>
 #include <plat/dma.h>
 
diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 845c4fd..db96066 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -18,7 +18,7 @@
 #include <linux/io.h>
 
 #include "common.h"
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sdrc.h>
 
 #include "sdram-nokia.h"
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index e3d345f..70971e9 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -24,7 +24,7 @@
 #include <linux/io.h>
 
 #include "common.h"
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sram.h>
 
 #include <plat/sdrc.h>
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 73e55e4..e07f03b 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,7 +24,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
+#include "clock.h"
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 2e826f1..fd04e66 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -23,7 +23,6 @@
 #include <asm/sched_clock.h>
 
 #include <plat/common.h>
-#include <plat/clock.h>
 
 /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
 #define OMAP2_32KSYNCNT_REV_OFF		0x0
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
deleted file mode 100644
index e2e2d04..0000000
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ /dev/null
@@ -1,309 +0,0 @@
-/*
- * OMAP clock: data structure definitions, function prototypes, shared macros
- *
- * Copyright (C) 2004-2005, 2008-2010 Nokia Corporation
- * Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- * Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_OMAP_CLOCK_H
-#define __ARCH_ARM_OMAP_CLOCK_H
-
-#include <linux/list.h>
-
-struct module;
-struct clk;
-struct clockdomain;
-
-/* Temporary, needed during the common clock framework conversion */
-#define __clk_get_name(clk)	(clk->name)
-#define __clk_get_parent(clk)	(clk->parent)
-#define __clk_get_rate(clk)	(clk->rate)
-
-/**
- * struct clkops - some clock function pointers
- * @enable: fn ptr that enables the current clock in hardware
- * @disable: fn ptr that enables the current clock in hardware
- * @find_idlest: function returning the IDLEST register for the clock's IP blk
- * @find_companion: function returning the "companion" clk reg for the clock
- * @allow_idle: fn ptr that enables autoidle for the current clock in hardware
- * @deny_idle: fn ptr that disables autoidle for the current clock in hardware
- *
- * A "companion" clk is an accompanying clock to the one being queried
- * that must be enabled for the IP module connected to the clock to
- * become accessible by the hardware.  Neither @find_idlest nor
- * @find_companion should be needed; that information is IP
- * block-specific; the hwmod code has been created to handle this, but
- * until hwmod data is ready and drivers have been converted to use PM
- * runtime calls in place of clk_enable()/clk_disable(), @find_idlest and
- * @find_companion must, unfortunately, remain.
- */
-struct clkops {
-	int			(*enable)(struct clk *);
-	void			(*disable)(struct clk *);
-	void			(*find_idlest)(struct clk *, void __iomem **,
-					       u8 *, u8 *);
-	void			(*find_companion)(struct clk *, void __iomem **,
-						  u8 *);
-	void			(*allow_idle)(struct clk *);
-	void			(*deny_idle)(struct clk *);
-};
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
-/* struct clksel_rate.flags possibilities */
-#define RATE_IN_242X		(1 << 0)
-#define RATE_IN_243X		(1 << 1)
-#define RATE_IN_3430ES1		(1 << 2)	/* 3430ES1 rates only */
-#define RATE_IN_3430ES2PLUS	(1 << 3)	/* 3430 ES >= 2 rates only */
-#define RATE_IN_36XX		(1 << 4)
-#define RATE_IN_4430		(1 << 5)
-#define RATE_IN_TI816X		(1 << 6)
-#define RATE_IN_4460		(1 << 7)
-#define RATE_IN_AM33XX		(1 << 8)
-#define RATE_IN_TI814X		(1 << 9)
-
-#define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
-#define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
-#define RATE_IN_3XXX		(RATE_IN_34XX | RATE_IN_36XX)
-#define RATE_IN_44XX		(RATE_IN_4430 | RATE_IN_4460)
-
-/* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, and all 36xx/37xx */
-#define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | RATE_IN_36XX)
-
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
-/**
- * struct dpll_data - DPLL registers and integration data
- * @mult_div1_reg: register containing the DPLL M and N bitfields
- * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
- * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
- * @clk_bypass: struct clk pointer to the clock's bypass clock input
- * @clk_ref: struct clk pointer to the clock's reference clock input
- * @control_reg: register containing the DPLL mode bitfield
- * @enable_mask: mask of the DPLL mode bitfield in @control_reg
- * @last_rounded_rate: cache of the last rate result of omap2_dpll_round_rate()
- * @last_rounded_m: cache of the last M result of omap2_dpll_round_rate()
- * @max_multiplier: maximum valid non-bypass multiplier value (actual)
- * @last_rounded_n: cache of the last N result of omap2_dpll_round_rate()
- * @min_divider: minimum valid non-bypass divider value (actual)
- * @max_divider: maximum valid non-bypass divider value (actual)
- * @modes: possible values of @enable_mask
- * @autoidle_reg: register containing the DPLL autoidle mode bitfield
- * @idlest_reg: register containing the DPLL idle status bitfield
- * @autoidle_mask: mask of the DPLL autoidle mode bitfield in @autoidle_reg
- * @freqsel_mask: mask of the DPLL jitter correction bitfield in @control_reg
- * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
- * @auto_recal_bit: bitshift of the driftguard enable bit in @control_reg
- * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for recalibration IRQs
- * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for recalibration IRQs
- * @flags: DPLL type/features (see below)
- *
- * Possible values for @flags:
- * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
- *
- * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
- *
- * XXX Some DPLLs have multiple bypass inputs, so it's not technically
- * correct to only have one @clk_bypass pointer.
- *
- * XXX The runtime-variable fields (@last_rounded_rate, @last_rounded_m,
- * @last_rounded_n) should be separated from the runtime-fixed fields
- * and placed into a different structure, so that the runtime-fixed data
- * can be placed into read-only space.
- */
-struct dpll_data {
-	void __iomem		*mult_div1_reg;
-	u32			mult_mask;
-	u32			div1_mask;
-	struct clk		*clk_bypass;
-	struct clk		*clk_ref;
-	void __iomem		*control_reg;
-	u32			enable_mask;
-	unsigned long		last_rounded_rate;
-	u16			last_rounded_m;
-	u16			max_multiplier;
-	u8			last_rounded_n;
-	u8			min_divider;
-	u16			max_divider;
-	u8			modes;
-	void __iomem		*autoidle_reg;
-	void __iomem		*idlest_reg;
-	u32			autoidle_mask;
-	u32			freqsel_mask;
-	u32			idlest_mask;
-	u32			dco_mask;
-	u32			sddiv_mask;
-	u8			auto_recal_bit;
-	u8			recal_en_bit;
-	u8			recal_st_bit;
-	u8			flags;
-};
-
-#endif
-
-/*
- * struct clk.flags possibilities
- *
- * XXX document the rest of the clock flags here
- *
- * CLOCK_CLKOUTX2: (OMAP4 only) DPLL CLKOUT and CLKOUTX2 GATE_CTRL
- *     bits share the same register.  This flag allows the
- *     omap4_dpllmx*() code to determine which GATE_CTRL bit field
- *     should be used.  This is a temporary solution - a better approach
- *     would be to associate clock type-specific data with the clock,
- *     similar to the struct dpll_data approach.
- */
-#define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
-#define CLOCK_IDLE_CONTROL	(1 << 1)
-#define CLOCK_NO_IDLE_PARENT	(1 << 2)
-#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
-#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
-#define CLOCK_CLKOUTX2		(1 << 5)
-
-/**
- * struct clk - OMAP struct clk
- * @node: list_head connecting this clock into the full clock list
- * @ops: struct clkops * for this clock
- * @name: the name of the clock in the hardware (used in hwmod data and debug)
- * @parent: pointer to this clock's parent struct clk
- * @children: list_head connecting to the child clks' @sibling list_heads
- * @sibling: list_head connecting this clk to its parent clk's @children
- * @rate: current clock rate
- * @enable_reg: register to write to enable the clock (see @enable_bit)
- * @recalc: fn ptr that returns the clock's current rate
- * @set_rate: fn ptr that can change the clock's current rate
- * @round_rate: fn ptr that can round the clock's current rate
- * @init: fn ptr to do clock-specific initialization
- * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
- * @usecount: number of users that have requested this clock to be enabled
- * @fixed_div: when > 0, this clock's rate is its parent's rate / @fixed_div
- * @flags: see "struct clk.flags possibilities" above
- * @clksel_reg: for clksel clks, register va containing src/divisor select
- * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
- * @clksel: for clksel clks, pointer to struct clksel for this clock
- * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
- * @clkdm_name: clockdomain name that this clock is contained in
- * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
- * @rate_offset: bitshift for rate selection bitfield (OMAP1 only)
- * @src_offset: bitshift for source selection bitfield (OMAP1 only)
- *
- * XXX @rate_offset, @src_offset should probably be removed and OMAP1
- * clock code converted to use clksel.
- *
- * XXX @usecount is poorly named.  It should be "enable_count" or
- * something similar.  "users" in the description refers to kernel
- * code (core code or drivers) that have called clk_enable() and not
- * yet called clk_disable(); the usecount of parent clocks is also
- * incremented by the clock code when clk_enable() is called on child
- * clocks and decremented by the clock code when clk_disable() is
- * called on child clocks.
- *
- * XXX @clkdm, @usecount, @children, @sibling should be marked for
- * internal use only.
- *
- * @children and @sibling are used to optimize parent-to-child clock
- * tree traversals.  (child-to-parent traversals use @parent.)
- *
- * XXX The notion of the clock's current rate probably needs to be
- * separated from the clock's target rate.
- */
-struct clk {
-	struct list_head	node;
-	const struct clkops	*ops;
-	const char		*name;
-	struct clk		*parent;
-	struct list_head	children;
-	struct list_head	sibling;	/* node for children */
-	unsigned long		rate;
-	void __iomem		*enable_reg;
-	unsigned long		(*recalc)(struct clk *);
-	int			(*set_rate)(struct clk *, unsigned long);
-	long			(*round_rate)(struct clk *, unsigned long);
-	void			(*init)(struct clk *);
-	u8			enable_bit;
-	s8			usecount;
-	u8			fixed_div;
-	u8			flags;
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	void __iomem		*clksel_reg;
-	u32			clksel_mask;
-	const struct clksel	*clksel;
-	struct dpll_data	*dpll_data;
-	const char		*clkdm_name;
-	struct clockdomain	*clkdm;
-#else
-	u8			rate_offset;
-	u8			src_offset;
-#endif
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
-	struct dentry		*dent;	/* For visible tree hierarchy */
-#endif
-};
-
-struct clk_functions {
-	int		(*clk_enable)(struct clk *clk);
-	void		(*clk_disable)(struct clk *clk);
-	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
-	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
-	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
-	void		(*clk_allow_idle)(struct clk *clk);
-	void		(*clk_deny_idle)(struct clk *clk);
-	void		(*clk_disable_unused)(struct clk *clk);
-};
-
-extern int mpurate;
-
-extern int clk_init(struct clk_functions *custom_clocks);
-extern void clk_preinit(struct clk *clk);
-extern int clk_register(struct clk *clk);
-extern void clk_reparent(struct clk *child, struct clk *parent);
-extern void clk_unregister(struct clk *clk);
-extern void propagate_rate(struct clk *clk);
-extern void recalculate_root_clocks(void);
-extern unsigned long followparent_recalc(struct clk *clk);
-extern void clk_enable_init_clocks(void);
-unsigned long omap_fixed_divisor_recalc(struct clk *clk);
-extern struct clk *omap_clk_get_by_name(const char *name);
-extern int omap_clk_enable_autoidle_all(void);
-extern int omap_clk_disable_autoidle_all(void);
-
-extern const struct clkops clkops_null;
-
-extern struct clk dummy_ck;
-
-#endif
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 5b69742..bae5663 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -91,7 +91,6 @@
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
-#include <plat/clock.h>
 
 /* These parameters are passed to _omap_device_{de,}activate() */
 #define USE_WAKEUP_LAT			0


