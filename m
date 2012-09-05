From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 08/10] ARM: OMAP: Clean-up timer posted mode support
Date: Wed, 5 Sep 2012 14:04:30 -0500
Message-ID: <1346871872-24413-9-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48584 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759005Ab2IETFA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 15:05:00 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The dmtimer functions to read and write the dmtimer registers are currently
defined as follows ...

static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
						int posted);
static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
						u32 reg, u32 val, int posted);

The posted variable indicates if the timer is configured to use the posted mode
when performing register accesses. The posted mode configuration of the dmtimer
is stored in the omap_dm_timer structure that is also being passed to the above
functions and therefore we do not need to pass the posted variable separately.
Therefore, simplify the above functions by removing the posted variable as an
argument as this is not necessary.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   14 +++++------
 arch/arm/plat-omap/dmtimer.c              |   10 ++++----
 arch/arm/plat-omap/include/plat/dmtimer.h |   37 +++++++++++++----------------
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1ee67a3..43da595 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -94,7 +94,7 @@ static int omap2_gp_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
 	__omap_dm_timer_load_start(&clkev, OMAP_TIMER_CTRL_ST,
-						0xffffffff - cycles, 1);
+						0xffffffff - cycles);
 
 	return 0;
 }
@@ -104,7 +104,7 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 {
 	u32 period;
 
-	__omap_dm_timer_stop(&clkev, 1, clkev.rate);
+	__omap_dm_timer_stop(&clkev, clkev.rate);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -112,10 +112,10 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 		period -= 1;
 		/* Looks like we need to first set the load value separately */
 		__omap_dm_timer_write(&clkev, OMAP_TIMER_LOAD_REG,
-					0xffffffff - period, 1);
+					0xffffffff - period);
 		__omap_dm_timer_load_start(&clkev,
 					OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
-						0xffffffff - period, 1);
+						0xffffffff - period);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		break;
@@ -246,7 +246,7 @@ static bool use_gptimer_clksrc;
  */
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
-	return (cycle_t)__omap_dm_timer_read_counter(&clksrc, 1);
+	return (cycle_t)__omap_dm_timer_read_counter(&clksrc);
 }
 
 static struct clocksource clocksource_gpt = {
@@ -260,7 +260,7 @@ static struct clocksource clocksource_gpt = {
 static u32 notrace dmtimer_read_sched_clock(void)
 {
 	if (clksrc.reserved)
-		return __omap_dm_timer_read_counter(&clksrc, 1);
+		return __omap_dm_timer_read_counter(&clksrc);
 
 	return 0;
 }
@@ -316,7 +316,7 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 	BUG_ON(res);
 
 	__omap_dm_timer_load_start(&clksrc,
-			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
+			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0);
 	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1eb7353..541adbb 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -63,7 +63,7 @@ static DEFINE_SPINLOCK(dm_timer_lock);
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
 	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
-	return __omap_dm_timer_read(timer, reg, timer->posted);
+	return __omap_dm_timer_read(timer, reg);
 }
 
 /**
@@ -80,7 +80,7 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 						u32 value)
 {
 	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
-	__omap_dm_timer_write(timer, reg, value, timer->posted);
+	__omap_dm_timer_write(timer, reg, value);
 }
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
@@ -377,7 +377,7 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET))
 		rate = clk_get_rate(timer->fclk);
 
-	__omap_dm_timer_stop(timer, timer->posted, rate);
+	__omap_dm_timer_stop(timer, rate);
 
 	if (!(timer->capability & OMAP_TIMER_ALWON))
 		timer->ctx_loss_count =
@@ -511,7 +511,7 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	}
 	l |= OMAP_TIMER_CTRL_ST;
 
-	__omap_dm_timer_load_start(timer, l, load, timer->posted);
+	__omap_dm_timer_load_start(timer, l, load);
 
 	/* Save the context */
 	timer->context.tclr = l;
@@ -646,7 +646,7 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 		return 0;
 	}
 
-	return __omap_dm_timer_read_counter(timer, timer->posted);
+	return __omap_dm_timer_read_counter(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 6488a19..b3150a3 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -283,20 +283,19 @@ struct omap_dm_timer {
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer);
 
-static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
-						int posted)
+static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg)
 {
-	if (posted)
+	if (timer->posted)
 		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
 			cpu_relax();
 
 	return __raw_readl(timer->func_base + (reg & 0xff));
 }
 
-static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
-					u32 reg, u32 val, int posted)
+static inline void
+__omap_dm_timer_write(struct omap_dm_timer *timer, u32 reg, u32 val)
 {
-	if (posted)
+	if (timer->posted)
 		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
 			cpu_relax();
 
@@ -340,7 +339,7 @@ static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
 		return;
 
 	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
-					OMAP_TIMER_CTRL_POSTED, 0);
+					OMAP_TIMER_CTRL_POSTED);
 	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
 	timer->posted = 1;
 }
@@ -387,18 +386,18 @@ static inline int __omap_dm_timer_set_source(struct clk *timer_fck,
 	return ret;
 }
 
-static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
-					int posted, unsigned long rate)
+static inline void
+__omap_dm_timer_stop(struct omap_dm_timer *timer, unsigned long rate)
 {
 	u32 l;
 
-	l = __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+	l = __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &= ~0x1;
-		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
+		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l);
 #ifdef CONFIG_ARCH_OMAP2PLUS
 		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG);
 		/*
 		 * Wait for functional clock period x 3.5 to make sure that
 		 * timer is stopped
@@ -412,24 +411,22 @@ static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
 }
 
 static inline void __omap_dm_timer_load_start(struct omap_dm_timer *timer,
-						u32 ctrl, unsigned int load,
-						int posted)
+						u32 ctrl, unsigned int load)
 {
-	__omap_dm_timer_write(timer, OMAP_TIMER_COUNTER_REG, load, posted);
-	__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, ctrl, posted);
+	__omap_dm_timer_write(timer, OMAP_TIMER_COUNTER_REG, load);
+	__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, ctrl);
 }
 
 static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
 						unsigned int value)
 {
 	__raw_writel(value, timer->irq_ena);
-	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
 
-static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
+static inline u32 __omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
+	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG);
 }
 
 static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
-- 
1.7.9.5

