From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 04/10] OMAP3: SR: Use sysclk for SR CLKLENGTH calc
Date: Wed, 15 Apr 2009 18:25:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25180F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55313 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758841AbZDOMzp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 08:55:45 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3FCtdBE013690
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 07:55:45 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3FCtc7X021702
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 18:25:38 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

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
--- linux-omap-2.6.orig/arch/arm/mach-omap2/smartreflex.c	2009-04-15 11:46:12.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c	2009-04-15 11:46:13.000000000 +0530
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
