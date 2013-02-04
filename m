From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 6/7] ARM: OMAP2+: Store ID of system timers in timer structure
Date: Mon, 4 Feb 2013 11:43:05 -0600
Message-ID: <1359999786-8740-7-git-send-email-jon-hunter@ti.com>
References: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49829 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab3BDRnU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 12:43:20 -0500
In-Reply-To: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Jon Hunter <jon-hunter@ti.com>

Currently, the timer ID is being passed to the function
omap_dm_timer_init_one(). Instead of passing the ID separately, store it
in the omap_dm_timer structure, that is also passed, and access the ID
from this structure.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1b99b41..c5770ff 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -210,7 +210,6 @@ static u32 __init omap_dm_timer_get_errata(void)
 }
 
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
-					 int gptimer_id,
 					 const char *fck_source,
 					 const char *property,
 					 const char **timer_name,
@@ -241,10 +240,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 		of_node_put(np);
 	} else {
-		if (omap_dm_timer_reserve_systimer(gptimer_id))
+		if (omap_dm_timer_reserve_systimer(timer->id))
 			return -ENODEV;
 
-		sprintf(name, "timer%d", gptimer_id);
+		sprintf(name, "timer%d", timer->id);
 		oh_name = name;
 	}
 
@@ -317,6 +316,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 {
 	int res;
 
+	clkev.id = gptimer_id;
 	clkev.errata = omap_dm_timer_get_errata();
 
 	/*
@@ -326,7 +326,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	 */
 	__omap_dm_timer_override_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
 
-	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property,
+	res = omap_dm_timer_init_one(&clkev, fck_source, property,
 				     &clockevent_gpt.name, OMAP_TIMER_POSTED);
 	BUG_ON(res);
 
@@ -446,9 +446,10 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 {
 	int res;
 
+	clksrc.id = gptimer_id;
 	clksrc.errata = omap_dm_timer_get_errata();
 
-	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, property,
+	res = omap_dm_timer_init_one(&clksrc, fck_source, property,
 				     &clocksource_gpt.name,
 				     OMAP_TIMER_NONPOSTED);
 	BUG_ON(res);
-- 
1.7.10.4

