From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 04/07] OMAP3: SR: Disable SR autocomp only for CORE trans
Date: Fri, 20 Mar 2009 18:02:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EEF3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37849 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbZCTMcV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 08:32:21 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KCWCJc022570
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 07:32:19 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KCWCvp023346
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:02:12 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch disables the Smartreflex auto compensation for
both VDD1 and VDD2 only during CORE transitions in idle path.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c	2009-03-20 10:45:58.505627611 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c	2009-03-20 10:46:11.362231683 +0530
@@ -321,9 +321,6 @@ void omap_sram_idle(void)
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}
-	/* Disable smartreflex before entering WFI */
-	disable_smartreflex(SR1);
-	disable_smartreflex(SR2);
 
 	pwrdm_pre_transition();
 
@@ -352,6 +349,9 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
+		/* Disable smartreflex before entering WFI */
+		disable_smartreflex(SR1);
+		disable_smartreflex(SR2);
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
@@ -412,6 +412,9 @@ void omap_sram_idle(void)
 			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
+		/* Enable smartreflex after WFI */
+		enable_smartreflex(SR1);
+		enable_smartreflex(SR2);
 	}
 
 	/* PER */
@@ -432,9 +435,6 @@ void omap_sram_idle(void)
 	if (core_next_state < PWRDM_POWER_ON)
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 
-	/* Enable smartreflex after WFI */
-	enable_smartreflex(SR1);
-	enable_smartreflex(SR2);
 
 	pwrdm_post_transition();
 