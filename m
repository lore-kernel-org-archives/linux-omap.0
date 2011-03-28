From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/10] omap2+: Use dmtimer macros for clocksource
Date: Mon, 28 Mar 2011 15:21:47 -0700
Message-ID: <20110328222147.4046.76646.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20708 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab1C1WVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 18:21:49 -0400
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Use dmtimer macros for clocksource. As with the clockevent,
this allows us to initialize the rest of dmtimer code later on.

Note that eventually we will be initializing the timesource
from init_early so sched_clock will work properly for
CONFIG_PRINTK_TIME.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer-gp.c   |   60 +++++++++++++++++++++-----------------
 arch/arm/plat-omap/counter_32k.c |    2 +
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 5e8fa1e..afb9041 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -256,20 +256,22 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
  * sync counter.  See clocksource setup in plat-omap/counter_32k.c
  */
 
-static void __init omap2_gp_clocksource_init(void)
+static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
 {
 	omap_init_clocksource_32k();
 }
 
 #else
+
+static struct omap_dm_timer clksrc;
+
 /*
  * clocksource
  */
 static DEFINE_CLOCK_DATA(cd);
-static struct omap_dm_timer *gpt_clocksource;
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
-	return (cycle_t)omap_dm_timer_read_counter(gpt_clocksource);
+	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
 }
 
 static struct clocksource clocksource_gpt = {
@@ -284,35 +286,39 @@ static void notrace dmtimer_update_sched_clock(void)
 {
 	u32 cyc;
 
-	cyc = omap_dm_timer_read_counter(gpt_clocksource);
+	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
 
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
-/* Setup free-running counter for clocksource */
-static void __init omap2_gp_clocksource_init(void)
+unsigned long long notrace sched_clock(void)
 {
-	static struct omap_dm_timer *gpt;
-	u32 tick_rate;
-	static char err1[] __initdata = KERN_ERR
-		"%s: failed to request dm-timer\n";
-	static char err2[] __initdata = KERN_ERR
-		"%s: can't register clocksource!\n";
+	u32 cyc = 0;
 
-	gpt = omap_dm_timer_request();
-	if (!gpt)
-		printk(err1, clocksource_gpt.name);
-	gpt_clocksource = gpt;
+	if (clksrc.reserved)
+		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
 
-	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
-	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+/* Setup free-running counter for clocksource */
+static void __init omap2_gp_clocksource_init(int gptimer_id,
+						const char *fck_source)
+{
+	int res;
+
+	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
+	BUG_ON(res);
 
-	omap_dm_timer_set_load_start(gpt, 1, 0);
+	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
+		gptimer_id, clksrc.rate);
 
-	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, tick_rate);
+	omap_dm_timer_set_load_start(&clksrc, 1, 0);
+	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
 
-	if (clocksource_register_hz(&clocksource_gpt, tick_rate))
-		printk(err2, clocksource_gpt.name);
+	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
+		pr_err("Could not register clocksource %s\n",
+			clocksource_gpt.name);
 }
 #endif
 
@@ -320,7 +326,7 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap242x_timer_init(void)
 {
 	omap2_gp_clockevent_init(1, OMAP2_CLKEV_SOURCE);
-	omap2_gp_clocksource_init();
+	omap2_gp_clocksource_init(2, OMAP2_MPU_SOURCE);
 }
 
 struct sys_timer omap242x_timer = {
@@ -330,7 +336,7 @@ struct sys_timer omap242x_timer = {
 static void __init omap243x_timer_init(void)
 {
 	omap2_gp_clockevent_init(1, OMAP2_CLKEV_SOURCE);
-	omap2_gp_clocksource_init();
+	omap2_gp_clocksource_init(2, OMAP2_MPU_SOURCE);
 }
 
 struct sys_timer omap243x_timer = {
@@ -342,7 +348,7 @@ struct sys_timer omap243x_timer = {
 static void __init omap3_timer_init(void)
 {
 	omap2_gp_clockevent_init(1, OMAP3_CLKEV_SOURCE);
-	omap2_gp_clocksource_init();
+	omap2_gp_clocksource_init(2, OMAP3_MPU_SOURCE);
 }
 
 struct sys_timer omap3_timer = {
@@ -356,7 +362,7 @@ struct sys_timer omap3_timer = {
 static void __init omap3_beagle_timer_init(void)
 {
 	omap2_gp_clockevent_init(OMAP3_BEAGLE_TIMER, OMAP3_CLKEV_SOURCE);
-	omap2_gp_clocksource_init();
+	omap2_gp_clocksource_init(2, OMAP3_MPU_SOURCE);
 }
 
 struct sys_timer omap3_beagle_timer = {
@@ -372,7 +378,7 @@ static void __init omap4_timer_init(void)
 	BUG_ON(!twd_base);
 #endif
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
-	omap2_gp_clocksource_init();
+	omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE);
 }
 
 struct sys_timer omap4_timer = {
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index f7fed60..c13bc3d 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -126,7 +126,7 @@ static inline unsigned long long notrace _omap_32k_sched_clock(void)
 	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
 }
 
-#ifndef CONFIG_OMAP_MPU_TIMER
+#if defined(CONFIG_OMAP_32K_TIMER) && !defined(CONFIG_OMAP_MPU_TIMER)
 unsigned long long notrace sched_clock(void)
 {
 	return _omap_32k_sched_clock();

