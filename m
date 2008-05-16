From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 06/10] 34XX: PM: Workaround to reset all wkdeps
Date: Fri, 16 May 2008 14:05:08 +0300
Message-ID: <1210935908-28019-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37495 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbYEPLFs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:48 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB5Eww032754
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 06:05:47 -0500
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

This workaround is needed until powerdomain code resets wkdeps.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c30a218..a5504b7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -369,6 +369,20 @@ static void __init prcm_setup_regs(void)
 {
 	u32 v;
 
+	/* XXX Reset all wkdeps. This should be done when initializing
+	 * powerdomains */
+	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
+		prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
+	} else
+		prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
+
 	/* XXX Enable interface clock autoidle for all modules. This
 	 * should be done by clockfw */
 	cm_write_mod_reg(
@@ -573,6 +587,10 @@ int __init omap3_pm_init(void)
 
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
+	/* XXX prcm_setup_regs needs to be before enabling hw
+	 * supervised mode for powerdomains */
+	prcm_setup_regs();
+
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
 			  IRQF_DISABLED, "prcm", NULL);
@@ -599,8 +617,6 @@ int __init omap3_pm_init(void)
 
 	suspend_set_ops(&omap_pm_ops);
 
-	prcm_setup_regs();
-
 	pm_idle = omap3_pm_idle;
 
 	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
-- 
1.5.5

