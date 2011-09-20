From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v16 09/12] OMAP: dmtimer: low-power mode support
Date: Tue, 20 Sep 2011 17:00:24 +0530
Message-ID: <1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59407 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617Ab1ITLau (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 07:30:50 -0400
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Clock is enabled only when timer is started and disabled when the the timer
is stopped. Therefore before accessing registers in functions clock is enabled
and then disabled back at the end of access. Context save is done dynamically
whenever the registers are modified. Context restore is called when context is
lost.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    9 ++
 arch/arm/plat-omap/dmtimer.c              |  126 +++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |   31 +++++++
 3 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e042b3c..041fed9 100644
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
 
@@ -433,6 +436,7 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	struct dmtimer_platform_data *pdata;
 	struct omap_device *od;
 	struct omap_timer_capability_dev_attr *timer_dev_attr;
+	struct powerdomain *pwrdm;
 
 	pr_debug("%s: %s\n", __func__, oh->name);
 
@@ -463,6 +467,11 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	pdata->set_timer_src = omap2_dm_timer_set_src;
 	pdata->timer_ip_version = oh->class->rev;
 
+	pwrdm = omap_hwmod_get_pwrdm(oh);
+	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
+#ifdef CONFIG_PM
+	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
+#endif
 	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
 			omap2_dmtimer_latency,
 			ARRAY_SIZE(omap2_dmtimer_latency),
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 9c9feb9..f549c63 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -77,6 +77,29 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 	__omap_dm_timer_write(timer, reg, value, timer->posted);
 }
 
+static void omap_timer_restore_context(struct omap_dm_timer *timer)
+{
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_OFFSET,
+				timer->context.tiocp_cfg);
+	if (!(timer->tidr >> 16))
+		__raw_writel(timer->context.tistat, timer->sys_stat);
+
+	__raw_writel(timer->context.tisr, timer->irq_stat);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
+				timer->context.twer);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
+				timer->context.tcrr);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG,
+				timer->context.tldr);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG,
+				timer->context.tmar);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
+				timer->context.tsicr);
+	__raw_writel(timer->context.tier, timer->irq_ena);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG,
+				timer->context.tclr);
+}
+
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 {
 	int c;
@@ -96,12 +119,14 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
+	omap_dm_timer_enable(timer);
 	if (timer->pdev->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
 
 	__omap_dm_timer_reset(timer, 0, 0);
+	omap_dm_timer_disable(timer);
 	timer->posted = 1;
 }
 
@@ -117,8 +142,6 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 		return -EINVAL;
 	}
 
-	omap_dm_timer_enable(timer);
-
 	if (pdata->needs_manual_reset)
 		omap_dm_timer_reset(timer);
 
@@ -193,7 +216,6 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_disable(timer);
 	clk_put(timer->fclk);
 
 	WARN_ON(!timer->reserved);
@@ -275,6 +297,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 void omap_dm_timer_trigger(struct omap_dm_timer *timer)
 {
+	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return;
+	}
+
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
@@ -283,11 +310,23 @@ void omap_dm_timer_start(struct omap_dm_timer *timer)
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
+
+	if (timer->loses_context) {
+		u32 ctx_loss_cnt_after =
+			timer->get_context_loss_count(&timer->pdev->dev);
+		if (ctx_loss_cnt_after != timer->ctx_loss_count)
+			omap_timer_restore_context(timer);
+	}
+
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
 		l |= OMAP_TIMER_CTRL_ST;
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	}
+
+	/* Save the context */
+	timer->context.tclr = l;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 
@@ -303,6 +342,22 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 		rate = clk_get_rate(timer->fclk);
 
 	__omap_dm_timer_stop(timer, timer->posted, rate, is_omap2);
+
+	if (timer->loses_context) {
+		if (timer->get_context_loss_count)
+			timer->ctx_loss_count =
+			timer->get_context_loss_count(&timer->pdev->dev);
+	}
+
+	/*
+	 * Since the register values are computed and written within
+	 * __omap_dm_timer_stop, we need to use read to retrieve the
+	 * context.
+	 */
+	timer->context.tclr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.tisr = __raw_readl(timer->irq_stat);
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
@@ -314,9 +369,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-	omap_dm_timer_disable(timer);
 	ret = pdata->set_timer_src(timer->pdev, source);
-	omap_dm_timer_enable(timer);
 
 	return ret;
 }
@@ -327,6 +380,7 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload)
 		l |= OMAP_TIMER_CTRL_AR;
@@ -336,6 +390,10 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
+	/* Save the context */
+	timer->context.tclr = l;
+	timer->context.tldr = load;
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
 
@@ -345,6 +403,15 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
+
+	if (timer->loses_context) {
+		u32 ctx_loss_cnt_after =
+			timer->get_context_loss_count(&timer->pdev->dev);
+		if (ctx_loss_cnt_after != timer->ctx_loss_count)
+			omap_timer_restore_context(timer);
+	}
+
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload) {
 		l |= OMAP_TIMER_CTRL_AR;
@@ -355,6 +422,11 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	l |= OMAP_TIMER_CTRL_ST;
 
 	__omap_dm_timer_load_start(timer, l, load, timer->posted);
+
+	/* Save the context */
+	timer->context.tclr = l;
+	timer->context.tldr = load;
+	timer->context.tcrr = load;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
@@ -363,6 +435,7 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
@@ -370,6 +443,11 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 		l &= ~OMAP_TIMER_CTRL_CE;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
+
+	/* Save the context */
+	timer->context.tclr = l;
+	timer->context.tmar = match;
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
 
@@ -378,6 +456,7 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
@@ -387,6 +466,10 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 		l |= OMAP_TIMER_CTRL_PT;
 	l |= trigger << 10;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+
+	/* Save the context */
+	timer->context.tclr = l;
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 
@@ -394,6 +477,7 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0x00 && prescaler <= 0x07) {
@@ -401,13 +485,23 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 		l |= prescaler << 2;
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+
+	/* Save the context */
+	timer->context.tclr = l;
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
+	omap_dm_timer_enable(timer);
 	__omap_dm_timer_int_enable(timer, value);
+
+	/* Save the context */
+	timer->context.tier = value;
+	timer->context.twer = value;
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
@@ -415,6 +509,11 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
+	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return 0;
+	}
+
 	l = __raw_readl(timer->irq_stat);
 
 	return l;
@@ -424,18 +523,33 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
 	__omap_dm_timer_write_status(timer, value);
+	/* Save the context */
+	timer->context.tisr = value;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
+	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return 0;
+	}
+
 	return __omap_dm_timer_read_counter(timer, timer->posted);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
 void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
+	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return;
+	}
+
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
+
+	/* Save the context */
+	timer->context.tcrr = value;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
@@ -513,6 +627,8 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->id = pdev->id;
 	timer->irq = irq->start;
 	timer->pdev = pdev;
+	timer->loses_context = pdata->loses_context;
+	timer->get_context_loss_count = pdata->get_context_loss_count;
 
 /*
  * sys_timer_reserved is not defined for OMAP1.
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 6413fe2..577a7a6 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -79,6 +79,9 @@ struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	int timer_ip_version;
 	u32 needs_manual_reset:1;
+	bool loses_context;
+
+	u32 (*get_context_loss_count)(struct device *dev);
 };
 
 struct omap_dm_timer *omap_dm_timer_request(void);
@@ -232,6 +235,29 @@ int omap_dm_timers_active(void);
 /* 10ms timeout delay */
 #define MAX_WRITE_PEND_WAIT            10000
 
+struct timer_regs {
+	u32 tidr;
+	u32 tiocp_cfg;
+	u32 tistat;
+	u32 tisr;
+	u32 tier;
+	u32 twer;
+	u32 tclr;
+	u32 tcrr;
+	u32 tldr;
+	u32 ttrg;
+	u32 twps;
+	u32 tmar;
+	u32 tcar1;
+	u32 tsicr;
+	u32 tcar2;
+	u32 tpir;
+	u32 tnir;
+	u32 tcvr;
+	u32 tocr;
+	u32 towr;
+};
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
@@ -250,8 +276,13 @@ struct omap_dm_timer {
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
+	struct timer_regs context;
+	bool loses_context;
+	int ctx_loss_count;
 	struct platform_device *pdev;
 	struct list_head node;
+
+	u32 (*get_context_loss_count)(struct device *dev);
 };
 
 extern u32 sys_timer_reserved;
-- 
1.7.0.4

