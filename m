From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM-20081106 3/3] OMAP2: PM: Fix omap2 build
Date: Tue, 18 Nov 2008 14:42:38 +0200
Message-ID: <1227012158-919-1-git-send-email-jouni.hogander@nokia.com>
References: <87skppi50r.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46024 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYKRMmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 07:42:47 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAICgVBN016329
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 14:42:44 +0200
In-Reply-To: <87skppi50r.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch fixes build in case of omap2.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm.h     |    4 ++++
 arch/arm/mach-omap2/pm24xx.c |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 91431f9..4b1ba7c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -32,7 +32,11 @@ extern void *omap3_secure_ram_storage;
 
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
+#ifdef CONFIG_ARCH_OMAP3
 extern void omap3_pm_off_mode_enable(int);
+#else
+#define omap3_pm_off_mode_enable(int) do {} while (0);
+#endif
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 4a19804..b385f3c 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -338,7 +338,7 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm)
+static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm, void *unused)
 {
 	omap2_clkdm_allow_idle(clkdm);
 	return 0;
@@ -390,7 +390,7 @@ static void __init prcm_setup_regs(void)
 	omap2_clkdm_sleep(gfx_clkdm);
 
 	/* Enable clockdomain hardware-supervised control for all clkdms */
-	clkdm_for_each(_pm_clkdm_enable_hwsup);
+	clkdm_for_each(_pm_clkdm_enable_hwsup, NULL);
 
 	/* Enable clock autoidle for all domains */
 	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
-- 
1.6.0.1

