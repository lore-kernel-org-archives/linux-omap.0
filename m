From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v15 12/12] OMAP: dmtimer: add error handling to export APIs
Date: Fri, 9 Sep 2011 02:38:18 +0530
Message-ID: <1315516098-29761-13-git-send-email-tarun.kanti@ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add error handling code to exported APIs. Currently, the APIs assume they
are operating on valid parameters passed to it.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |  101 ++++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/dmtimer.h |   24 ++++----
 2 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index a793482..34db29b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -222,12 +222,16 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
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
 
@@ -245,7 +249,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 {
-	return timer->irq;
+	if (timer)
+		return timer->irq;
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
 
@@ -289,7 +295,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
-	return timer->fclk;
+	if (timer)
+		return timer->fclk;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
 
@@ -303,22 +311,26 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
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
 	unsigned long flags;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
@@ -338,15 +350,19 @@ void omap_dm_timer_start(struct omap_dm_timer *timer)
 	/* Save the context */
 	timer->context.tclr = l;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 
-void omap_dm_timer_stop(struct omap_dm_timer *timer)
+int omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
 	unsigned long rate = 0, flags;
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 	bool is_omap2 = true;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	if (pdata->needs_manual_reset)
 		is_omap2 = false;
@@ -373,13 +389,19 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 			omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG);
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
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
@@ -390,12 +412,15 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
-void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
+int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 			    unsigned int load)
 {
 	u32 l;
 	unsigned long flags;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
@@ -413,16 +438,20 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	timer->context.tldr = load;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
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
 	unsigned long flags;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
@@ -450,15 +479,19 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	timer->context.tldr = load;
 	timer->context.tcrr = load;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
-void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
+int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 			     unsigned int match)
 {
 	u32 l;
 	unsigned long flags;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
@@ -474,15 +507,19 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	timer->context.tmar = match;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
 
-void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
+int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger)
 {
 	u32 l;
 	unsigned long flags;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
@@ -499,14 +536,18 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	timer->context.tclr = l;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 
-void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
+int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
 	u32 l;
 	unsigned long flags;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
@@ -521,14 +562,18 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 	timer->context.tclr = l;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 
-void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
+int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
 	unsigned long flags;
 
+	if (unlikely(!timer))
+		return -EINVAL;
+
 	omap_dm_timer_enable(timer);
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	__omap_dm_timer_int_enable(timer->io_base, value,
@@ -539,6 +584,7 @@ void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 	timer->context.twer = value;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
@@ -546,8 +592,8 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
-	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer not available or enabled.\n", __func__);
 		return 0;
 	}
 
@@ -557,19 +603,23 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 
-void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
+int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev)))
+		return -EINVAL;
+
 	__omap_dm_timer_write_status(timer->io_base, value,
 					timer->intr_offset, timer->func_offset);
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
 
@@ -578,17 +628,18 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
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
index 8c0fbb6..110a649 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -93,7 +93,7 @@ struct dmtimer_platform_data {
 
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
-void omap_dm_timer_free(struct omap_dm_timer *timer);
+int omap_dm_timer_free(struct omap_dm_timer *timer);
 void omap_dm_timer_enable(struct omap_dm_timer *timer);
 void omap_dm_timer_disable(struct omap_dm_timer *timer);
 
@@ -102,23 +102,23 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
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
