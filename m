From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP3xxx: clockdomain: fix software supervised
 wakeup/sleep
Date: Thu, 26 Jul 2012 15:04:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207261503290.14468@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44717 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab2GZVEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 17:04:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, jon-hunter@ti.com


Commit 4da71ae6 ("OMAP: clockdomain: Arch specific funcs for
clkdm_clk_enable/disable") called the OMAP2xxx-specific functions for
clockdomain wakeup and sleep.  This would probably have broken
software-supervised clockdomain wakeup and sleep on OMAP3.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   50 ++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index a0d68db..f99e65c 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -241,6 +241,52 @@ static void omap3_clkdm_deny_idle(struct clockdomain *clkdm)
 		_clkdm_del_autodeps(clkdm);
 }
 
+static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
+{
+	bool hwsup = false;
+
+	if (!clkdm->clktrctrl_mask)
+		return 0;
+
+	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+
+	if (hwsup) {
+		/* Disable HW transitions when we are changing deps */
+		_disable_hwsup(clkdm);
+		_clkdm_add_autodeps(clkdm);
+		_enable_hwsup(clkdm);
+	} else {
+		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+			omap3_clkdm_wakeup(clkdm);
+	}
+
+	return 0;
+}
+
+static int omap3xxx_clkdm_clk_disable(struct clockdomain *clkdm)
+{
+	bool hwsup = false;
+
+	if (!clkdm->clktrctrl_mask)
+		return 0;
+
+	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+
+	if (hwsup) {
+		/* Disable HW transitions when we are changing deps */
+		_disable_hwsup(clkdm);
+		_clkdm_del_autodeps(clkdm);
+		_enable_hwsup(clkdm);
+	} else {
+		if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
+			omap3_clkdm_sleep(clkdm);
+	}
+
+	return 0;
+}
+
 struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
 	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
@@ -267,6 +313,6 @@ struct clkdm_ops omap3_clkdm_operations = {
 	.clkdm_wakeup		= omap3_clkdm_wakeup,
 	.clkdm_allow_idle	= omap3_clkdm_allow_idle,
 	.clkdm_deny_idle	= omap3_clkdm_deny_idle,
-	.clkdm_clk_enable	= omap2_clkdm_clk_enable,
-	.clkdm_clk_disable	= omap2_clkdm_clk_disable,
+	.clkdm_clk_enable	= omap3xxx_clkdm_clk_enable,
+	.clkdm_clk_disable	= omap3xxx_clkdm_clk_disable,
 };
-- 
1.7.10.4

