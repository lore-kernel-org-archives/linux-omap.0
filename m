From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v13 06/11] dmtimer: switch-over to platform device driver
Date: Sat, 16 Apr 2011 21:20:58 +0530
Message-ID: <1302969063-8231-7-git-send-email-tarun.kanti@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33951 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755799Ab1DPPu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Apr 2011 11:50:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3GFoMbo016599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 10:50:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p3GFoMfS026791
	for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 21:20:22 +0530 (IST)
In-Reply-To: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Register timer devices by going through hwmod database using
hwmod API. The driver probes each of the registered devices.
Functionality which are already performed by hwmod framework
are removed from timer code. New set of timers present on
OMAP4 are now supported.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   44 +++-
 arch/arm/plat-omap/dmtimer.c              |  377 +++++++++--------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |   74 ++++--
 3 files changed, 205 insertions(+), 290 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1c80337..b7862ca 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -80,7 +80,8 @@ static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &clockevent_gpt;
 
-	__omap_dm_timer_write_status(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
+	__omap_dm_timer_write_status(clkev.io_base, OMAP_TIMER_INT_OVERFLOW,
+				0, clkev.intr_offset, clkev.func_offset);
 
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
@@ -96,7 +97,7 @@ static int omap2_gp_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
 	__omap_dm_timer_load_start(clkev.io_base, OMAP_TIMER_CTRL_ST,
-						0xffffffff - cycles, 1);
+				0xffffffff - cycles, 1, clkev.func_offset);
 
 	return 0;
 }
@@ -105,8 +106,10 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 				    struct clock_event_device *evt)
 {
 	u32 period;
+	unsigned long rate = clk_get_rate(clkev.fclk) + 1;
 
-	omap_dm_timer_stop(&clkev);
+	__omap_dm_timer_stop(clkev.io_base, rate, 0, true, clkev.intr_offset,
+				clkev.func_offset);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -131,7 +134,7 @@ static struct clock_event_device clockevent_gpt = {
 	.set_mode	= omap2_gp_timer_set_mode,
 };
 
-int __omap_dm_timer_set_source(struct clk *timer_fck, struct clk *parent)
+static int __omap_dm_timer_set_source(struct clk *timer_fck, struct clk *parent)
 {
 	int ret;
 
@@ -204,6 +207,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		}
 	}
 	__omap_dm_timer_reset(timer, 1, 1);
+	__omap_dm_timer_set_posted(timer->io_base, timer->func_offset);
 
 	timer->rate = clk_get_rate(timer->fclk);
 
@@ -223,7 +227,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	omap2_gp_timer_irq.dev_id = (void *)&clkev;
 	setup_irq(clkev.irq, &omap2_gp_timer_irq);
 
-	__omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
+	__omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_INT_OVERFLOW,
+				0, clkev.intr_offset, clkev.func_offset);
 
 	clockevent_gpt.mult = div_sc(clkev.rate, NSEC_PER_SEC,
 				     clockevent_gpt.shift);
@@ -264,7 +269,8 @@ static struct omap_dm_timer clksrc;
 static DEFINE_CLOCK_DATA(cd);
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
-	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
+	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1,
+						clksrc.func_offset);
 }
 
 static struct clocksource clocksource_gpt = {
@@ -279,7 +285,8 @@ static void notrace dmtimer_update_sched_clock(void)
 {
 	u32 cyc;
 
-	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
+	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1,
+						clksrc.func_offset);
 
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
@@ -289,7 +296,8 @@ unsigned long long notrace sched_clock(void)
 	u32 cyc = 0;
 
 	if (clksrc.reserved)
-		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
+		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1,
+							clksrc.func_offset);
 
 	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
@@ -515,3 +523,23 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 
 	return ret;
 }
+
+/**
+ * omap2_dm_timer_init - top level regular device initialization
+ *
+ * Uses dedicated hwmod api to parse through hwmod database for
+ * given class name and then build and register the timer device.
+ */
+static int __init omap2_dm_timer_init(void)
+{
+	int ret;
+
+	ret = omap_hwmod_for_each_by_class("timer", omap_timer_init, NULL);
+	if (unlikely(ret)) {
+		pr_err("%s: device registration failed.\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+arch_initcall(omap2_dm_timer_init);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index b2398a7..d85791a 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -36,138 +36,55 @@
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 
 #include <plat/dmtimer.h>
-#include <mach/irqs.h>
-
-static int dm_timer_count;
-
-#ifdef CONFIG_ARCH_OMAP2
-static struct omap_dm_timer omap2_dm_timers[] = {
-	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
-	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
-	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
-	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
-	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
-	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
-	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
-};
-
-static const char *omap2_dm_source_names[] __initdata = {
-	"sys_ck",
-	"func_32k_ck",
-	"alt_ck",
-	NULL
-};
-
-static struct clk *omap2_dm_source_clocks[3];
-static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
-
-#else
-#define omap2_dm_timers			NULL
-#define omap2_dm_timer_count		0
-#define omap2_dm_source_names		NULL
-#define omap2_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP2 */
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct omap_dm_timer omap3_dm_timers[] = {
-	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
-	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
-	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
-	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
-	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
-	{ .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
-	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
-};
-
-static const char *omap3_dm_source_names[] __initdata = {
-	"sys_ck",
-	"omap_32k_fck",
-	NULL
-};
-
-static struct clk *omap3_dm_source_clocks[2];
-static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
-
-#else
-#define omap3_dm_timers			NULL
-#define omap3_dm_timer_count		0
-#define omap3_dm_source_names		NULL
-#define omap3_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP3 */
-
-#ifdef CONFIG_ARCH_OMAP4
-static struct omap_dm_timer omap4_dm_timers[] = {
-	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
-	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
-	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
-	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
-	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
-	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
-	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
-	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
-	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
-	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
-	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
-	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
-};
-static const char *omap4_dm_source_names[] __initdata = {
-	"sys_clkin_ck",
-	"sys_32k_ck",
-	NULL
-};
-static struct clk *omap4_dm_source_clocks[2];
-static const int omap4_dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
-
-#else
-#define omap4_dm_timers			NULL
-#define omap4_dm_timer_count		0
-#define omap4_dm_source_names		NULL
-#define omap4_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP4 */
-
-static struct omap_dm_timer *dm_timers;
-static const char **dm_source_names;
-static struct clk **dm_source_clocks;
 
-static spinlock_t dm_timer_lock;
 static LIST_HEAD(omap_timer_list);
+static DEFINE_SPINLOCK(dm_timer_lock);
 
-/*
- * Reads timer registers in posted and non-posted mode. The posted mode bit
- * is encoded in reg. Note that in posted mode write pending bit must be
- * checked. Otherwise a read of a non completed write will produce an error.
+/**
+ * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
+ * @timer:      timer pointer over which read operation to perform
+ * @reg:        lowest byte holds the register offset
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode write
+ * pending bit must be checked. Otherwise a read of a non completed write
+ * will produce an error.
  */
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
-	return __omap_dm_timer_read(timer->io_base, reg, timer->posted);
+	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
+		reg += timer->func_offset;
+	else if (reg >= OMAP_TIMER_STAT_REG)
+		reg += timer->intr_offset;
+
+	return __omap_dm_timer_read(timer->io_base, reg, timer->posted,
+					timer->func_offset);
 }
 
-/*
- * Writes timer registers in posted and non-posted mode. The posted mode bit
- * is encoded in reg. Note that in posted mode the write pending bit must be
- * checked. Otherwise a write on a register which has a pending write will be
- * lost.
+/**
+ * omap_dm_timer_write_reg - write timer registers in posted and non-posted mode
+ * @timer:      timer pointer over which write operation is to perform
+ * @reg:        lowest byte holds the register offset
+ * @value:      data to write into the register
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode the write
+ * pending bit must be checked. Otherwise a write on a register which has a
+ * pending write will be lost.
  */
 static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 						u32 value)
 {
-	__omap_dm_timer_write(timer->io_base, reg, value, timer->posted);
+	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
+		reg += timer->func_offset;
+	else if (reg >= OMAP_TIMER_STAT_REG)
+		reg += timer->intr_offset;
+
+	__omap_dm_timer_write(timer->io_base, reg, value, timer->posted,
+				timer->func_offset);
 }
 
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
@@ -201,61 +118,61 @@ void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
 		l |= 1 << 2;
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
-
-	/* Match hardware reset default of posted mode */
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
-			OMAP_TIMER_CTRL_POSTED);
-	timer->posted = 1;
 }
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
 	int autoidle = 0, wakeup = 0;
 
-	if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
+	if (timer->pdev->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
-	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
-
-	/* Enable autoidle on OMAP2 / OMAP3 */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		autoidle = 1;
-
-	/*
-	 * Enable wake-up on OMAP2 CPUs.
-	 */
-	if (cpu_class_is_omap2())
-		wakeup = 1;
-
 	__omap_dm_timer_reset(timer, autoidle, wakeup);
 }
 
 void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
+	timer->fclk = clk_get(&timer->pdev->dev, "fck");
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+		timer->fclk = NULL;
+		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
+		return;
+	}
+
 	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
+
+	if (pdata->needs_manual_reset)
+		omap_dm_timer_reset(timer);
+
+	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+
+	__omap_dm_timer_set_posted(timer->io_base, timer->func_offset);
+	timer->posted = 1;
 }
 
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
-	struct omap_dm_timer *timer = NULL;
+	struct omap_dm_timer *timer = NULL, *t;
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
-	for (i = 0; i < dm_timer_count; i++) {
-		if (dm_timers[i].reserved)
+	list_for_each_entry(t, &omap_timer_list, node) {
+		if (t->reserved)
 			continue;
 
-		timer = &dm_timers[i];
+		timer = t;
 		timer->reserved = 1;
 		break;
 	}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	if (timer != NULL)
+	if (timer)
 		omap_dm_timer_prepare(timer);
+	else
+		pr_debug("%s: free timer not available.\n", __func__);
 
 	return timer;
 }
@@ -263,23 +180,23 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
-	struct omap_dm_timer *timer;
+	struct omap_dm_timer *timer = NULL, *t;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
-	if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
-		spin_unlock_irqrestore(&dm_timer_lock, flags);
-		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
-		       __FILE__, __LINE__, __func__, id);
-		dump_stack();
-		return NULL;
+	list_for_each_entry(t, &omap_timer_list, node) {
+		if (t->pdev->id == id && !t->reserved) {
+			timer = t;
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
+	else
+		pr_debug("%s: timer%d not available.\n", __func__, id);
 
 	return timer;
 }
@@ -287,10 +204,10 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
 	omap_dm_timer_disable(timer);
 
+	clk_put(timer->fclk);
+
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
 }
@@ -301,12 +218,8 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 	if (timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
-		clk_enable(timer->fclk);
-		clk_enable(timer->iclk);
-	}
-#endif
+	clk_enable(timer->fclk);
+	clk_enable(timer->iclk);
 
 	timer->enabled = 1;
 }
@@ -317,12 +230,8 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
 	if (!timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
-		clk_disable(timer->iclk);
-		clk_disable(timer->fclk);
-	}
-#endif
+	clk_disable(timer->fclk);
+	clk_disable(timer->iclk);
 
 	timer->enabled = 0;
 }
@@ -342,24 +251,30 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
  */
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
-	int i;
+	int i = 0;
+	struct omap_dm_timer *timer = NULL;
+	unsigned long flags;
 
 	/* If ARMXOR cannot be idled this function call is unnecessary */
 	if (!(inputmask & (1 << 1)))
 		return inputmask;
 
 	/* If any active timer is using ARMXOR return modified mask */
-	for (i = 0; i < dm_timer_count; i++) {
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry(timer, &omap_timer_list, node) {
+
 		u32 l;
 
-		l = omap_dm_timer_read_reg(&dm_timers[i], OMAP_TIMER_CTRL_REG);
+		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 		if (l & OMAP_TIMER_CTRL_ST) {
 			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
 				inputmask &= ~(1 << 1);
 			else
 				inputmask &= ~(1 << 2);
 		}
+		i++;
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	return inputmask;
 }
@@ -403,35 +318,38 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 
 void omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
-	u32 l;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	bool omap2 = true;
+	unsigned long rate = clk_get_rate(timer->fclk) + 1;
 
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (l & OMAP_TIMER_CTRL_ST) {
-		l &= ~0x1;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		/* Readback to make sure write has completed */
-		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-		 /*
-		  * Wait for functional clock period x 3.5 to make sure that
-		  * timer is stopped
-		  */
-		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
-#endif
-	}
-	/* Ack possibly pending interrupt */
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
-			OMAP_TIMER_INT_OVERFLOW);
+	if (unlikely(pdata->needs_manual_reset))
+		omap2 = false;
+
+	__omap_dm_timer_stop(timer->io_base, rate, timer->posted, omap2,
+			timer->intr_offset, timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
+	int ret = -EINVAL;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-	return __omap_dm_timer_set_source(timer->fclk,
-						dm_source_clocks[source]);
+	omap_dm_timer_disable(timer);
+	/* change the timer clock source */
+	ret = pdata->set_timer_src(timer->pdev, source);
+	omap_dm_timer_enable(timer);
+
+	/*
+	 * When the functional clock disappears, too quick writes seem
+	 * to cause an abort. XXX Is this still necessary?
+	 */
+	__delay(300000);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
@@ -467,7 +385,8 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	}
 	l |= OMAP_TIMER_CTRL_ST;
 
-	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted);
+	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted,
+					timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
@@ -520,7 +439,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
-	__omap_dm_timer_int_enable(timer->io_base, value);
+	__omap_dm_timer_int_enable(timer->io_base, value, timer->posted,
+			timer->intr_offset, timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
@@ -536,13 +456,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 
 void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
-	__omap_dm_timer_write_status(timer->io_base, value);
+	__omap_dm_timer_write_status(timer->io_base, value, timer->posted,
+				timer->intr_offset, timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	return __omap_dm_timer_read_counter(timer->io_base, timer->posted);
+	return __omap_dm_timer_read_counter(timer->io_base, timer->posted,
+						timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
@@ -554,13 +476,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
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
 
@@ -721,66 +639,3 @@ MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
-
-int __init omap_dm_timer_init(void)
-{
-	struct omap_dm_timer *timer;
-	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
-
-	if (!cpu_class_is_omap2())
-		return -ENODEV;
-
-	spin_lock_init(&dm_timer_lock);
-
-	if (cpu_is_omap24xx()) {
-		dm_timers = omap2_dm_timers;
-		dm_timer_count = omap2_dm_timer_count;
-		dm_source_names = omap2_dm_source_names;
-		dm_source_clocks = omap2_dm_source_clocks;
-	} else if (cpu_is_omap34xx()) {
-		dm_timers = omap3_dm_timers;
-		dm_timer_count = omap3_dm_timer_count;
-		dm_source_names = omap3_dm_source_names;
-		dm_source_clocks = omap3_dm_source_clocks;
-	} else if (cpu_is_omap44xx()) {
-		dm_timers = omap4_dm_timers;
-		dm_timer_count = omap4_dm_timer_count;
-		dm_source_names = omap4_dm_source_names;
-		dm_source_clocks = omap4_dm_source_clocks;
-	}
-
-	if (cpu_class_is_omap2())
-		for (i = 0; dm_source_names[i] != NULL; i++)
-			dm_source_clocks[i] = clk_get(NULL, dm_source_names[i]);
-
-	if (cpu_is_omap243x())
-		dm_timers[0].phys_base = 0x49018000;
-
-	for (i = 0; i < dm_timer_count; i++) {
-		timer = &dm_timers[i];
-
-		/* Static mapping, never released */
-		timer->io_base = ioremap(timer->phys_base, map_size);
-		BUG_ON(!timer->io_base);
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		if (cpu_class_is_omap2()) {
-			char clk_name[16];
-			sprintf(clk_name, "gpt%d_ick", i + 1);
-			timer->iclk = clk_get(NULL, clk_name);
-			sprintf(clk_name, "gpt%d_fck", i + 1);
-			timer->fclk = clk_get(NULL, clk_name);
-		}
-
-		/* One or two timers may be set up early for sys_timer */
-		if (sys_timer_reserved & (1  << i)) {
-			timer->reserved = 1;
-			timer->posted = 1;
-		}
-#endif
-	}
-
-	return 0;
-}
-
-arch_initcall(omap_dm_timer_init);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 5d4bca1..3af2e86 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -36,6 +36,7 @@
 #define __ASM_ARCH_DMTIMER_H
 
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 
 /* clock sources */
 #define OMAP_TIMER_SRC_SYS_CLK			0x00
@@ -76,7 +77,6 @@ struct omap_timer_capability_dev_attr {
 };
 
 extern struct omap_dm_timer *gptimer_wakeup;
-struct clk;
 
 struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
@@ -84,8 +84,6 @@ struct dmtimer_platform_data {
 	u32 needs_manual_reset:1;
 };
 
-int omap_dm_timer_init(void);
-
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
 void omap_dm_timer_free(struct omap_dm_timer *timer);
@@ -250,14 +248,13 @@ struct omap_dm_timer {
 extern u32 sys_timer_reserved;
 void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
 				int wakeup);
-void omap_dm_timer_prepare(struct omap_dm_timer *timer);
-int __omap_dm_timer_set_source(struct clk *timer_fck, struct clk *parent);
-void __omap_dm_timer_stop(void __iomem *base, int posted, unsigned long rate);
 
-static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg, int posted)
+static inline u32
+__omap_dm_timer_read(void __iomem *base, u32 reg, int posted, u8 func_offset)
 {
 	if (posted)
-		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+		while (__raw_readl(base +
+			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff))
 				& (reg >> WPSHIFT))
 			cpu_relax();
 
@@ -265,10 +262,11 @@ static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg, int posted)
 }
 
 static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, u32 val,
-						int posted)
+						int posted, u8 func_offset)
 {
 	if (posted)
-		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+		while (__raw_readl(base +
+			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff))
 				& (reg >> WPSHIFT))
 			cpu_relax();
 
@@ -276,29 +274,63 @@ static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, u32 val,
 }
 
 static inline void __omap_dm_timer_load_start(void __iomem *base, u32 ctrl,
-						unsigned int load, int posted)
+			unsigned int load, int posted, u8 func_offset)
 {
-	__omap_dm_timer_write(base, OMAP_TIMER_COUNTER_REG, load, posted);
-	__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG, ctrl, posted);
+	__omap_dm_timer_write(base, OMAP_TIMER_COUNTER_REG + func_offset,
+				load, posted, func_offset);
+	__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG + func_offset,
+				ctrl, posted, func_offset);
 }
 
 static inline void __omap_dm_timer_int_enable(void __iomem *base,
-						unsigned int value)
+		unsigned int value, int posted, u8 intr_offset, u8 func_offset)
 {
-	__omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG, value, 0);
-	__omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+	__omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG + intr_offset,
+				value, posted, func_offset);
+	__omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG + func_offset,
+				value, posted, func_offset);
 }
 
-static inline unsigned int __omap_dm_timer_read_counter(void __iomem *base,
-							int posted)
+static inline unsigned int
+__omap_dm_timer_read_counter(void __iomem *base, int posted, u8 func_offset)
 {
-	return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_REG, posted);
+	return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_REG + func_offset,
+					posted,	func_offset);
 }
 
 static inline void __omap_dm_timer_write_status(void __iomem *base,
-						unsigned int value)
+		unsigned int value, int posted, u8 intr_offset, u8 func_offset)
+{
+	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG + intr_offset,
+				value, posted, func_offset);
+}
+
+static inline void
+__omap_dm_timer_set_posted(void __iomem *base, u8 func_offset)
 {
-	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG, value, 0);
+	__omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG + func_offset,
+				OMAP_TIMER_CTRL_POSTED, 0, func_offset);
 }
 
+static inline void __omap_dm_timer_stop(void __iomem *base, unsigned long rate,
+			int posted, bool omap2, u8 intr_offset, u8 func_offset)
+{
+	u32 l;
+
+	l = __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG + func_offset,
+					posted, func_offset);
+	if (l & OMAP_TIMER_CTRL_ST) {
+		l &= ~0x1;
+		__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG + func_offset,
+					l, posted, func_offset);
+		if (omap2) {
+			/* Readback to make sure write has completed */
+			__omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG +
+					func_offset, posted, func_offset);
+			udelay(3500000 / rate);
+		}
+	}
+	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG + intr_offset,
+				OMAP_TIMER_INT_OVERFLOW, posted, func_offset);
+}
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.6.0.4

