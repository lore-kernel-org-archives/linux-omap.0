From: "Mittal, Mukund" <mmittal@ti.com>
Subject: [PATCH] OMAP: timer-gp: Fix for null pointer dereferencing issue
Date: Thu, 9 Jul 2009 17:09:18 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B565CD5B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58241 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755830AbZGILj0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 07:39:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n69BdJC9030623
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2009 06:39:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n69BdIrL018222
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2009 17:09:18 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Mukund Mittal <mmittal@ti.com>

OMAP: timer-gp: Fix for null pointer dereferencing issue

There was a null pointer dereferencing issue for gpt pointer. 
It was checked and an error was printed but execution was not terminated. 
Fixed by calling function BUG().

Signed-off-by: Mukund Mittal <mmittal@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/timer-gp.c
+++ linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
@@ -205,14 +205,13 @@ static void __init omap2_gp_clocksource_
 {
 	static struct omap_dm_timer *gpt;
 	u32 tick_rate, tick_period;
-	static char err1[] __initdata = KERN_ERR
-		"%s: failed to request dm-timer\n";
-	static char err2[] __initdata = KERN_ERR
-		"%s: can't register clocksource!\n";
 
 	gpt = omap_dm_timer_request();
-	if (!gpt)
-		printk(err1, clocksource_gpt.name);
+	if (!gpt) {
+		printk(KERN_ERR "%s: failed to request dm-timer\n",
+			clocksource_gpt.name);
+		BUG();
+	}
 	gpt_clocksource = gpt;
 
 	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
@@ -224,7 +223,8 @@ static void __init omap2_gp_clocksource_
 	clocksource_gpt.mult =
 		clocksource_khz2mult(tick_rate/1000, clocksource_gpt.shift);
 	if (clocksource_register(&clocksource_gpt))
-		printk(err2, clocksource_gpt.name);
+		printk(KERN_ERR "%s: can't register clocksource!\n",
+			clocksource_gpt.name);
 }
 #endif

 