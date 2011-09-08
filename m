From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform device driver
Date: Fri, 9 Sep 2011 02:38:12 +0530
Message-ID: <1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
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

Register timer devices by going through hwmod database using
hwmod API. The driver probes each of the registered devices.
Functionality which are already performed by hwmod framework
are removed from timer code. New set of timers present on
OMAP4 are now supported.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   56 ++++-
 arch/arm/plat-omap/dmtimer.c              |  374 ++++++++++-------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |   82 ++++---
 3 files changed, 219 insertions(+), 293 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a33916a..4758d3e 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -80,7 +80,8 @@ static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &clockevent_gpt;
 
-	__omap_dm_timer_write_status(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
+	__omap_dm_timer_write_status(clkev.io_base, OMAP_TIMER_INT_OVERFLOW,
+				clkev.intr_offset, clkev.func_offset);
 
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
@@ -106,7 +107,8 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 {
 	u32 period;
 
-	__omap_dm_timer_stop(clkev.io_base, 1, clkev.rate);
+	__omap_dm_timer_stop(clkev.io_base, 1, clkev.rate, true,
+				clkev.intr_offset, clkev.func_offset);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -114,10 +116,10 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 		period -= 1;
 		/* Looks like we need to first set the load value separately */
 		__omap_dm_timer_write(clkev.io_base, OMAP_TIMER_LOAD_REG,
-					0xffffffff - period, 1);
+				0xffffffff - period, 1, clkev.func_offset);
 		__omap_dm_timer_load_start(clkev.io_base,
-					OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
-						0xffffffff - period, 1);
+				OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
+				0xffffffff - period, 1, clkev.func_offset);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		break;
@@ -173,6 +175,11 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		return -ENODEV;
 	}
 
+	if (oh->class->rev == OMAP_TIMER_IP_VERSION_2) {
+		timer->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
+		timer->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
+	}
+
 	omap_hwmod_enable(oh);
 
 	sys_timer_reserved |= (1 << (gptimer_id - 1));
@@ -191,7 +198,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 			clk_put(src);
 		}
 	}
-	__omap_dm_timer_reset(timer->io_base, 1, 1);
+	__omap_dm_timer_reset(timer->io_base, 1, 1, timer->func_offset);
 	timer->posted = 1;
 
 	timer->rate = clk_get_rate(timer->fclk);
@@ -212,7 +219,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	omap2_gp_timer_irq.dev_id = (void *)&clkev;
 	setup_irq(clkev.irq, &omap2_gp_timer_irq);
 
-	__omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
+	__omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_INT_OVERFLOW,
+					clkev.intr_offset, clkev.func_offset);
 
 	clockevent_gpt.mult = div_sc(clkev.rate, NSEC_PER_SEC,
 				     clockevent_gpt.shift);
@@ -253,7 +261,8 @@ static struct omap_dm_timer clksrc;
 static DEFINE_CLOCK_DATA(cd);
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
-	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
+	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1,
+						clksrc.func_offset);
 }
 
 static struct clocksource clocksource_gpt = {
@@ -268,7 +277,8 @@ static void notrace dmtimer_update_sched_clock(void)
 {
 	u32 cyc;
 
-	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
+	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1,
+						clksrc.func_offset);
 
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
@@ -278,7 +288,8 @@ unsigned long long notrace sched_clock(void)
 	u32 cyc = 0;
 
 	if (clksrc.reserved)
-		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
+		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1,
+							clksrc.func_offset);
 
 	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
@@ -296,7 +307,8 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 		gptimer_id, clksrc.rate);
 
 	__omap_dm_timer_load_start(clksrc.io_base,
-			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
+			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1,
+						clksrc.func_offset);
 	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
@@ -477,3 +489,23 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 
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
index 7cee4fb..854e735 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -36,136 +36,54 @@
  */
 
 #include <linux/io.h>
-#include <linux/module.h>
 #include <linux/slab.h>
-#include <mach/hardware.h>
-#include <plat/dmtimer.h>
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
+#include <linux/err.h>
 
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
+#include <plat/dmtimer.h>
 
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
@@ -184,53 +102,65 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
-	int autoidle = 0, wakeup = 0;
-
-	if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
+	if (timer->pdev->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
-	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
-	/* Enable autoidle on OMAP2+ */
-	if (cpu_class_is_omap2())
-		autoidle = 1;
-
-	/*
-	 * Enable wake-up on OMAP2 CPUs.
-	 */
-	if (cpu_class_is_omap2())
-		wakeup = 1;
-
-	__omap_dm_timer_reset(timer->io_base, autoidle, wakeup);
+	__omap_dm_timer_reset(timer->io_base, 0, 0, timer->func_offset);
 	timer->posted = 1;
 }
 
-void omap_dm_timer_prepare(struct omap_dm_timer *timer)
+int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	int ret;
+
+	timer->fclk = clk_get(&timer->pdev->dev, "fck");
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+		timer->fclk = NULL;
+		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
+		return -EINVAL;
+	}
+
 	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
+
+	if (pdata->needs_manual_reset)
+		omap_dm_timer_reset(timer);
+
+	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+
+	timer->posted = 1;
+	return ret;
 }
 
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
-	struct omap_dm_timer *timer = NULL;
+	struct omap_dm_timer *timer = NULL, *t;
 	unsigned long flags;
-	int i;
+	int ret = 0;
 
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
-		omap_dm_timer_prepare(timer);
+	if (timer) {
+		ret = omap_dm_timer_prepare(timer);
+		if (ret) {
+			timer->reserved = 0;
+			timer = NULL;
+		}
+	}
+
+	if (!timer)
+		pr_debug("%s: timer request failed!\n", __func__);
 
 	return timer;
 }
@@ -238,23 +168,30 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
-	struct omap_dm_timer *timer;
+	struct omap_dm_timer *timer = NULL, *t;
 	unsigned long flags;
+	int ret = 0;
 
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
+	if (timer) {
+		ret = omap_dm_timer_prepare(timer);
+		if (ret) {
+			timer->reserved = 0;
+			timer = NULL;
+		}
+	}
+
+	if (!timer)
+		pr_debug("%s: timer%d request failed!\n", __func__, id);
 
 	return timer;
 }
@@ -262,9 +199,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
 	omap_dm_timer_disable(timer);
+	clk_put(timer->fclk);
 
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
@@ -273,15 +209,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
+	if (!pdata->needs_manual_reset) {
 		clk_enable(timer->fclk);
 		clk_enable(timer->iclk);
 	}
-#endif
 
 	timer->enabled = 1;
 }
@@ -289,15 +225,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (!timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
+	if (!pdata->needs_manual_reset) {
 		clk_disable(timer->iclk);
 		clk_disable(timer->fclk);
 	}
-#endif
 
 	timer->enabled = 0;
 }
@@ -317,24 +253,29 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
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
@@ -379,26 +320,32 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 void omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
 	unsigned long rate = 0;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	bool is_omap2 = true;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	rate = clk_get_rate(timer->fclk);
-#endif
+	if (pdata->needs_manual_reset)
+		is_omap2 = false;
+	else
+		rate = clk_get_rate(timer->fclk);
 
-	__omap_dm_timer_stop(timer->io_base, timer->posted, rate);
+	__omap_dm_timer_stop(timer->io_base, timer->posted, rate,
+			is_omap2, timer->intr_offset, timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
+	int ret;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	return __omap_dm_timer_set_source(timer->fclk,
-						dm_source_clocks[source]);
-#else
-	return 0;
-#endif
+	omap_dm_timer_disable(timer);
+	ret = pdata->set_timer_src(timer->pdev, source);
+	omap_dm_timer_enable(timer);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
@@ -434,7 +381,8 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	}
 	l |= OMAP_TIMER_CTRL_ST;
 
-	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted);
+	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted,
+							timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
@@ -487,7 +435,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
-	__omap_dm_timer_int_enable(timer->io_base, value);
+	__omap_dm_timer_int_enable(timer->io_base, value,
+					timer->intr_offset, timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
@@ -503,13 +452,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 
 void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
-	__omap_dm_timer_write_status(timer->io_base, value);
+	__omap_dm_timer_write_status(timer->io_base, value,
+					timer->intr_offset, timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	return __omap_dm_timer_read_counter(timer->io_base, timer->posted);
+	return __omap_dm_timer_read_counter(timer->io_base, timer->posted,
+						timer->func_offset);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
@@ -521,13 +472,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
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
 
@@ -674,66 +621,3 @@ MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
-
-static int __init omap_dm_timer_init(void)
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
index 46f6e7f..fc086ce 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -235,9 +235,7 @@ struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
 	int irq;
-#ifdef CONFIG_ARCH_OMAP2PLUS
 	struct clk *iclk, *fclk;
-#endif
 	void __iomem *io_base;
 	unsigned long rate;
 	unsigned reserved:1;
@@ -250,13 +248,14 @@ struct omap_dm_timer {
 };
 
 extern u32 sys_timer_reserved;
-void omap_dm_timer_prepare(struct omap_dm_timer *timer);
+int omap_dm_timer_prepare(struct omap_dm_timer *timer);
 
 static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
-						int posted)
+						int posted, u8 func_offset)
 {
 	if (posted)
-		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+		while (__raw_readl(base +
+			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff))
 				& (reg >> WPSHIFT))
 			cpu_relax();
 
@@ -264,10 +263,11 @@ static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
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
 
@@ -276,11 +276,11 @@ static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, u32 val,
 
 /* Assumes the source clock has been set by caller */
 static inline void __omap_dm_timer_reset(void __iomem *base, int autoidle,
-						int wakeup)
+						int wakeup, u8 func_offset)
 {
 	u32 l;
 
-	l = __omap_dm_timer_read(base, OMAP_TIMER_OCP_CFG_REG, 0);
+	l = __omap_dm_timer_read(base, OMAP_TIMER_OCP_CFG_REG, 0, func_offset);
 	l |= 0x02 << 3;  /* Set to smart-idle mode */
 	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
 
@@ -290,11 +290,11 @@ static inline void __omap_dm_timer_reset(void __iomem *base, int autoidle,
 	if (wakeup)
 		l |= 1 << 2;
 
-	__omap_dm_timer_write(base, OMAP_TIMER_OCP_CFG_REG, l, 0);
+	__omap_dm_timer_write(base, OMAP_TIMER_OCP_CFG_REG, l, 0, func_offset);
 
 	/* Match hardware reset default of posted mode */
-	__omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG,
-					OMAP_TIMER_CTRL_POSTED, 0);
+	__omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG + func_offset,
+					OMAP_TIMER_CTRL_POSTED, 0, func_offset);
 }
 
 static inline int __omap_dm_timer_set_source(struct clk *timer_fck,
@@ -316,54 +316,64 @@ static inline int __omap_dm_timer_set_source(struct clk *timer_fck,
 }
 
 static inline void __omap_dm_timer_stop(void __iomem *base, int posted,
-						unsigned long rate)
+	unsigned long rate, bool is_omap2, u8 intr_offset, u8 func_offset)
 {
 	u32 l;
 
-	l = __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG, posted);
+	l = __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG + func_offset,
+					posted, func_offset);
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &= ~0x1;
-		__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG, l, posted);
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG, posted);
-		/*
-		 * Wait for functional clock period x 3.5 to make sure that
-		 * timer is stopped
-		 */
-		udelay(3500000 / rate + 1);
-#endif
+		__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG + func_offset,
+					l, posted, func_offset);
+		if (is_omap2) {
+			/* Readback to make sure write has completed */
+			__omap_dm_timer_read(base,
+					OMAP_TIMER_CTRL_REG + func_offset,
+					posted, func_offset);
+			/*
+			 * Wait for functional clock period x 3.5 to make sure
+			 * timer is stopped
+			 */
+			udelay(3500000 / rate + 1);
+		}
 	}
 
 	/* Ack possibly pending interrupt */
-	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG,
-					OMAP_TIMER_INT_OVERFLOW, 0);
+	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG + intr_offset,
+				OMAP_TIMER_INT_OVERFLOW, 0, func_offset);
 }
 
 static inline void __omap_dm_timer_load_start(void __iomem *base, u32 ctrl,
-						unsigned int load, int posted)
+				unsigned int load, int posted, u8 func_offset)
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
+			unsigned int value, u8 intr_offset, u8 func_offset)
 {
-	__omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG, value, 0);
-	__omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+	__omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG + intr_offset,
+				value, 0, func_offset);
+	__omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG + func_offset,
+				value, 0, func_offset);
 }
 
 static inline unsigned int __omap_dm_timer_read_counter(void __iomem *base,
-							int posted)
+						int posted, u8 func_offset)
 {
-	return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_REG, posted);
+	return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_REG + func_offset,
+						posted, func_offset);
 }
 
 static inline void __omap_dm_timer_write_status(void __iomem *base,
-						unsigned int value)
+			unsigned int value, u8 intr_offset, u8 func_offset)
 {
-	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG, value, 0);
+	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG + intr_offset,
+				value, 0, func_offset);
 }
 
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.7.0.4
