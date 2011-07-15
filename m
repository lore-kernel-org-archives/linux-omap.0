From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 REPOST 12/12] OMAP: dmtimer: Off mode support
Date: Fri, 15 Jul 2011 17:35:01 +0530
Message-ID: <1310731501-13078-13-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55886 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab1GOMGK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 08:06:10 -0400
In-Reply-To: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Clock is enabled only when timer is started and disabled when the the timer
is stopped. Therefore before accessing registers in functions clock is enabled
and then disabled back at the end of access.
Context save and restore functions are called as needed based upon whether the
context is lost or not.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   17 +++++
 arch/arm/plat-omap/dmtimer.c              |   97 +++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/dmtimer.h |    9 +++
 3 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 9d47300..d1c6219 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -44,6 +44,9 @@
 #include <plat/common.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/omap-pm.h>
+
+#include "powerdomain.h"
 
 /* Parent clocks, eventually these will come from the clock framework */
 
@@ -409,6 +412,16 @@ static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int omap_timer_get_context_loss(struct device *dev)
+{
+	return omap_pm_get_dev_context_loss_count(dev);
+}
+
+#else
+#define omap_gpio_get_context_loss NULL
+#endif
+
 struct omap_device_pm_latency omap2_dmtimer_latency[] = {
 	{
 		.deactivate_func = omap_device_idle_hwmods,
@@ -437,6 +450,7 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	struct dmtimer_platform_data *pdata;
 	struct omap_device *od;
 	struct omap_timer_capability_dev_attr *timer_dev_attr;
+	struct powerdomain *pwrdm;
 
 	pr_debug("%s: %s\n", __func__, oh->name);
 
@@ -466,6 +480,9 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 
 	pdata->set_timer_src = omap2_dm_timer_set_src;
 	pdata->timer_ip_type = oh->class->rev;
+	pwrdm = omap_hwmod_get_pwrdm(oh);
+	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
+	pdata->get_context_loss_count = omap_timer_get_context_loss;
 
 	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
 			omap2_dmtimer_latency,
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index cdef48b..db14d7f 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -151,12 +151,14 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
+	omap_dm_timer_enable(timer);
 	if (timer->pdev->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
 
 	__omap_dm_timer_reset(timer->io_base, 0, 0, timer->func_offset);
+	omap_dm_timer_disable(timer);
 	timer->posted = 1;
 }
 
@@ -171,14 +173,13 @@ void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 		return;
 	}
 
-	omap_dm_timer_enable(timer);
-
 	if (pdata->needs_manual_reset)
 		omap_dm_timer_reset(timer);
 
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
 	timer->posted = 1;
+	timer->context_changed = true;
 }
 
 struct omap_dm_timer *omap_dm_timer_request(void)
@@ -230,7 +231,6 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_disable(timer);
 	clk_put(timer->fclk);
 
 	WARN_ON(!timer->reserved);
@@ -311,6 +311,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 void omap_dm_timer_trigger(struct omap_dm_timer *timer)
 {
+	if (unlikely(!timer->reserved)) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return;
+	}
+
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
@@ -319,6 +324,20 @@ void omap_dm_timer_start(struct omap_dm_timer *timer)
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
+
+	if (timer->loses_context) {
+		u32 ctx_loss_cnt_after;
+
+		ctx_loss_cnt_after =
+			timer->get_context_loss_count(&timer->pdev->dev);
+		if ((ctx_loss_cnt_after != timer->ctx_loss_count) &&
+					timer->context_saved) {
+			omap_timer_restore_context(timer);
+			timer->context_saved = false;
+		}
+	}
+
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
 		l |= OMAP_TIMER_CTRL_ST;
@@ -340,6 +359,19 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer->io_base, timer->posted, rate,
 			is_omap2, timer->intr_offset, timer->func_offset);
+
+	if (timer->loses_context) {
+		if (timer->get_context_loss_count)
+			timer->ctx_loss_count =
+			timer->get_context_loss_count(&timer->pdev->dev);
+		if (timer->context_changed) {
+			omap_timer_save_context(timer);
+			timer->context_saved = true;
+			timer->context_changed = false;
+		}
+	}
+
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
@@ -351,9 +383,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-	omap_dm_timer_disable(timer);
 	ret = pdata->set_timer_src(timer->pdev, source);
-	omap_dm_timer_enable(timer);
 
 	__delay(300000);
 
@@ -366,6 +396,7 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload)
 		l |= OMAP_TIMER_CTRL_AR;
@@ -375,6 +406,9 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
+	omap_dm_timer_disable(timer);
+
+	timer->context_changed = true;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
 
@@ -384,6 +418,20 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
+
+	if (timer->loses_context) {
+		int ctx_loss_cnt_after;
+
+		ctx_loss_cnt_after =
+			timer->get_context_loss_count(&timer->pdev->dev);
+		if ((ctx_loss_cnt_after != timer->ctx_loss_count) &&
+				timer->context_saved) {
+			omap_timer_restore_context(timer);
+			timer->context_saved = false;
+		}
+	}
+
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload) {
 		l |= OMAP_TIMER_CTRL_AR;
@@ -395,6 +443,8 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 
 	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted,
 					timer->func_offset);
+
+	timer->context_changed = true;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
@@ -403,6 +453,7 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
@@ -410,6 +461,9 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 		l &= ~OMAP_TIMER_CTRL_CE;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
+	omap_dm_timer_disable(timer);
+
+	timer->context_changed = true;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
 
@@ -418,6 +472,7 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
@@ -427,6 +482,9 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 		l |= OMAP_TIMER_CTRL_PT;
 	l |= trigger << 10;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	omap_dm_timer_disable(timer);
+
+	timer->context_changed = true;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 
@@ -434,6 +492,7 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0x00 && prescaler <= 0x07) {
@@ -441,14 +500,21 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 		l |= prescaler << 2;
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	omap_dm_timer_disable(timer);
+
+	timer->context_changed = true;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
+	omap_dm_timer_enable(timer);
 	__omap_dm_timer_int_enable(timer->io_base, value,
 					timer->intr_offset, timer->func_offset);
+	omap_dm_timer_disable(timer);
+
+	timer->context_changed = true;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
@@ -456,6 +522,11 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
+	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return 0;
+	}
+
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG);
 
 	return l;
@@ -466,11 +537,17 @@ void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
 	__omap_dm_timer_write_status(timer->io_base, value,
 					timer->intr_offset, timer->func_offset);
+	timer->context_changed = true;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
+	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return 0;
+	}
+
 	return __omap_dm_timer_read_counter(timer->io_base, timer->posted,
 						timer->func_offset);
 }
@@ -478,7 +555,14 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
 void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
+	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return;
+	}
+
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
+
+	timer->context_changed = true;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
@@ -560,6 +644,9 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->id = pdev->id;
 	timer->irq = irq->start;
 	timer->pdev = pdev;
+	timer->context_changed = false;
+	timer->loses_context = pdata->loses_context;
+	timer->get_context_loss_count = pdata->get_context_loss_count;
 
 	if (!pdata->needs_manual_reset) {
 		pm_runtime_enable(&pdev->dev);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 9a2d7e3..379b9c7 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -85,6 +85,9 @@ struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	int timer_ip_type;
 	u32 needs_manual_reset:1;
+	bool loses_context;
+
+	int (*get_context_loss_count)(struct device *dev);
 };
 
 struct omap_dm_timer *omap_dm_timer_request(void);
@@ -269,8 +272,14 @@ struct omap_dm_timer {
 	u8 func_offset;
 	u8 intr_offset;
 	struct timer_regs context;
+	bool loses_context;
+	bool context_saved;
+	bool context_changed;
+	int ctx_loss_count;
 	struct platform_device *pdev;
 	struct list_head node;
+
+	int (*get_context_loss_count)(struct device *dev);
 };
 
 extern u32 sys_timer_reserved;
-- 
1.6.0.4

