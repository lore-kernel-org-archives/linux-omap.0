From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] OMAP3: Lock DPLL5 at boot
Date: Tue,  8 Sep 2009 19:24:16 +0530
Message-ID: <1252418056-5994-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45235 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbZIHNyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 09:54:23 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n88DsJ2K029540
	for <linux-omap@vger.kernel.org>; Tue, 8 Sep 2009 08:54:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Anand Gadiyar <gadiyar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

OMAP3: Lock DPLL5 at boot

Lock DPLL5 at 120MHz at boot. The USBHOST 120MHz f-clock and
USBTLL f-clock are the only users of this DPLL, and 120MHz is
is the only recommended rate for these clocks.

With this patch, the 60 MHz ULPI clock is generated correctly.

Tested on an OMAP3430 SDP.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Incorporated all 3 comments by Paul and Benoit. Updated
$SUBJECT to reflect the change.

 arch/arm/mach-omap2/clock34xx.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock34xx.c
+++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
@@ -338,6 +338,13 @@ static struct omap_clk omap34xx_clks[] =
  */
 #define SDRC_MPURATE_LOOPS		96
 
+/*
+ * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
+ * that are sourced by DPLL5, and both of these require this clock
+ * to be at 120 MHz for proper operation.
+ */
+#define DPLL5_FREQ_FOR_USBHOST		120000000
+
 /**
  * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
  * @clk: struct clk * being enabled
@@ -1056,6 +1063,28 @@ void omap2_clk_prepare_for_reboot(void)
 #endif
 }
 
+static void omap3_clk_lock_dpll5(void)
+{
+	struct clk *dpll5_clk;
+	struct clk *dpll5_m2_clk;
+
+	dpll5_clk = clk_get(NULL, "dpll5_ck");
+	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
+	clk_enable(dpll5_clk);
+
+	/* Enable autoidle to allow it to enter low power bypass */
+	omap3_dpll_allow_idle(dpll5_clk);
+
+	/* Program dpll5_m2_clk divider for no division */
+	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
+	clk_enable(dpll5_m2_clk);
+	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
+
+	clk_disable(dpll5_m2_clk);
+	clk_disable(dpll5_clk);
+	return;
+}
+
 /* REVISIT: Move this init stuff out into clock.c */
 
 /*
@@ -1148,6 +1177,12 @@ int __init omap2_clk_init(void)
 	 */
 	clk_enable_init_clocks();
 
+	/*
+	 * Lock DPLL5 and put it in autoidle.
+	 */
+	if (omap_rev() >= OMAP3430_REV_ES2_0)
+		omap3_clk_lock_dpll5();
+
 	/* Avoid sleeping during omap2_clk_prepare_for_reboot() */
 	/* REVISIT: not yet ready for 343x */
 #if 0
