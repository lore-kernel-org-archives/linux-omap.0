From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 09/09] OMAP clock: add pre/post/abort clk rate change
 notifiers
Date: Fri, 20 Mar 2009 18:56:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41111 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbZCTN0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:26:52 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDQhJq021609
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:26:50 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDQhlu003140
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:56:43 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Call clock notifier blocks before and after rate and parent changes.
If the rate change fails for any reason after the notifier is called with
a pre-rate-change message, call the notifier again with an abort message.

Pre-rate-change notifiers are passed the current clock rate and the
desired clock rate.  For this to work with parent changes, additional
architecture-specific support was needed to predict the clock rate
after the parent change, so a "clk_round_rate_parent" function pointer
was added to struct clk_functions for this purpose, and this was
defined for the OMAP2/3 architecture.

(To minimize performance and code impact, post-rate-change notifiers,
however, are passed only the desired clock rate, i.e., the clock rate
after the rate change.)

The notifiers are called even if the clock rate does not change.  This
is because reprogramming a clock's parent or rate may briefly disrupt
the clock.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c             |   20 +++++++
 arch/arm/mach-omap2/clock.h             |    1 +
 arch/arm/mach-omap2/clock24xx.c         |    1 +
 arch/arm/mach-omap2/clock34xx.c         |    1 +
 arch/arm/plat-omap/clock.c              |   89 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/clock.h |    2 +
 6 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 612db25..7f8cd82 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -826,6 +826,26 @@ static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
 	return clkr->div;
 }
 
+long omap2_clk_round_rate_parent(struct clk *clk, struct clk *new_parent)
+{
+	u32 field_val, parent_div;
+	long rate;
+
+	if (!clk->clksel || !new_parent)
+		return -EINVAL;
+
+	parent_div = _omap2_clksel_get_src_field(new_parent, clk, &field_val);
+	if (!parent_div)
+		return -EINVAL;
+
+	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
+	rate = new_parent->rate;
+	if (parent_div > 0)
+		rate /= parent_div;
+
+	return rate;
+}
+
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	u32 field_val, v, parent_div;
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index f4d489f..9813eca 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -41,6 +41,7 @@ int omap2_clk_register(struct clk *clk);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
+long omap2_clk_round_rate_parent(struct clk *clk, struct clk *parent);
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
 int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance);
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 53864c0..3f75524 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -448,6 +448,7 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_round_rate_parent	= omap2_clk_round_rate_parent,
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_get_parent		= omap2_clk_get_parent,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 596230a..6d4d4fe 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -725,6 +725,7 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_round_rate_parent	= omap2_clk_round_rate_parent,
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_get_parent		= omap2_clk_get_parent,
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index d76964a..05ceb9c 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -173,6 +173,61 @@ void omap_clk_del_child(struct clk *clk, struct clk *clk2)
 	}
 }
 
+/**
+ * omap_clk_notify - call clk notifier chain
+ * @clk: struct clk * that is changing rate
+ * @msg: clk notifier type (i.e., CLK_POST_RATE_CHANGE; see mach/clock.h)
+ * @old_rate: old rate
+ * @new_rate: new rate
+ *
+ * Triggers a notifier call chain on the post-clk-rate-change notifier
+ * for clock 'clk'.  Passes a pointer to the struct clk and the
+ * previous and current rates to the notifier callback.  Intended to be
+ * called by internal clock code only.  No return value.
+ */
+static void omap_clk_notify(struct clk *clk, unsigned long msg,
+			    unsigned long old_rate, unsigned long new_rate)
+{
+	struct clk_notifier *cn;
+	struct clk_notifier_data cnd;
+
+	cnd.clk = clk;
+	cnd.old_rate = old_rate;
+	cnd.new_rate = new_rate;
+
+	list_for_each_entry(cn, &clk_notifier_list, node) {
+		if (cn->clk == clk) {
+			blocking_notifier_call_chain(&cn->notifier_head, msg,
+						     &cnd);
+			break;
+		}
+	}
+}
+
+/**
+ * omap_clk_notify_downstream - trigger clock change notifications
+ * @clk: struct clk * to start the notifications with
+ * @msg: notifier msg - see "Clk notifier callback types"
+ * @param2: (not used - any u8 will do)
+ *
+ * Call clock change notifiers on clocks starting with @clk and including
+ * all of @clk's downstream children clocks.  Returns NOTIFY_DONE.
+ */
+static int omap_clk_notify_downstream(struct clk *clk, unsigned long msg,
+				      u8 param2)
+{
+	if (!clk->notifier_count)
+		return NOTIFY_DONE;
+
+	omap_clk_notify(clk, msg, clk->rate, clk->temp_rate);
+
+	if (!omap_clk_has_children(clk))
+		return NOTIFY_DONE;
+
+	return omap_clk_for_each_child(clk, msg, 0, omap_clk_notify_downstream);
+}
+
+
 /*-------------------------------------------------------------------------
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
@@ -309,10 +364,20 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned long flags;
 	int ret = -EINVAL;
+	int msg;
 
 	if (clk == NULL || IS_ERR(clk))
 		return ret;
 
+	mutex_lock(&clocks_mutex);
+
+	if (clk->notifier_count) {
+		clk->temp_rate = rate;
+		propagate_rate(clk, TEMP_RATE);
+
+		omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE, 0);
+	}
+
 	spin_lock_irqsave(&clockfw_lock, flags);
 
 	if (arch_clock->clk_set_rate) {
@@ -324,6 +389,12 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
+	msg = (ret) ? CLK_ABORT_RATE_CHANGE : CLK_POST_RATE_CHANGE;
+
+	omap_clk_notify_downstream(clk, msg, 0);
+
+	mutex_unlock(&clocks_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL(clk_set_rate);
@@ -333,10 +404,20 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	unsigned long flags;
 	struct clk *prev_parent;
 	int ret = -EINVAL;
+	int msg;
 
 	if (clk == NULL || IS_ERR(clk) || parent == NULL || IS_ERR(parent))
 		return ret;
 
+	mutex_lock(&clocks_mutex);
+
+	if (clk->notifier_count && arch_clock->clk_round_rate_parent) {
+		clk->temp_rate = arch_clock->clk_round_rate_parent(clk, parent);
+		propagate_rate(clk, TEMP_RATE);
+
+		omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE, 0);
+	}
+
 	spin_lock_irqsave(&clockfw_lock, flags);
 
 	if (arch_clock->clk_set_parent) {
@@ -352,6 +433,12 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
+	msg = (ret) ? CLK_ABORT_RATE_CHANGE : CLK_POST_RATE_CHANGE;
+
+	omap_clk_notify_downstream(clk, msg, 0);
+
+	mutex_unlock(&clocks_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL(clk_set_parent);
@@ -538,6 +625,8 @@ void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 EXPORT_SYMBOL(clk_init_cpufreq_table);
 #endif
 
+/* Clk notifier implementations */
+
 /**
  * clk_notifier_register - add a clock parameter change notifier
  * @clk: struct clk * to watch
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 41faba8..9c75f97 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -158,6 +158,8 @@ struct clk_functions {
 	int		(*clk_enable)(struct clk *clk);
 	void		(*clk_disable)(struct clk *clk);
 	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
+	long		(*clk_round_rate_parent)(struct clk *clk,
+						 struct clk *parent);
 	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
 	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
 	struct clk *	(*clk_get_parent)(struct clk *clk);
-- 
1.5.4.3
