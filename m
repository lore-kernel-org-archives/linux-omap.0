From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 01/10] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add recursive usecount tracking
Date: Tue, 25 Sep 2012 12:32:36 +0300
Message-ID: <1348565565-14744-2-git-send-email-t-kristo@ti.com>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33037 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab2IYJdA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 05:33:00 -0400
In-Reply-To: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This patch fixes the usecount tracking for omap3+, previously the
usecount numbers were rather bogus and were not really useful for
any purpose. Now usecount numbers track the number of really active
clients on each domain. This patch also adds support for usecount
tracking on powerdomain level and autoidle flag for clocks that
are hardware controlled and should be skipped in usecount
calculations.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clkt_iclk.c         |   21 ++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.c       |   15 ++++++++++++-
 arch/arm/mach-omap2/dpll3xxx.c          |   19 ++++++++++++++++
 arch/arm/mach-omap2/powerdomain.c       |   35 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h       |    4 +++
 arch/arm/plat-omap/clock.c              |    6 +++++
 arch/arm/plat-omap/include/plat/clock.h |    2 +
 7 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 3d43fba..1afc599 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -21,6 +21,7 @@
 #include "clock2xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
+#include "clockdomain.h"
 
 /* Private functions */
 
@@ -34,6 +35,16 @@ void omap2_clkt_iclk_allow_idle(struct clk *clk)
 	v = __raw_readl((__force void __iomem *)r);
 	v |= (1 << clk->enable_bit);
 	__raw_writel(v, (__force void __iomem *)r);
+
+	/* Remove this clock from parent clockdomain usecounts */
+	if (clk->usecount && clk->clkdm)
+		clkdm_clk_disable(clk->clkdm, clk);
+
+	/*
+	 * Mark as autoidle, so we continue to ignore this clock in
+	 * parent clkdm usecount calculations
+	 */
+	clk->autoidle = true;
 }
 
 /* XXX */
@@ -46,6 +57,16 @@ void omap2_clkt_iclk_deny_idle(struct clk *clk)
 	v = __raw_readl((__force void __iomem *)r);
 	v &= ~(1 << clk->enable_bit);
 	__raw_writel(v, (__force void __iomem *)r);
+
+	/*
+	 * Disable autoidle flag so further clkdm usecounts take this
+	 * clock into account
+	 */
+	clk->autoidle = false;
+
+	/* Add clock back to parent clockdomain usecount */
+	if (clk->usecount && clk->clkdm)
+		clkdm_clk_enable(clk->clkdm, clk);
 }
 
 /* Public data */
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8664f5a..8c8518c 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -910,6 +910,7 @@ bool clkdm_in_hwsup(struct clockdomain *clkdm)
 static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 {
 	unsigned long flags;
+	int usecount;
 
 	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_enable)
 		return -EINVAL;
@@ -919,11 +920,14 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	 * should be called for every clock instance or hwmod that is
 	 * enabled, so the clkdm can be force woken up.
 	 */
-	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
+	usecount = atomic_inc_return(&clkdm->usecount);
+	if (usecount > 1 && autodeps)
 		return 0;
 
 	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_enable(clkdm);
+	if (usecount == 1)
+		pwrdm_clkdm_enable(clkdm->pwrdm.ptr);
 	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 
@@ -949,6 +953,7 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 
 	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_disable(clkdm);
+	pwrdm_clkdm_disable(clkdm->pwrdm.ptr);
 	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 
@@ -981,6 +986,10 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	if (!clk)
 		return -EINVAL;
 
+	/* If autoidle clock, do not update clkdm usecounts */
+	if (clk->autoidle)
+		return 0;
+
 	return _clkdm_clk_hwmod_enable(clkdm);
 }
 
@@ -1007,6 +1016,10 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	if (!clk)
 		return -EINVAL;
 
+	/* If autoidle clock, do not update clkdm usecounts */
+	if (clk->autoidle)
+		return 0;
+
 	return _clkdm_clk_hwmod_disable(clkdm);
 }
 
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index b9c8d2f..da660d2 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -34,6 +34,7 @@
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
+#include "clockdomain.h"
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
 #define DPLL_AUTOIDLE_DISABLE			0x0
@@ -571,6 +572,15 @@ void omap3_dpll_allow_idle(struct clk *clk)
 	v |= DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
 	__raw_writel(v, dd->autoidle_reg);
 
+	/* Remove this clock from parent clockdomain usecounts */
+	if (clk->usecount && clk->clkdm)
+		clkdm_clk_disable(clk->clkdm, clk);
+
+	/*
+	 * Mark as autoidle, so we continue to ignore this clock in
+	 * parent clkdm usecount calculations
+	 */
+	clk->autoidle = true;
 }
 
 /**
@@ -600,6 +610,15 @@ void omap3_dpll_deny_idle(struct clk *clk)
 	v |= DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
 	__raw_writel(v, dd->autoidle_reg);
 
+	/*
+	 * Disable autoidle flag so further clkdm usecounts take this
+	 * clock into account
+	 */
+	clk->autoidle = false;
+
+	/* Add clock back to parent clockdomain usecount */
+	if (clk->usecount && clk->clkdm)
+		clkdm_clk_enable(clk->clkdm, clk);
 }
 
 /* Clock control for DPLL outputs */
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index d6daa81..ba49029 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1466,6 +1466,41 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
 	return ret;
 }
 
+/**
+ * pwrdm_clkdm_enable - increment powerdomain usecount
+ * @pwrdm: struct powerdomain *
+ *
+ * Increases the usecount for a powerdomain. Called from clockdomain
+ * code once a clockdomain becomes active.
+ */
+void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return;
+
+	atomic_inc(&pwrdm->usecount);
+}
+
+/**
+ * pwrdm_clkdm_disable - decrease powerdomain usecount
+ * @pwrdm: struct powerdomain *
+ *
+ * Decreases the usecount for a powerdomain. Called from clockdomain
+ * code once a clockdomain usecount reaches zero, i.e. it is ready to
+ * idle.
+ */
+void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
+{
+	int val;
+
+	if (!pwrdm)
+		return;
+
+	val = atomic_dec_return(&pwrdm->usecount);
+
+	WARN_ON(val < 0);
+}
+
 int pwrdm_pre_transition(struct powerdomain *pwrdm)
 {
 	if (pwrdm)
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index dcd2315..1bad255 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -92,6 +92,9 @@ int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_pre_transition(struct powerdomain *pwrdm);
 int pwrdm_post_transition(struct powerdomain *pwrdm);
 
+void pwrdm_clkdm_enable(struct powerdomain *pwrdm);
+void pwrdm_clkdm_disable(struct powerdomain *pwrdm);
+
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
@@ -209,6 +212,7 @@ struct powerdomain {
 	unsigned state_counter[PWRDM_MAX_FUNC_PWRSTS];
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
+	atomic_t usecount;
 
 	const u8 pwrstctrl_offs;
 	const u8 pwrstst_offs;
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 706b7e2..d657d39 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -282,6 +282,12 @@ int clk_register(struct clk *clk)
 		list_add(&clk->sibling, &root_clks);
 
 	list_add(&clk->node, &clocks);
+	/*
+	 * If clock has no ops, it is handled by hardware and thus will
+	 * idle automatically
+	 */
+	if (clk->ops == &clkops_null)
+		clk->autoidle = true;
 	if (clk->init)
 		clk->init(clk);
 	mutex_unlock(&clocks_mutex);
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 656b986..3b5acea 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -206,6 +206,7 @@ struct dpll_data {
  * @init: fn ptr to do clock-specific initialization
  * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
  * @usecount: number of users that have requested this clock to be enabled
+ * @autoidle: indicates hardware controlled clock (not used in domain usecounts)
  * @fixed_div: when > 0, this clock's rate is its parent's rate / @fixed_div
  * @flags: see "struct clk.flags possibilities" above
  * @clksel_reg: for clksel clks, register va containing src/divisor select
@@ -252,6 +253,7 @@ struct clk {
 	void			(*init)(struct clk *);
 	u8			enable_bit;
 	s8			usecount;
+	bool			autoidle;
 	u8			fixed_div;
 	u8			flags;
 #ifdef CONFIG_ARCH_OMAP2PLUS
-- 
1.7.4.1

