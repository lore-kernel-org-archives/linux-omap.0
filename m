From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 1/7] ARM: OMAP2+: Display correct system timer name
Date: Mon, 4 Feb 2013 13:46:30 -0600
Message-ID: <1360007196-21350-2-git-send-email-jon-hunter@ti.com>
References: <1360007196-21350-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56543 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805Ab3BDTrE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 14:47:04 -0500
In-Reply-To: <1360007196-21350-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Jon Hunter <jon-hunter@ti.com>

Currently on boot, when displaying the name of the gptimer used for
clockevents and clocksource timers, the timer ID is shown. However,
when booting with device-tree, the timer ID is not used to select a
gptimer but a timer property. Hence, it is possible that the timer
selected when booting with device-tree does not match the ID shown.
Therefore, instead display the HWMOD name of the gptimer and use
the HWMOD name as the name of clockevent and clocksource timer (if a
gptimer is used).

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 72c2ca1..83118fb 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -129,7 +129,6 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 }
 
 static struct clock_event_device clockevent_gpt = {
-	.name		= "gp_timer",
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 300,
 	.set_next_event	= omap2_gp_timer_set_next_event,
@@ -214,10 +213,11 @@ static u32 __init omap_dm_timer_get_errata(void)
 }
 
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
-						int gptimer_id,
-						const char *fck_source,
-						const char *property,
-						int posted)
+					 int gptimer_id,
+					 const char *fck_source,
+					 const char *property,
+					 const char **timer_name,
+					 int posted)
 {
 	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
 	const char *oh_name;
@@ -254,6 +254,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (!oh)
 		return -ENODEV;
 
+	*timer_name = oh->name;
+
 	if (!of_have_populated_dt()) {
 		r = omap_hwmod_get_resource_byname(oh, IORESOURCE_IRQ, NULL,
 						   &irq);
@@ -327,7 +329,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	__omap_dm_timer_override_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
 
 	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property,
-				     OMAP_TIMER_POSTED);
+				     &clockevent_gpt.name, OMAP_TIMER_POSTED);
 	BUG_ON(res);
 
 	omap2_gp_timer_irq.dev_id = &clkev;
@@ -341,8 +343,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 					3, /* Timer internal resynch latency */
 					0xffffffff);
 
-	pr_info("OMAP clockevent source: GPTIMER%d at %lu Hz\n",
-		gptimer_id, clkev.rate);
+	pr_info("OMAP clockevent source: %s at %lu Hz\n", clockevent_gpt.name,
+		clkev.rate);
 }
 
 /* Clocksource code */
@@ -359,7 +361,6 @@ static cycle_t clocksource_read_cycles(struct clocksource *cs)
 }
 
 static struct clocksource clocksource_gpt = {
-	.name		= "gp_timer",
 	.rating		= 300,
 	.read		= clocksource_read_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
@@ -449,6 +450,7 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 	clksrc.errata = omap_dm_timer_get_errata();
 
 	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL,
+				     &clocksource_gpt.name,
 				     OMAP_TIMER_NONPOSTED);
 	BUG_ON(res);
 
@@ -461,8 +463,8 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 		pr_err("Could not register clocksource %s\n",
 			clocksource_gpt.name);
 	else
-		pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
-			gptimer_id, clksrc.rate);
+		pr_info("OMAP clocksource: %s at %lu Hz\n",
+			clocksource_gpt.name, clksrc.rate);
 }
 
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
-- 
1.7.10.4

