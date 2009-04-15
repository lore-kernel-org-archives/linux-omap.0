From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 05/10] OMAP3: SR: Disable SR autocomp only for CORE trans
Date: Wed, 15 Apr 2009 18:25:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB251810@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39282 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758870AbZDOMzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 08:55:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3FCtedT008088
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 07:55:49 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3FCtd6m021706
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 18:25:39 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Rajendra Nayak <rnayak@ti.com>

This patch disables the Smartreflex auto compensation for
both VDD1 and VDD2 only during CORE transitions in idle path.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2009-04-15 11:44:51.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2009-04-15 11:46:13.000000000 +0530
@@ -349,9 +349,6 @@ void omap_sram_idle(void)
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}
-	/* Disable smartreflex before entering WFI */
-	disable_smartreflex(SR1);
-	disable_smartreflex(SR2);
 
 	pwrdm_pre_transition();
 
@@ -380,6 +377,9 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
+		/* Disable smartreflex before entering WFI */
+		disable_smartreflex(SR1);
+		disable_smartreflex(SR2);
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
@@ -444,6 +444,9 @@ void omap_sram_idle(void)
 			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
+		/* Enable smartreflex after WFI */
+		enable_smartreflex(SR1);
+		enable_smartreflex(SR2);
 	}
 
 	/* PER */
@@ -466,9 +469,6 @@ void omap_sram_idle(void)
 		omap3_disable_io_chain();
 	}
 
-	/* Enable smartreflex after WFI */
-	enable_smartreflex(SR1);
-	enable_smartreflex(SR2);
 
 	pwrdm_post_transition();
 