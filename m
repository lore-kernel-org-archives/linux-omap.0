From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 04/10] OMAP3: SR: Use sysclk for SR CLKLENGTH calc
Date: Fri, 3 Apr 2009 21:38:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C20@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47571 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936048AbZDCQIx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:08:53 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n33G8jHG014139
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 11:08:51 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n33G8iqH014853
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 21:38:44 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Rajendra Nayak <rnayak@ti.com>

This patch uses the sysclk to set the SR CLKLENGTH instead
of the OSC clock speed used earlier.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
@@ -145,14 +145,14 @@ static u32 cal_test_nvalue(u32 sennval, 
 
 static void sr_set_clk_length(struct omap_sr *sr)
 {
-	struct clk *osc_sys_ck;
-	u32 sys_clk = 0;
+	struct clk *sys_ck;
+	u32 sys_clk_speed;
 
-	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
-	sys_clk = clk_get_rate(osc_sys_ck);
-	clk_put(osc_sys_ck);
+	sys_ck = clk_get(NULL, "sys_ck");
+	sys_clk_speed = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
 
-	switch (sys_clk) {
+	switch (sys_clk_speed) {
 	case 12000000:
 		sr->clk_length = SRCLKLENGTH_12MHZ_SYSCLK;
 		break;
@@ -169,7 +169,7 @@ static void sr_set_clk_length(struct oma
 		sr->clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
 		break;
 	default :
-		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk);
+		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk_speed);
 		break;
 	}
 }