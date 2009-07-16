From: "Mittal, Mukund" <mmittal@ti.com>
Subject: [PATCH v3] OMAP: timer-gp: Fix for null pointer dereferencing issue
Date: Thu, 16 Jul 2009 17:51:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B57BB71E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53825 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755454AbZGPMVw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 08:21:52 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Mukund Mittal <mmittal@ti.com>

OMAP: timer-gp: Fix for null pointer dereferencing issue

Calling WARN_ON() to warn for null pointer dereferencing for gpt pointer. 

Signed-off-by: Mukund Mittal <mmittal@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/timer-gp.c
+++ linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
@@ -211,8 +211,10 @@ static void __init omap2_gp_clocksource_
 		"%s: can't register clocksource!\n";
 
 	gpt = omap_dm_timer_request();
-	if (!gpt)
+	if (!gpt) {
 		printk(err1, clocksource_gpt.name);
+		WARN_ON(1);
+	}
 	gpt_clocksource = gpt;
 
 	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);



