From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: hrtimers/dyntick support for OMAP2 GP-timers
Date: Thu, 10 May 2007 17:30:36 -0700
Message-ID: <20070511003036.203942772@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch converts the GP-timer layer to use the
clocksource/clockevent interface provided by the new GENERIC_TIME and
GENERIC_CLOCKEVENT layers.

Doing so enables use of the new hrtimers and dynticks features on
OMAP2.

A quick test of hrtimers using Thomas Gleixner's cyclictest on a
2430SDP shows min/avg/max userspace latencies of 38/50/850 usec.

A quick test of dyntick using /proc/timer_stats on an idle system
shows an avg. of ~5 events/sec over a 10 second period.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/Kconfig               |    1 
 arch/arm/mach-omap2/timer-gp.c |  139 +++++++++++++++++++++++++++++++++++------
 arch/arm/plat-omap/Kconfig     |    3 
 3 files changed, 122 insertions(+), 21 deletions(-)

Index: dev/arch/arm/Kconfig
===================================================================
--- dev.orig/arch/arm/Kconfig
+++ dev/arch/arm/Kconfig
@@ -381,6 +381,7 @@ config ARCH_OMAP
 	bool "TI OMAP"
 	select GENERIC_GPIO
 	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
Index: dev/arch/arm/mach-omap2/timer-gp.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/timer-gp.c
+++ dev/arch/arm/mach-omap2/timer-gp.c
@@ -3,6 +3,11 @@
  *
  * OMAP2 GP timer support.
  *
+ * Update to use new clocksource/clockevent layers
+ * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
+ * Copyright (C) 2007 MontaVista Software, Inc.
+ *
+ * Original driver:
  * Copyright (C) 2005 Nokia Corporation
  * Author: Paul Mundt <paul.mundt@nokia.com>
  *         Juha Yrjölä <juha.yrjola@nokia.com>
@@ -25,28 +30,23 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/mach/time.h>
 #include <asm/arch/dmtimer.h>
 
 static struct omap_dm_timer *gptimer;
-
-static inline void omap2_gp_timer_start(unsigned long load_val)
-{
-	omap_dm_timer_set_load(gptimer, 1, 0xffffffff - load_val);
-	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
-	omap_dm_timer_start(gptimer);
-}
+static struct clock_event_device clockevent_gpt;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
+	struct omap_dm_timer *gpt = (struct omap_dm_timer *)dev_id;
+	struct clock_event_device *evt = &clockevent_gpt;
 
-	omap_dm_timer_write_status(gptimer, OMAP_TIMER_INT_OVERFLOW);
-	timer_tick();
-
-	write_sequnlock(&xtime_lock);
+	omap_dm_timer_write_status(gpt, OMAP_TIMER_INT_OVERFLOW);
 
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
@@ -56,20 +56,123 @@ static struct irqaction omap2_gp_timer_i
 	.handler	= omap2_gp_timer_interrupt,
 };
 
-static void __init omap2_gp_timer_init(void)
+static int omap2_gp_timer_set_next_event(unsigned long cycles,
+					 struct clock_event_device *evt)
 {
-	u32 tick_period;
+	omap_dm_timer_set_load(gptimer, 0, 0xffffffff - cycles);
+	omap_dm_timer_start(gptimer);
+
+	return 0;
+}
+
+static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
+				    struct clock_event_device *evt)
+{
+	u32 period;
+
+	omap_dm_timer_stop(gptimer);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
+		period -= 1;
+
+		omap_dm_timer_set_load(gptimer, 1, 0xffffffff - period);
+		omap_dm_timer_start(gptimer);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_gpt = {
+	.name		= "gp timer",
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.shift		= 32,
+	.set_next_event	= omap2_gp_timer_set_next_event,
+	.set_mode	= omap2_gp_timer_set_mode,
+};
+
+static void __init omap2_gp_clockevent_init(void)
+{
+	u32 tick_rate;
 
-	omap_dm_timer_init();
 	gptimer = omap_dm_timer_request_specific(1);
 	BUG_ON(gptimer == NULL);
 
 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
-	tick_period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
-	tick_period -= 1;
+	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
 
+	omap2_gp_timer_irq.dev_id = (void *)gptimer;
 	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
-	omap2_gp_timer_start(tick_period);
+	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
+
+	clockevent_gpt.mult = div_sc(tick_rate, NSEC_PER_SEC,
+				     clockevent_gpt.shift);
+	clockevent_gpt.max_delta_ns =
+		clockevent_delta2ns(0xffffffff, &clockevent_gpt);
+	clockevent_gpt.min_delta_ns =
+		clockevent_delta2ns(1, &clockevent_gpt);
+
+	clockevent_gpt.cpumask = cpumask_of_cpu(0);
+	clockevents_register_device(&clockevent_gpt);
+}
+
+/*
+ * clocksource
+ */
+static struct omap_dm_timer *gpt_clocksource;
+static cycle_t clocksource_read_cycles(void)
+{
+	return (cycle_t)omap_dm_timer_read_counter(gpt_clocksource);
+}
+
+static struct clocksource clocksource_gpt = {
+	.name		= "gp timer",
+	.rating		= 300,
+	.read		= clocksource_read_cycles,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 24,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+/* Setup free-running counter for clocksource */
+static void __init omap2_gp_clocksource_init(void)
+{
+	static struct omap_dm_timer *gpt;
+	u32 tick_rate, tick_period;
+	static char err1[] __initdata = KERN_ERR
+		"%s: failed to request dm-timer\n";
+	static char err2[] __initdata = KERN_ERR
+		"%s: can't register clocksource!\n";
+
+	gpt = omap_dm_timer_request();
+	if (!gpt)
+		printk(err1, clocksource_gpt.name);
+	gpt_clocksource = gpt;
+
+	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
+	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
+	tick_period = (tick_rate / HZ) - 1;
+
+	omap_dm_timer_set_load(gpt, 1, 0);
+	omap_dm_timer_start(gpt);
+
+	clocksource_gpt.mult =
+		clocksource_khz2mult(tick_rate/1000, clocksource_gpt.shift);
+	if (clocksource_register(&clocksource_gpt))
+		printk(err2, clocksource_gpt.name);
+}
+
+static void __init omap2_gp_timer_init(void)
+{
+	omap_dm_timer_init();
+
+	omap2_gp_clockevent_init();
+	omap2_gp_clocksource_init();
 }
 
 struct sys_timer omap_timer = {
Index: dev/arch/arm/plat-omap/Kconfig
===================================================================
--- dev.orig/arch/arm/plat-omap/Kconfig
+++ dev/arch/arm/plat-omap/Kconfig
@@ -11,7 +11,6 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
-	select GENERIC_CLOCKEVENTS
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
@@ -150,8 +149,6 @@ config OMAP_MPU_TIMER
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
 	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
-	select GENERIC_TIME
-	select GENERIC_CLOCKEVENTS
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
--
