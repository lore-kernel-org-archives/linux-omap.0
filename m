From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v16 11/12] OMAP: dmtimer: add error handling to export APIs
Date: Tue, 20 Sep 2011 17:00:26 +0530
Message-ID: <1316518227-28116-12-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646Ab1ITLax (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 07:30:53 -0400
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Add error handling code to export APIs.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |  101 ++++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/dmtimer.h |   24 ++++----
 2 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 631b6af..41755ff 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -214,12 +214,16 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
-void omap_dm_timer_free(struct omap_dm_timer *timer)
+int omap_dm_timer_free(struct omap_dm_timer *timer)
 {
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	clk_put(timer->fclk);
 
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
@@ -237,7 +241,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 {
-	return timer->irq;
+	if (timer)
+		return timer->irq;
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
 
@@ -281,7 +287,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
-	return timer->fclk;
+	if (timer)
+		return timer->fclk;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
 
@@ -295,21 +303,25 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 #endif
 
-void omap_dm_timer_trigger(struct omap_dm_timer *timer)
+int omap_dm_timer_trigger(struct omap_dm_timer *timer)
 {
-	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
-		return;
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer not available or enabled.\n", __func__);
+		return -EINVAL;
 	}
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
 
-void omap_dm_timer_start(struct omap_dm_timer *timer)
+int omap_dm_timer_start(struct omap_dm_timer *timer)
 {
 	u32 l;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 
 	if (timer->loses_context) {
@@ -327,15 +339,19 @@ void omap_dm_timer_start(struct omap_dm_timer *timer)
 
 	/* Save the context */
 	timer->context.tclr = l;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 
-void omap_dm_timer_stop(struct omap_dm_timer *timer)
+int omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
 	unsigned long rate = 0;
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 	bool is_omap2 = true;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	if (pdata->needs_manual_reset)
 		is_omap2 = false;
 	else
@@ -358,13 +374,19 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	timer->context.tisr = __raw_readl(timer->irq_stat);
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	struct dmtimer_platform_data *pdata;
+
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	pdata = timer->pdev->dev.platform_data;
 
 	if (source < 0 || source >= 3)
 		return -EINVAL;
@@ -375,11 +397,14 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
-void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
+int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 			    unsigned int load)
 {
 	u32 l;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload)
@@ -394,15 +419,19 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	timer->context.tclr = l;
 	timer->context.tldr = load;
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
 
 /* Optimized set_load which removes costly spin wait in timer_start */
-void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
+int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
                             unsigned int load)
 {
 	u32 l;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 
 	if (timer->loses_context) {
@@ -427,14 +456,18 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	timer->context.tclr = l;
 	timer->context.tldr = load;
 	timer->context.tcrr = load;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
-void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
+int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 			     unsigned int match)
 {
 	u32 l;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
@@ -448,14 +481,18 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	timer->context.tclr = l;
 	timer->context.tmar = match;
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
 
-void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
+int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger)
 {
 	u32 l;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
@@ -470,13 +507,17 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	/* Save the context */
 	timer->context.tclr = l;
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 
-void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
+int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
 	u32 l;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
@@ -489,12 +530,16 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 	/* Save the context */
 	timer->context.tclr = l;
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 
-void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
+int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	__omap_dm_timer_int_enable(timer, value);
 
@@ -502,6 +547,7 @@ void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 	timer->context.tier = value;
 	timer->context.twer = value;
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
@@ -509,8 +555,8 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
-	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer not available or enabled.\n", __func__);
 		return 0;
 	}
 
@@ -520,18 +566,22 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 
-void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
+int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev)))
+		return -EINVAL;
+
 	__omap_dm_timer_write_status(timer, value);
 	/* Save the context */
 	timer->context.tisr = value;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer not iavailable or enabled.\n", __func__);
 		return 0;
 	}
 
@@ -539,17 +589,18 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
-void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
+int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
-		return;
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer not available or enabled.\n", __func__);
+		return -EINVAL;
 	}
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
 
 	/* Save the context */
 	timer->context.tcrr = value;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 577a7a6..639957f 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -86,7 +86,7 @@ struct dmtimer_platform_data {
 
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
-void omap_dm_timer_free(struct omap_dm_timer *timer);
+int omap_dm_timer_free(struct omap_dm_timer *timer);
 void omap_dm_timer_enable(struct omap_dm_timer *timer);
 void omap_dm_timer_disable(struct omap_dm_timer *timer);
 
@@ -95,23 +95,23 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
 u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer);
 
-void omap_dm_timer_trigger(struct omap_dm_timer *timer);
-void omap_dm_timer_start(struct omap_dm_timer *timer);
-void omap_dm_timer_stop(struct omap_dm_timer *timer);
+int omap_dm_timer_trigger(struct omap_dm_timer *timer);
+int omap_dm_timer_start(struct omap_dm_timer *timer);
+int omap_dm_timer_stop(struct omap_dm_timer *timer);
 
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
-void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload, unsigned int value);
-void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload, unsigned int value);
-void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, unsigned int match);
-void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, int trigger);
-void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
+int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload, unsigned int value);
+int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload, unsigned int value);
+int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, unsigned int match);
+int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, int trigger);
+int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
 
-void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned int value);
+int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned int value);
 
 unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
-void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value);
+int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value);
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
-void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value);
+int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value);
 
 int omap_dm_timers_active(void);
 
-- 
1.7.0.4

