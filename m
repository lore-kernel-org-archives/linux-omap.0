From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 1/6] 34XX: PM: Workaround to reset all wkdeps
Date: Mon, 30 Jun 2008 11:52:43 +0300
Message-ID: <1214815963-23115-1-git-send-email-jouni.hogander@nokia.com>
References: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62463 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbYF3IxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 04:53:09 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5U8r0Zc015429
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 03:53:07 -0500
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5U8qhtR022616
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 11:52:43 +0300
In-Reply-To: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This workaround is needed until powerdomain code resets wkdeps.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 202c269..449e7b5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -332,6 +332,20 @@ static struct platform_suspend_ops omap_pm_ops = {
 
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
 	/* setup wakup source */
 	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1,
 			  WKUP_MOD, PM_WKEN);
@@ -371,6 +385,10 @@ int __init omap3_pm_init(void)
 
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
+	/* XXX prcm_setup_regs needs to be before enabling hw
+	 * supervised mode for powerdomains */
+	prcm_setup_regs();
+
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
 			  IRQF_DISABLED, "prcm", NULL);
@@ -397,8 +415,6 @@ int __init omap3_pm_init(void)
 
 	suspend_set_ops(&omap_pm_ops);
 
-	prcm_setup_regs();
-
 	pm_idle = omap3_pm_idle;
 
 err1:
-- 
1.5.5

