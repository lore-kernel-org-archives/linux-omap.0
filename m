From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/5] ARM: OMAP2+: Display correct system timer name
Date: Wed, 30 Jan 2013 11:04:27 -0600
Message-ID: <1359565471-30721-2-git-send-email-jon-hunter@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52652 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756017Ab3A3REm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 12:04:42 -0500
In-Reply-To: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently on boot, when displaying the name of the gptimer used for
clockevents and clocksource timers, the timer ID is shown. However,
when booting with device-tree, the timer ID is not used to select a
gptimer but a timer property. Hence, it is possible that the timer
selected when booting with device-tree does not match the ID shown.
Therefore, instead display the HWMOD name of the gptimer and use
the HWMOD name as the name of clockevent and clocksource timer (if a
gptimer is used).

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |   44 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 72c2ca1..18cb856 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -71,6 +71,9 @@
 #define INCREMENTER_DENUMERATOR_RELOAD_OFFSET		0x14
 #define NUMERATOR_DENUMERATOR_MASK			0xfffff000
 
+/* Timer name needs to be big enough to store a string of "timerXX" */
+static char timer_name[10];
+
 /* Clockevent code */
 
 static struct omap_dm_timer clkev;
@@ -129,7 +132,6 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 }
 
 static struct clock_event_device clockevent_gpt = {
-	.name		= "gp_timer",
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 300,
 	.set_next_event	= omap2_gp_timer_set_next_event,
@@ -214,13 +216,12 @@ static u32 __init omap_dm_timer_get_errata(void)
 }
 
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
-						int gptimer_id,
-						const char *fck_source,
-						const char *property,
-						int posted)
+					 int gptimer_id,
+					 const char **name,
+					 const char *fck_source,
+					 const char *property,
+					 int posted)
 {
-	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
-	const char *oh_name;
 	struct device_node *np;
 	struct omap_hwmod *oh;
 	struct resource irq, mem;
@@ -231,8 +232,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (!np)
 			return -ENODEV;
 
-		of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
-		if (!oh_name)
+		of_property_read_string_index(np, "ti,hwmods", 0, name);
+		if (!name)
 			return -ENODEV;
 
 		timer->irq = irq_of_parse_and_map(np, 0);
@@ -246,11 +247,11 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (omap_dm_timer_reserve_systimer(gptimer_id))
 			return -ENODEV;
 
-		sprintf(name, "timer%d", gptimer_id);
-		oh_name = name;
+		sprintf(timer_name, "timer%d", gptimer_id);
+		*name = timer_name;
 	}
 
-	oh = omap_hwmod_lookup(oh_name);
+	oh = omap_hwmod_lookup(*name);
 	if (!oh)
 		return -ENODEV;
 
@@ -294,7 +295,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		}
 	}
 
-	omap_hwmod_setup_one(oh_name);
+	omap_hwmod_setup_one(*name);
 	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
 
@@ -326,8 +327,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	 */
 	__omap_dm_timer_override_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
 
-	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property,
-				     OMAP_TIMER_POSTED);
+	res = omap_dm_timer_init_one(&clkev, gptimer_id, &clockevent_gpt.name,
+				     fck_source, property, OMAP_TIMER_POSTED);
 	BUG_ON(res);
 
 	omap2_gp_timer_irq.dev_id = &clkev;
@@ -341,8 +342,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 					3, /* Timer internal resynch latency */
 					0xffffffff);
 
-	pr_info("OMAP clockevent source: GPTIMER%d at %lu Hz\n",
-		gptimer_id, clkev.rate);
+	pr_info("OMAP clockevent source: %s at %lu Hz\n", clockevent_gpt.name,
+		clkev.rate);
 }
 
 /* Clocksource code */
@@ -359,7 +360,6 @@ static cycle_t clocksource_read_cycles(struct clocksource *cs)
 }
 
 static struct clocksource clocksource_gpt = {
-	.name		= "gp_timer",
 	.rating		= 300,
 	.read		= clocksource_read_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
@@ -448,8 +448,8 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 
 	clksrc.errata = omap_dm_timer_get_errata();
 
-	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL,
-				     OMAP_TIMER_NONPOSTED);
+	res = omap_dm_timer_init_one(&clksrc, gptimer_id, &clocksource_gpt.name,
+				     fck_source, NULL, OMAP_TIMER_NONPOSTED);
 	BUG_ON(res);
 
 	__omap_dm_timer_load_start(&clksrc,
@@ -461,8 +461,8 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
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

