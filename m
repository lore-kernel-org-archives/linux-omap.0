From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 09/12] OMAP: dmtimer: low-power mode support
Date: Wed, 21 Sep 2011 18:00:15 -0700
Message-ID: <20110922010015.GP2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16512 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874Ab1IVBAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 21:00:17 -0400
Content-Disposition: inline
In-Reply-To: <1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> Clock is enabled only when timer is started and disabled when the the timer
> is stopped. Therefore before accessing registers in functions clock is enabled
> and then disabled back at the end of access. Context save is done dynamically
> whenever the registers are modified. Context restore is called when context is
> lost.

I've updated this to use revision instead of tidr. Updated patch below.

Regards,

Tony


From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Date: Tue, 20 Sep 2011 17:00:24 +0530
Subject: [PATCH] ARM: OMAP: dmtimer: low-power mode support

Clock is enabled only when timer is started and disabled when the the timer
is stopped. Therefore before accessing registers in functions clock is enabled
and then disabled back at the end of access. Context save is done dynamically
whenever the registers are modified. Context restore is called when context is
lost.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[tony@atomide.com: updated to use revision instead of tidr]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index f1e3ec1..1140e98 100644
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
 
@@ -467,6 +471,11 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	if ((sys_timer_reserved >> (id - 1)) & 0x1)
 		pdata->reserved = 1;
 
+	pwrdm = omap_hwmod_get_pwrdm(oh);
+	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
+#ifdef CONFIG_PM
+	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
+#endif
 	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
 			omap2_dmtimer_latency,
 			ARRAY_SIZE(omap2_dmtimer_latency),
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c8df3c3..43eb750 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -77,6 +77,29 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 	__omap_dm_timer_write(timer, reg, value, timer->posted);
 }
 
+static void omap_timer_restore_context(struct omap_dm_timer *timer)
+{
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_OFFSET,
+				timer->context.tiocp_cfg);
+	if (timer->revision > 1)
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
 
@@ -311,9 +350,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-	omap_dm_timer_disable(timer);
 	ret = pdata->set_timer_src(timer->pdev, source);
-	omap_dm_timer_enable(timer);
 
 	return ret;
 }
@@ -324,6 +361,7 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload)
 		l |= OMAP_TIMER_CTRL_AR;
@@ -333,6 +371,10 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
+	/* Save the context */
+	timer->context.tclr = l;
+	timer->context.tldr = load;
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
 
@@ -342,6 +384,15 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
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
@@ -352,6 +403,11 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	l |= OMAP_TIMER_CTRL_ST;
 
 	__omap_dm_timer_load_start(timer, l, load, timer->posted);
+
+	/* Save the context */
+	timer->context.tclr = l;
+	timer->context.tldr = load;
+	timer->context.tcrr = load;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
@@ -360,6 +416,7 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
@@ -367,6 +424,11 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
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
 
@@ -375,6 +437,7 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
@@ -384,6 +447,10 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 		l |= OMAP_TIMER_CTRL_PT;
 	l |= trigger << 10;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+
+	/* Save the context */
+	timer->context.tclr = l;
+	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 
@@ -391,6 +458,7 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
 	u32 l;
 
+	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0x00 && prescaler <= 0x07) {
@@ -398,13 +466,23 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
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
 
@@ -412,6 +490,11 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
+	if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
+		return 0;
+	}
+
 	l = __raw_readl(timer->irq_stat);
 
 	return l;
@@ -421,18 +504,33 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
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
 
@@ -511,6 +609,8 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->reserved = pdata->reserved;
 	timer->pdev = pdev;
+	timer->loses_context = pdata->loses_context;
+	timer->get_context_loss_count = pdata->get_context_loss_count;
 
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!pdata->needs_manual_reset) {
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 29764c3..9519d87 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -73,11 +73,38 @@ struct omap_timer_capability_dev_attr {
 struct omap_dm_timer;
 struct clk;
 
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
 struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	int timer_ip_version;
 	u32 needs_manual_reset:1;
 	bool reserved;
+
+	bool loses_context;
+
+	u32 (*get_context_loss_count)(struct device *dev);
 };
 
 struct omap_dm_timer *omap_dm_timer_request(void);
@@ -245,8 +272,14 @@ struct omap_dm_timer {
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
+	struct timer_regs context;
+	bool loses_context;
+	int ctx_loss_count;
+	int revision;
 	struct platform_device *pdev;
 	struct list_head node;
+
+	u32 (*get_context_loss_count)(struct device *dev);
 };
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer);
@@ -278,6 +311,7 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 	/* Assume v1 ip if bits [31:16] are zero */
 	tidr = __raw_readl(timer->io_base);
 	if (!(tidr >> 16)) {
+		timer->revision = 1;
 		timer->sys_stat = timer->io_base +
 				OMAP_TIMER_V1_SYS_STAT_OFFSET;
 		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
@@ -286,6 +320,7 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
 		timer->func_base = timer->io_base;
 	} else {
+		timer->revision = 2;
 		timer->sys_stat = 0;
 		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
 		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
