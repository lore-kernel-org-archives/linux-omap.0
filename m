From: "Mittal, Mukund" <mmittal@ti.com>
Subject: [PATCH v2] OMAP: timer-gp: Fix for null pointer dereferencing issue
Date: Fri, 10 Jul 2009 17:09:14 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B565D419@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52751 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbZGJLjx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 07:39:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Mukund Mittal <mmittal@ti.com>

OMAP: timer-gp: Fix for null pointer dereferencing issue

Calling WARN() to warn for null pointer dereferencing for gpt pointer. 

Signed-off-by: Mukund Mittal <mmittal@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/timer-gp.c
+++ linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
@@ -205,14 +205,9 @@ static void __init omap2_gp_clocksource_
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
+	WARN(!gpt, "%s: failed to request dm-timer\n", clocksource_gpt.name);
 	gpt_clocksource = gpt;
 
 	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
@@ -224,7 +219,8 @@ static void __init omap2_gp_clocksource_
 	clocksource_gpt.mult =
 		clocksource_khz2mult(tick_rate/1000, clocksource_gpt.shift);
 	if (clocksource_register(&clocksource_gpt))
-		printk(err2, clocksource_gpt.name);
+		printk(KERN_ERR "%s: can't register clocksource!\n",
+			clocksource_gpt.name);
 }
 #endif
 
