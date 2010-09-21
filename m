From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 7/17] dmtimer: use list instead of static array
Date: Tue, 21 Sep 2010 14:23:25 +0530
Message-ID: <1285059205-26466-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42989 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab0ITVwc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 17:52:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch converts the use of dmtimers static array in functions
into list structure. Please note that the static arrays will be
completely removed in subsequent patches when dmtimer is converted
into a platform driver.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |   61 ++++++++++++++++++++++--------------------
 1 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index a7b1679..2d4805d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -169,6 +169,7 @@ struct omap_dm_timer {
 	unsigned enabled:1;
 	unsigned posted:1;
 	struct platform_device *pdev;
+	struct list_head node;
 };
 
 static int dm_timer_count;
@@ -291,7 +292,8 @@ static struct omap_dm_timer *dm_timers;
 static const char **dm_source_names;
 static struct clk **dm_source_clocks;
 
-static spinlock_t dm_timer_lock;
+static LIST_HEAD(omap_timer_list);
+static DEFINE_SPINLOCK(dm_timer_lock);
 
 /*
  * Reads timer registers in posted and non-posted mode. The posted mode bit
@@ -341,7 +343,7 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
 	u32 l;
 
-	if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
+	if (!cpu_class_is_omap2() || timer->id != 0) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
@@ -374,20 +376,17 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	struct omap_dm_timer *timer = NULL;
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
-	for (i = 0; i < dm_timer_count; i++) {
-		if (dm_timers[i].reserved)
+	list_for_each_entry(timer, &omap_timer_list, node) {
+		if (timer->reserved)
 			continue;
-
-		timer = &dm_timers[i];
 		timer->reserved = 1;
 		break;
 	}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	if (timer != NULL)
+	if (timer)
 		omap_dm_timer_prepare(timer);
 
 	return timer;
@@ -396,23 +395,20 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
-	struct omap_dm_timer *timer;
+	struct omap_dm_timer *timer = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
-	if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
-		spin_unlock_irqrestore(&dm_timer_lock, flags);
-		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
-		       __FILE__, __LINE__, __func__, id);
-		dump_stack();
-		return NULL;
+	list_for_each_entry(timer, &omap_timer_list, node) {
+		if (timer->id == id - 1 && !timer->reserved) {
+			timer->reserved = 1;
+			break;
+		}
 	}
-
-	timer = &dm_timers[id-1];
-	timer->reserved = 1;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	omap_dm_timer_prepare(timer);
+	if (timer)
+		omap_dm_timer_prepare(timer);
 
 	return timer;
 }
@@ -476,23 +472,28 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
 	int i;
+	struct omap_dm_timer *timer = NULL;
+	unsigned long flags;
 
 	/* If ARMXOR cannot be idled this function call is unnecessary */
 	if (!(inputmask & (1 << 1)))
 		return inputmask;
 
 	/* If any active timer is using ARMXOR return modified mask */
-	for (i = 0; i < dm_timer_count; i++) {
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry(timer, &omap_timer_list, node) {
 		u32 l;
 
-		l = omap_dm_timer_read_reg(&dm_timers[i], OMAP_TIMER_CTRL_REG);
+		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 		if (l & OMAP_TIMER_CTRL_ST) {
-			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
+			if (((omap_readl(MOD_CONF_CTRL_1) >>
+					(i * 2)) & 0x03) == 0)
 				inputmask &= ~(1 << 1);
 			else
 				inputmask &= ~(1 << 2);
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	return inputmask;
 }
@@ -723,13 +724,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
 int omap_dm_timers_active(void)
 {
-	int i;
-
-	for (i = 0; i < dm_timer_count; i++) {
-		struct omap_dm_timer *timer;
-
-		timer = &dm_timers[i];
+	struct omap_dm_timer *timer;
 
+	list_for_each_entry(timer, &omap_timer_list, node) {
 		if (!timer->enabled)
 			continue;
 
@@ -744,13 +741,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
 int __init omap_dm_timer_init(void)
 {
+	unsigned long flags;
 	struct omap_dm_timer *timer;
 	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
 
 	if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
 		return -ENODEV;
 
-	spin_lock_init(&dm_timer_lock);
 
 	if (cpu_class_is_omap1()) {
 		dm_timers = omap1_dm_timers;
@@ -795,6 +792,12 @@ int __init omap_dm_timer_init(void)
 			sprintf(clk_name, "gpt%d_fck", i + 1);
 			timer->fclk = clk_get(NULL, clk_name);
 		}
+
+		timer->id = i;
+		/* add the timer element to the list */
+		spin_lock_irqsave(&dm_timer_lock, flags);
+		list_add_tail(&timer->node, &omap_timer_list);
+		spin_unlock_irqrestore(&dm_timer_lock, flags);
 #endif
 	}
 
-- 
1.6.0.4

