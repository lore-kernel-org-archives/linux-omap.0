From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] omap2+: Reserve clocksource and timesource and
	initialize dmtimer later
Date: Mon, 20 Jun 2011 02:23:43 -0700
Message-ID: <20110620092343.357.60445.stgit@kaulin>
References: <20110620091754.357.56441.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54542 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753057Ab1FTJXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 05:23:45 -0400
In-Reply-To: <20110620091754.357.56441.stgit@kaulin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

There's no need to initialize the dmtimer framework early.
Just mark the clocksource and timesource as reserved, and
initialize dmtimer with an arch_initcall.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/timer32k.c            |    4 ----
 arch/arm/mach-omap2/timer-gp.c            |    6 ++++--
 arch/arm/plat-omap/dmtimer.c              |    8 ++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
 4 files changed, 13 insertions(+), 6 deletions(-)

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
index 578e9df..cf2ec85 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -69,6 +69,8 @@
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
 
+u32 sys_timer_reserved;
+
 /* Clockevent code */
 
 static struct omap_dm_timer clkev;
@@ -195,6 +197,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	omap_hwmod_enable(oh);
 
+	sys_timer_reserved |= (1 << (gptimer_id - 1));
+
 	if (gptimer_id != 12) {
 		struct clk *src;
 
@@ -321,7 +325,6 @@ static void __init omap2_gp_clocksource_init(void)
 #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src)			\
 static void __init omap##name##_timer_init(void)			\
 {									\
-	omap_dm_timer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src);		\
 	omap2_gp_clocksource_init();					\
 }
@@ -350,7 +353,6 @@ static void __init omap4_timer_init(void)
 	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
 	BUG_ON(!twd_base);
 #endif
-	omap_dm_timer_init();
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7c5cb4e..1462784 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -625,8 +625,16 @@ int __init omap_dm_timer_init(void)
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
index dd8b3ff..f6dc77a 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -222,6 +222,7 @@ struct omap_dm_timer {
 	unsigned posted:1;
 };
 
+extern u32 sys_timer_reserved;
 void omap_dm_timer_prepare(struct omap_dm_timer *timer);
 
 static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,

