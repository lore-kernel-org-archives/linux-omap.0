From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 2/8] arm: omap3+: voltage/pwrdm/clkdm/clock add recursive usecount tracking
Date: Wed, 15 Feb 2012 17:37:48 +0200
Message-ID: <1329320274-481-3-git-send-email-t-kristo@ti.com>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58785 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab2BOPi0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:26 -0500
In-Reply-To: <1329320274-481-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
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
 arch/arm/mach-omap2/clkt_iclk.c         |   21 +++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.c       |   34 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clockdomain.h       |    2 +
 arch/arm/mach-omap2/powerdomain.c       |   16 ++++++++++++++
 arch/arm/mach-omap2/powerdomain.h       |    5 ++++
 arch/arm/plat-omap/clock.c              |    6 +++++
 arch/arm/plat-omap/include/plat/clock.h |    2 +
 7 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 3d43fba..f8c2e77 100644
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
+		clkdm_usecount_dec(clk->clkdm);
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
+	/* Add clock back to parent clockdomain usecount */
+	if (clk->usecount && clk->clkdm)
+		clkdm_usecount_inc(clk->clkdm);
+
+	/*
+	 * Disable autoidle flag so further clkdm usecounts take this
+	 * clock into account
+	 */
+	clk->autoidle = false;
 }
 
 /* Public data */
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ad07689..c0b6187 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -907,6 +907,28 @@ bool clkdm_in_hwsup(struct clockdomain *clkdm)
 
 /* Clockdomain-to-clock/hwmod framework interface code */
 
+int clkdm_usecount_inc(struct clockdomain *clkdm)
+{
+	int usecount;
+
+	usecount = atomic_inc_return(&clkdm->usecount);
+
+	if (usecount == 1)
+		pwrdm_clkdm_enable(clkdm->pwrdm.ptr);
+	return usecount;
+}
+
+int clkdm_usecount_dec(struct clockdomain *clkdm)
+{
+	int usecount;
+
+	usecount = atomic_dec_return(&clkdm->usecount);
+
+	if (usecount == 0)
+		pwrdm_clkdm_disable(clkdm->pwrdm.ptr);
+	return usecount;
+}
+
 static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 {
 	unsigned long flags;
@@ -919,7 +941,7 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	 * should be called for every clock instance or hwmod that is
 	 * enabled, so the clkdm can be force woken up.
 	 */
-	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
+	if ((clkdm_usecount_inc(clkdm) > 1) && autodeps)
 		return 0;
 
 	spin_lock_irqsave(&clkdm->lock, flags);
@@ -945,7 +967,7 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 		return -ERANGE;
 	}
 
-	if (atomic_dec_return(&clkdm->usecount) > 0)
+	if (clkdm_usecount_dec(clkdm) > 0)
 		return 0;
 
 	spin_lock_irqsave(&clkdm->lock, flags);
@@ -982,6 +1004,10 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	if (!clk)
 		return -EINVAL;
 
+	/* If autoidle clock, do not update clkdm usecounts */
+	if (clk->autoidle)
+		return 0;
+
 	return _clkdm_clk_hwmod_enable(clkdm);
 }
 
@@ -1008,6 +1034,10 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	if (!clk)
 		return -EINVAL;
 
+	/* If autoidle clock, do not update clkdm usecounts */
+	if (clk->autoidle)
+		return 0;
+
 	return _clkdm_clk_hwmod_disable(clkdm);
 }
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index f7b5860..373399a 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -191,6 +191,8 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
+int clkdm_usecount_inc(struct clockdomain *clkdm);
+int clkdm_usecount_dec(struct clockdomain *clkdm);
 
 extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 8a18d1b..3b70f69 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -985,6 +985,22 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
 	return -EINVAL;
 }
 
+void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return;
+
+	atomic_inc(&pwrdm->usecount);
+}
+
+void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return;
+
+	atomic_dec(&pwrdm->usecount);
+}
+
 int pwrdm_pre_transition(void)
 {
 	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..32f44c8 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -120,6 +120,7 @@ struct powerdomain {
 	unsigned state_counter[PWRDM_MAX_PWRSTS];
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
+	atomic_t usecount;
 
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
@@ -216,6 +217,10 @@ int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
+
+void pwrdm_clkdm_enable(struct powerdomain *pwrdm);
+void pwrdm_clkdm_disable(struct powerdomain *pwrdm);
+
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index e17ee5e2..1f80df8 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -283,6 +283,12 @@ int clk_register(struct clk *clk)
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
index c84f2a4..14b44c0 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -208,6 +208,7 @@ struct dpll_data {
  * @init: fn ptr to do clock-specific initialization
  * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
  * @usecount: number of users that have requested this clock to be enabled
+ * @autoidle: indicates hardware controlled clock (not used in domain usecounts)
  * @fixed_div: when > 0, this clock's rate is its parent's rate / @fixed_div
  * @flags: see "struct clk.flags possibilities" above
  * @clksel_reg: for clksel clks, register va containing src/divisor select
@@ -254,6 +255,7 @@ struct clk {
 	void			(*init)(struct clk *);
 	u8			enable_bit;
 	s8			usecount;
+	bool			autoidle;
 	u8			fixed_div;
 	u8			flags;
 #ifdef CONFIG_ARCH_OMAP2PLUS
-- 
1.7.4.1

