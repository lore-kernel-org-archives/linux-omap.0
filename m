From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 5/8] 34XX: PM: Workaround to reset all wkdeps
Date: Tue, 17 Jun 2008 10:31:07 +0300
Message-ID: <1213687867-29998-1-git-send-email-jouni.hogander@nokia.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63901 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbYFQHbL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:31:11 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5H7UNPf017791
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 02:31:09 -0500
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5H7V7xB013615
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 10:31:07 +0300
In-Reply-To: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This workaround is needed until powerdomain code resets wkdeps.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ee00609..29ef5a8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -378,6 +378,20 @@ static struct platform_suspend_ops omap_pm_ops = {
 #define R_VDD2_SR_CONTROL		0x01
 static void __init prcm_setup_regs(void)
 {
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
@@ -589,6 +603,10 @@ int __init omap3_pm_init(void)
 
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
+	/* XXX prcm_setup_regs needs to be before enabling hw
+	 * supervised mode for powerdomains */
+	prcm_setup_regs();
+
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
 			  IRQF_DISABLED, "prcm", NULL);
@@ -615,8 +633,6 @@ int __init omap3_pm_init(void)
 
 	suspend_set_ops(&omap_pm_ops);
 
-	prcm_setup_regs();
-
 	pm_idle = omap3_pm_idle;
 
 	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
-- 
1.5.5

