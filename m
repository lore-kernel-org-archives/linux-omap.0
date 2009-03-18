From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 03/05] OMAP3: SR: Use sysclk for SR CLKLENGTH calc
Date: Wed, 18 Mar 2009 15:25:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAEDE84A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511AbZCRJzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 05:55:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2I9tWG3017313
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 04:55:38 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2I9tWJA022128
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 15:25:32 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch uses the sysclk to set the SR CLKLENGTH instead
of the OSC clock speed used earlier.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-18 13:56:25.610250244 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c	2009-03-18 13:56:26.106235150 +0530
@@ -146,14 +146,14 @@ static u32 cal_test_nvalue(u32 sennval, 
 
 static void sr_set_clk_length(struct omap_sr *sr)
 {
-	struct clk *osc_sys_ck;
-	u32 sys_clk = 0;
+	struct clk *sys_ck;
+	u32 sys_clk_speed = 0;
 
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
@@ -170,7 +170,7 @@ static void sr_set_clk_length(struct oma
 		sr->clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
 		break;
 	default :
-		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk);
+		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk_speed);
 		break;
 	}
 }