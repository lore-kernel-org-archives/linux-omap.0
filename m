From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 11/15] omap3+: voltage/pwrdm/clkdm/clock add recursive usecount tracking
Date: Fri, 25 Nov 2011 17:49:44 +0200
Message-ID: <1322236188-19456-12-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47901 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab1KYPuP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 10:50:15 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFoFG0006359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:15 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFoFRF020560
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:15 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFoF5V017956
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:15 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

This patch fixes the usecount tracking for omap3+, previously the
usecount numbers were rather bogus and were not really useful for
any purpose. Now usecount numbers track the number of really active
clients on each domain. This patch also adds support for usecount
tracking on powerdomain and voltagedomain levels.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_iclk.c         |   11 +++++++++
 arch/arm/mach-omap2/clockdomain.c       |   38 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clockdomain.h       |    3 ++
 arch/arm/mach-omap2/powerdomain.c       |   12 +++++++++
 arch/arm/mach-omap2/powerdomain.h       |    5 ++++
 arch/arm/mach-omap2/voltage.c           |   30 ++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h           |    7 +++++
 arch/arm/plat-omap/clock.c              |    2 +
 arch/arm/plat-omap/include/plat/clock.h |    1 +
 9 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 3d43fba..8e61776 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -21,6 +21,7 @@
 #include "clock2xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
+#include "clockdomain.h"
 
 /* Private functions */
 
@@ -34,6 +35,11 @@ void omap2_clkt_iclk_allow_idle(struct clk *clk)
 	v = __raw_readl((__force void __iomem *)r);
 	v |= (1 << clk->enable_bit);
 	__raw_writel(v, (__force void __iomem *)r);
+
+	if (clk->usecount && clk->clkdm)
+		clkdm_usecount_dec(clk->clkdm);
+
+	clk->autoidle = 1;
 }
 
 /* XXX */
@@ -46,6 +52,11 @@ void omap2_clkt_iclk_deny_idle(struct clk *clk)
 	v = __raw_readl((__force void __iomem *)r);
 	v &= ~(1 << clk->enable_bit);
 	__raw_writel(v, (__force void __iomem *)r);
+
+	if (clk->usecount && clk->clkdm)
+		clkdm_usecount_inc(clk->clkdm);
+
+	clk->autoidle = 0;
 }
 
 /* Public data */
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8480ee4..a14baaf 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -906,6 +906,28 @@ bool clkdm_in_hwsup(struct clockdomain *clkdm)
 
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
@@ -918,7 +940,10 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	 * should be called for every clock instance or hwmod that is
 	 * enabled, so the clkdm can be force woken up.
 	 */
-	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
+	if ((clkdm_usecount_inc(clkdm) > 1) && autodeps)
+		return 0;
+
+	if (clkdm->flags & CLKDM_NO_MANUAL_TRANSITIONS)
 		return 0;
 
 	spin_lock_irqsave(&clkdm->lock, flags);
@@ -944,7 +969,10 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 		return -ERANGE;
 	}
 
-	if (atomic_dec_return(&clkdm->usecount) > 0)
+	if (clkdm_usecount_dec(clkdm) > 0)
+		return 0;
+
+	if (clkdm->flags & CLKDM_NO_MANUAL_TRANSITIONS)
 		return 0;
 
 	spin_lock_irqsave(&clkdm->lock, flags);
@@ -981,6 +1009,9 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	if (!clk)
 		return -EINVAL;
 
+	if (clk->autoidle)
+		return 0;
+
 	return _clkdm_clk_hwmod_enable(clkdm);
 }
 
@@ -1007,6 +1038,9 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	if (!clk)
 		return -EINVAL;
 
+	if (clk->autoidle)
+		return 0;
+
 	return _clkdm_clk_hwmod_disable(clkdm);
 }
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index f7b5860..38321cd 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -37,6 +37,7 @@
 #define CLKDM_CAN_ENABLE_AUTO			(1 << 2)
 #define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
 #define CLKDM_NO_AUTODEPS			(1 << 4)
+#define CLKDM_NO_MANUAL_TRANSITIONS		(1 << 5)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
@@ -191,6 +192,8 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
+int clkdm_usecount_inc(struct clockdomain *clkdm);
+int clkdm_usecount_dec(struct clockdomain *clkdm);
 
 extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 5164d58..010d274 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -985,6 +985,18 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
 	return -EINVAL;
 }
 
+void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
+{
+	if (atomic_inc_return(&pwrdm->usecount) == 1)
+		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
+}
+
+void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
+{
+	if (!atomic_dec_return(&pwrdm->usecount))
+		voltdm_pwrdm_disable(pwrdm->voltdm.ptr);
+}
+
 int pwrdm_pre_transition(void)
 {
 	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 42e6dd8..8623e87 100644
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
 u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 64070ac..2232e7a 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -37,6 +37,7 @@
 
 #include "voltage.h"
 #include "powerdomain.h"
+#include "smartreflex.h"
 
 #include "vc.h"
 #include "vp.h"
@@ -323,6 +324,35 @@ int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm)
 	return 0;
 }
 
+void voltdm_pwrdm_enable(struct voltagedomain *voltdm)
+{
+	if (atomic_inc_return(&voltdm->usecount) == 1) {
+		if (voltdm->wakeup)
+			voltdm->wakeup(voltdm);
+		omap_sr_enable(voltdm);
+	}
+}
+
+void voltdm_pwrdm_disable(struct voltagedomain *voltdm)
+{
+	int target_state = -EINVAL;
+	int state;
+	struct powerdomain *pwrdm;
+
+	if (!atomic_dec_return(&voltdm->usecount)) {
+		omap_sr_disable(voltdm);
+		/* Determine target state for voltdm */
+		list_for_each_entry(pwrdm, &voltdm->pwrdm_list, voltdm_node) {
+			state = pwrdm_read_next_pwrst(pwrdm);
+			if (state > target_state)
+				target_state = state;
+		}
+		voltdm->target_state = target_state;
+		if (voltdm->sleep)
+			voltdm->sleep(voltdm);
+	}
+}
+
 /**
  * voltdm_for_each_pwrdm - call function for each pwrdm in a voltdm
  * @voltdm: struct voltagedomain * to iterate over
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 01d41d9..1a07b76 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -75,6 +75,9 @@ struct voltagedomain {
 	struct omap_vp_param *vp_param;
 	struct omap_vc_param *vc_param;
 
+	atomic_t usecount;
+	int target_state;
+
 	/* VC/VP register access functions: SoC specific */
 	u32 (*read) (u8 offset);
 	void (*write) (u32 val, u8 offset);
@@ -85,6 +88,8 @@ struct voltagedomain {
 		u32 rate;
 	} sys_clk;
 
+	void (*sleep) (struct voltagedomain *voltdm);
+	void (*wakeup) (struct voltagedomain *voltdm);
 	int (*scale) (struct voltagedomain *voltdm,
 		      unsigned long target_volt);
 
@@ -193,6 +198,8 @@ extern void omap44xx_voltagedomains_init(void);
 struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
 int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
+void voltdm_pwrdm_enable(struct voltagedomain *voltdm);
+void voltdm_pwrdm_disable(struct voltagedomain *voltdm);
 int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
 		    void *user);
 int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 3ba4d11..7267818 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -282,6 +282,8 @@ int clk_register(struct clk *clk)
 		list_add(&clk->sibling, &root_clks);
 
 	list_add(&clk->node, &clocks);
+	if (clk->ops == &clkops_null)
+		clk->autoidle = 1;
 	if (clk->init)
 		clk->init(clk);
 	mutex_unlock(&clocks_mutex);
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index df4b968..f18dd5f 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -254,6 +254,7 @@ struct clk {
 	void			(*init)(struct clk *);
 	u8			enable_bit;
 	s8			usecount;
+	u8			autoidle;
 	u8			fixed_div;
 	u8			flags;
 #ifdef CONFIG_ARCH_OMAP2PLUS
-- 
1.7.4.1

