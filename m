From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] omap2+: Reserve clocksource and timesource and
	initialize dmtimer later
Date: Mon, 28 Mar 2011 15:21:45 -0700
Message-ID: <20110328222145.4046.65802.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20517 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab1C1WVq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 18:21:46 -0400
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

There's no need to initialize the dmtimer framework early.
Just mark the clocksource and timesource as reserved, and
initialize dmtimer with an arch_initcall.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/timer32k.c            |    4 ----
 arch/arm/mach-omap2/timer-gp.c            |    9 ++++-----
 arch/arm/plat-omap/dmtimer.c              |    8 ++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 13d7b8f..96604a5 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -183,10 +183,6 @@ static __init void omap_init_32k_timer(void)
 bool __init omap_32k_timer_init(void)
 {
 	omap_init_clocksource_32k();
-
-#ifdef CONFIG_OMAP_DM_TIMER
-	omap_dm_timer_init();
-#endif
 	omap_init_32k_timer();
 
 	return true;
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 4b071fb..5e8fa1e 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -69,6 +69,8 @@
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
 
+u32 sys_timer_reserved;
+
 /* Clockevent code */
 
 static struct omap_dm_timer clkev;
@@ -190,6 +192,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	omap_hwmod_enable(oh);
 
+	sys_timer_reserved |= (1 << (gptimer_id - 1));
+
 	if (gptimer_id != 12) {
 		struct clk *src;
 
@@ -315,7 +319,6 @@ static void __init omap2_gp_clocksource_init(void)
 #ifdef CONFIG_ARCH_OMAP2
 static void __init omap242x_timer_init(void)
 {
-	omap_dm_timer_init();
 	omap2_gp_clockevent_init(1, OMAP2_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
@@ -326,7 +329,6 @@ struct sys_timer omap242x_timer = {
 
 static void __init omap243x_timer_init(void)
 {
-	omap_dm_timer_init();
 	omap2_gp_clockevent_init(1, OMAP2_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
@@ -339,7 +341,6 @@ struct sys_timer omap243x_timer = {
 #ifdef CONFIG_ARCH_OMAP3
 static void __init omap3_timer_init(void)
 {
-	omap_dm_timer_init();
 	omap2_gp_clockevent_init(1, OMAP3_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
@@ -354,7 +355,6 @@ struct sys_timer omap3_timer = {
  */
 static void __init omap3_beagle_timer_init(void)
 {
-	omap_dm_timer_init();
 	omap2_gp_clockevent_init(OMAP3_BEAGLE_TIMER, OMAP3_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
@@ -371,7 +371,6 @@ static void __init omap4_timer_init(void)
 	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
 	BUG_ON(!twd_base);
 #endif
-	omap_dm_timer_init();
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index ff9b732..5163cf4 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -677,8 +677,16 @@ int __init omap_dm_timer_init(void)
 			sprintf(clk_name, "gpt%d_fck", i + 1);
 			timer->fclk = clk_get(NULL, clk_name);
 		}
+
+		/* One or two timers may be set up early for sys_timer */
+		if (sys_timer_reserved & (1  << i)) {
+			timer->reserved = 1;
+			timer->posted = 1;
+		}
 #endif
 	}
 
 	return 0;
 }
+
+arch_initcall(omap_dm_timer_init);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 5e68974..97bc306 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -219,6 +219,7 @@ struct omap_dm_timer {
 	unsigned posted:1;
 };
 
+extern u32 sys_timer_reserved;
 void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
 				int wakeup);
 void omap_dm_timer_prepare(struct omap_dm_timer *timer);

