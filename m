From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP2: Fix build errors in pm24xx.c caused by recent PRM patches
Date: Wed, 11 Jun 2008 13:11:26 +0300
Message-ID: <1213179086-5687-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64233 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbYFKKLj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 06:11:39 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5BABZUW032321
	for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 13:11:36 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/pm24xx.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bcf3afe..69972a2 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -146,16 +146,16 @@ no_sleep:
 	prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
 
 	/* MPU domain wake events */
-	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+	l = prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x01)
 		prm_write_mod_reg(0x01, OCP_MOD,
-				OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+				OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x20)
 		prm_write_mod_reg(0x20, OCP_MOD,
-				OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+				OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 
 	/* Mask future PRCM-to-MPU interrupts */
-	prm_write_mod_reg(0x0, OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+	prm_write_mod_reg(0x0, OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 }
 
 static int omap2_i2c_active(void)
@@ -349,7 +349,7 @@ static void __init prcm_setup_regs(void)
 
 	/* Enable autoidle */
 	prm_write_mod_reg(OMAP24XX_AUTOIDLE, OCP_MOD,
-				OMAP24XX_PRCM_SYSCONFIG_OFFSET);
+				OMAP24XX_PRM_SYSCONFIG_OFFSET);
 
 	/* Set all domain wakeup dependencies */
 	prm_write_mod_reg(OMAP_EN_WKUP_MASK, MPU_MOD, PM_WKDEP);
@@ -478,7 +478,7 @@ int __init omap2_pm_init(void)
 	u32 l;
 
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
-	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRCM_REVISION_OFFSET);
+	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRM_REVISION_OFFSET);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
 	/* Look up important powerdomains, clockdomains */
-- 
1.5.5.3

