From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] omap2+: Use dmtimer macros for clockevent
Date: Mon, 28 Mar 2011 15:21:40 -0700
Message-ID: <20110328222140.4046.91213.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20415 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab1C1WVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 18:21:41 -0400
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This patch makes timer-gp.c to use only a subset of dmtimer
functions without the need to initialize dmtimer code early.

Note that omap_dmtimer_init_one can eventually be moved to
omap2+ specific dmtimer.c.

Also note that now with the inline functions, timer_set_next_event
becomes more efficient in the lines of assembly code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer-gp.c            |  145 ++++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 
 2 files changed, 111 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index b7ea047..c21e99f 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -45,10 +45,33 @@
 
 #include "timer-gp.h"
 
+/* Parent clocks, eventually these will come from the clock framework */
+
+#define OMAP2_MPU_SOURCE	"sys_ck"
+#define OMAP3_MPU_SOURCE	OMAP2_MPU_SOURCE
+#define OMAP4_MPU_SOURCE	"sys_clkin_ck"
+#define OMAP2_32K_SOURCE	"func_32k_ck"
+#define OMAP3_32K_SOURCE	"omap_32k_fck"
+#define OMAP4_32K_SOURCE	"sys_32k_ck"
+
+#ifdef CONFIG_OMAP_32K_TIMER
+#define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
+#define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
+#define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
+#define OMAP3_BEAGLE_TIMER	12
+#else
+#define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
+#define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
+#define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
+#define OMAP3_BEAGLE_TIMER	1
+#endif
 
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
 
+/* Clockevent code */
+
+static struct omap_dm_timer clkev;
 static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
 static u8 __initdata gptimer_id = 1;
@@ -57,10 +80,9 @@ struct omap_dm_timer *gptimer_wakeup;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
-	struct omap_dm_timer *gpt = (struct omap_dm_timer *)dev_id;
 	struct clock_event_device *evt = &clockevent_gpt;
 
-	omap_dm_timer_write_status(gpt, OMAP_TIMER_INT_OVERFLOW);
+	__omap_dm_timer_write_status(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
 
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
@@ -75,7 +97,8 @@ static struct irqaction omap2_gp_timer_irq = {
 static int omap2_gp_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
-	omap_dm_timer_set_load_start(gptimer, 0, 0xffffffff - cycles);
+	__omap_dm_timer_load_start(clkev.io_base, OMAP_TIMER_CTRL_ST,
+						0xffffffff - cycles, 1);
 
 	return 0;
 }
@@ -85,13 +108,13 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 {
 	u32 period;
 
-	omap_dm_timer_stop(gptimer);
+	omap_dm_timer_stop(&clkev);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
+		period = clkev.rate / HZ;
 		period -= 1;
-		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
+		omap_dm_timer_set_load_start(&clkev, 1, 0xffffffff - period);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		break;
@@ -130,43 +153,88 @@ int __init omap2_gp_clockevent_set_gptimer(u8 id)
 	return 0;
 }
 
-static void __init omap2_gp_clockevent_init(void)
+static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
+						int gptimer_id,
+						const char *fck_source)
 {
-	u32 tick_rate;
-	int src;
-	char clockevent_hwmod_name[8]; /* 8 = sizeof("timerXX0") */
-
-	inited = 1;
+	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
+	struct omap_hwmod *oh;
+	size_t size;
+	int res = 0;
+
+	sprintf(name, "timer%d", gptimer_id);
+	omap_hwmod_setup_one(name);
+	oh = omap_hwmod_lookup(name);
+	if (!oh)
+		return -ENODEV;
+
+	timer->irq = oh->mpu_irqs[0].irq;
+	timer->phys_base = oh->slaves[0]->addr->pa_start;
+	size = oh->slaves[0]->addr->pa_end - timer->phys_base;
+
+	/* Static mapping, never released */
+	timer->io_base = ioremap(timer->phys_base, size);
+	if (!timer->io_base)
+		return -ENXIO;
+
+	/* After the dmtimer is using hwmod these clocks won't be needed */
+	sprintf(name, "gpt%d_fck", gptimer_id);
+	timer->fclk = clk_get(NULL, name);
+	if (IS_ERR(timer->fclk))
+		return -ENODEV;
+
+	sprintf(name, "gpt%d_ick", gptimer_id);
+	timer->iclk = clk_get(NULL, name);
+	if (IS_ERR(timer->iclk)) {
+		clk_put(timer->fclk);
+		return -ENODEV;
+	}
 
-	sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
-	omap_hwmod_setup_one(clockevent_hwmod_name);
+	omap_hwmod_enable(oh);
 
 	gptimer = omap_dm_timer_request_specific(gptimer_id);
 	BUG_ON(gptimer == NULL);
 	gptimer_wakeup = gptimer;
 
-#if defined(CONFIG_OMAP_32K_TIMER)
-	src = OMAP_TIMER_SRC_32_KHZ;
-#else
-	src = OMAP_TIMER_SRC_SYS_CLK;
-	WARN(gptimer_id == 12, "WARNING: GPTIMER12 can only use the "
-	     "secure 32KiHz clock source\n");
-#endif
+	if (gptimer_id != 12) {
+		struct clk *src;
+
+		src = clk_get(NULL, fck_source);
+		if (IS_ERR(src)) {
+			res = -EINVAL;
+		} else {
+			res = __omap_dm_timer_set_source(timer->fclk, src);
+			if (IS_ERR_VALUE(res))
+				pr_warning("%s: timer%i cannot set source\n",
+						__func__, gptimer_id);
+			clk_put(src);
+		}
+	}
+	__omap_dm_timer_reset(timer, 1, 1);
+
+	timer->rate = clk_get_rate(timer->fclk);
+
+	timer->reserved = 1;
 
-	if (gptimer_id != 12)
-		WARN(IS_ERR_VALUE(omap_dm_timer_set_source(gptimer, src)),
-		     "timer-gp: omap_dm_timer_set_source() failed\n");
+	return res;
+}
 
-	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
+static void __init omap2_gp_clockevent_init(int gptimer_id,
+						const char *fck_source)
+{
+	int res;
 
-	pr_info("OMAP clockevent source: GPTIMER%d at %u Hz\n",
-		gptimer_id, tick_rate);
+	inited = 1;
+
+	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source);
+	BUG_ON(res);
 
 	omap2_gp_timer_irq.dev_id = (void *)gptimer;
-	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
-	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
+	setup_irq(clkev.irq, &omap2_gp_timer_irq);
+
+	__omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
 
-	clockevent_gpt.mult = div_sc(tick_rate, NSEC_PER_SEC,
+	clockevent_gpt.mult = div_sc(clkev.rate, NSEC_PER_SEC,
 				     clockevent_gpt.shift);
 	clockevent_gpt.max_delta_ns =
 		clockevent_delta2ns(0xffffffff, &clockevent_gpt);
@@ -176,6 +244,9 @@ static void __init omap2_gp_clockevent_init(void)
 
 	clockevent_gpt.cpumask = cpumask_of(0);
 	clockevents_register_device(&clockevent_gpt);
+
+	pr_info("OMAP clockevent source: GPTIMER%d at %lu Hz\n",
+		gptimer_id, clkev.rate);
 }
 
 /* Clocksource code */
@@ -251,7 +322,7 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap242x_timer_init(void)
 {
 	omap_dm_timer_init();
-	omap2_gp_clockevent_init();
+	omap2_gp_clockevent_init(1, OMAP2_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
 
@@ -262,7 +333,7 @@ struct sys_timer omap242x_timer = {
 static void __init omap243x_timer_init(void)
 {
 	omap_dm_timer_init();
-	omap2_gp_clockevent_init();
+	omap2_gp_clockevent_init(1, OMAP2_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
 
@@ -275,7 +346,7 @@ struct sys_timer omap243x_timer = {
 static void __init omap3_timer_init(void)
 {
 	omap_dm_timer_init();
-	omap2_gp_clockevent_init();
+	omap2_gp_clockevent_init(1, OMAP3_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
 
@@ -283,10 +354,14 @@ struct sys_timer omap3_timer = {
 	.init	= omap3_timer_init,
 };
 
+/*
+ * Beagle based designs typically have an issue with gptimer1. Also note
+ * that GPTIMER12 can only use the secure 32KiHz clock source.
+ */
 static void __init omap3_beagle_timer_init(void)
 {
 	omap_dm_timer_init();
-	omap2_gp_clockevent_init();
+	omap2_gp_clockevent_init(OMAP3_BEAGLE_TIMER, OMAP3_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
 
@@ -303,7 +378,7 @@ static void __init omap4_timer_init(void)
 	BUG_ON(!twd_base);
 #endif
 	omap_dm_timer_init();
-	omap2_gp_clockevent_init();
+	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 21ad28c..5e68974 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -213,6 +213,7 @@ struct omap_dm_timer {
 	struct clk *iclk, *fclk;
 #endif
 	void __iomem *io_base;
+	unsigned long rate;
 	unsigned reserved:1;
 	unsigned enabled:1;
 	unsigned posted:1;

