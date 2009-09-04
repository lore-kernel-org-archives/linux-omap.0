From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] OMAP3: Enable and autoidle DPLL5 at boot
Date: Fri,  4 Sep 2009 16:28:39 +0530
Message-ID: <1252061919-24122-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56975 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbZIDK6p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 06:58:45 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n84Awf4J009344
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 05:58:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Anand Gadiyar <gadiyar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

OMAP3: Enable and autoidle DPLL5 at boot

Enable DPLL5 at bootup and put it into auto-idle.
This is required for the USBHOST 120MHz f-clock and USBTLL f-clock
to work.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock34xx.c
+++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
@@ -1056,6 +1056,25 @@ void omap2_clk_prepare_for_reboot(void)
 #endif
 }
 
+static void omap3_lock_dpll5(void)
+{
+	struct clk *dpll5_clk;
+	struct clk *dpll5_m2_clk;
+
+	dpll5_clk = clk_get(NULL, "dpll5_ck");
+	clk_set_rate(dpll5_clk, 120000000);
+	clk_enable(dpll5_clk);
+
+	/* Enable autoidle to allow it to enter low power bypass */
+	omap3_dpll_allow_idle(dpll5_clk);
+
+	/* Program dpll5_m2_clk divider for no division */
+	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
+	clk_enable(dpll5_m2_clk);
+	clk_set_rate(dpll5_m2_clk, 120000000);
+	return;
+}
+
 /* REVISIT: Move this init stuff out into clock.c */
 
 /*
@@ -1148,6 +1167,12 @@ int __init omap2_clk_init(void)
 	 */
 	clk_enable_init_clocks();
 
+	/*
+	 * Lock DPLL5 and put it in autoidle.
+	 */
+	if (omap_rev() >= OMAP3430_REV_ES2_0)
+		omap3_lock_dpll5();
+
 	/* Avoid sleeping during omap2_clk_prepare_for_reboot() */
 	/* REVISIT: not yet ready for 343x */
 #if 0
