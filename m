From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 06/09] OMAP3 clock: Revert "OMAP clock: add notifier
 infrastructure"
Date: Fri, 20 Mar 2009 18:56:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF23@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39633 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921AbZCTN03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:26:29 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDQKqT011218
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:26:27 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDQKSF003049
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:56:20 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This reverts commit 2634ca5d347d8ade65442d68cc8254aef1c5efa5.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/clock.c              |   81 -------------------------------
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 2 files changed, 0 insertions(+), 82 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index e0940a1..c07e6be 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -173,64 +173,6 @@ void omap_clk_del_child(struct clk *clk, struct clk *clk2)
 	}
 }
 
-/**
- * omap_clk_notify - call clk notifier chain
- * @clk: struct clk * that is changing rate
- * @msg: clk notifier type (i.e., CLK_POST_RATE_CHANGE; see mach/clock.h)
- * @old_rate: old rate
- * @new_rate: new rate
- *
- * Triggers a notifier call chain on the post-clk-rate-change notifier
- * for clock 'clk'.  Passes a pointer to the struct clk and the
- * previous and current rates to the notifier callback.  Intended to be
- * called by internal clock code only.  No return value.
- */
-static int omap_clk_notify(struct clk *clk, unsigned long msg,
-			   unsigned long old_rate, unsigned long new_rate)
-{
-	struct clk_notifier *cn;
-	struct clk_notifier_data cnd;
-	int ret = NOTIFY_DONE;
-
-	cnd.clk = clk;
-	cnd.old_rate = old_rate;
-	cnd.new_rate = new_rate;
-
-	list_for_each_entry(cn, &clk_notifier_list, node) {
-		if (cn->clk == clk) {
-			ret = atomic_notifier_call_chain(&cn->notifier_head,
-							 msg, &cnd);
-			break;
-		}
-	}
-
-	return ret;
-}
-
-/**
- * _do_clk_notifier - callback function for clock change notification
- * @clk: struct clk * to start the notifications with
- * @msg: notifier msg - see "Clk notifier callback types"
- * @param2: unused
- *
- * Notify callbacks associated with @clk that a clock change will or has
- * occurred.  If @msg is CLK_PREPARE_RATE_CHANGE, then actually pay attention
- * to the notifier return value.
- */
-static int _do_clk_notifier(struct clk *clk, unsigned long msg, u8 param2)
-{
-	int ret;
-
-	ret = omap_clk_notify(clk, msg, clk->rate, clk->temp_rate);
-	if (ret && msg == CLK_PREPARE_RATE_CHANGE)
-		return ret;
-
-	if (omap_clk_has_children(clk))
-		return omap_clk_notify_downstream(clk, msg);
-	else
-		return 0;
-}
-
 /*-------------------------------------------------------------------------
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
@@ -498,27 +440,6 @@ void recalculate_root_clocks(void)
 			_do_propagate_rate(clkp, 0, CURRENT_RATE);
 }
 
-/**
- * omap_clk_notify_downstream - trigger clock change notifications
- * @clk: struct clk * to start the notifications with
- * @msg: notifier msg - see "Clk notifier callback types"
- *
- * Call clock change notifiers on clocks starting with @clk and including
- * all of @clk's downstream children clocks.  Returns NOTIFY_DONE if
- * the notifiers ran successfully, or when msg is CLK_PREPARE_RATE_CHANGE,
- * NOTIFY_BAD if one of the notifiers denied the change.
- */
-int omap_clk_notify_downstream(struct clk *clk, unsigned long msg)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
-
-	if (!clk->notifier_count)
-		return 0;
-
-	return omap_clk_for_each_child(clk, msg, 0, _do_clk_notifier);
-}
-
 int clk_register(struct clk *clk)
 {
 	int ret;
@@ -617,8 +538,6 @@ void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 EXPORT_SYMBOL(clk_init_cpufreq_table);
 #endif
 
-/* Clk notifier implementations */
-
 /**
  * clk_notifier_register - add a clock parameter change notifier
  * @clk: struct clk * to watch
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index e0ea8cb..fce7bc2 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -188,7 +188,6 @@ extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #endif
 void omap_clk_add_child(struct clk *clk, struct clk *clk2);
 void omap_clk_del_child(struct clk *clk, struct clk *clk2);
-extern int omap_clk_notify_downstream(struct clk *clk, unsigned long msg);
 
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
-- 
1.5.4.3
