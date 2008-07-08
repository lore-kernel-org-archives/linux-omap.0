From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [RFC] OMAP3: CPUIDLE & PM: Modifications and fixes. Suspend part.
Date: Tue,  8 Jul 2008 15:17:20 +0300
Message-ID: <1215519440-10234-1-git-send-email-jouni.hogander@nokia.com>
References: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21892 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbYGHMRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 08:17:51 -0400
In-Reply-To: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, rnayak@ti.com

With this suspend also works.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   32 ++++++--------------------------
 1 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1f9c58a..9f73e5c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -503,29 +503,8 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
-	omap2_gpio_prepare_for_retention();
-
-	if (clocks_off_while_idle) {
-		omap_serial_enable_clocks(0, 0);
-		omap_serial_enable_clocks(0, 1);
-		omap_serial_enable_clocks(0, 2);
-		/* XXX This is for gpio fclk hack. Will be removed as
-		 * gpio driver * handles fcks correctly */
-		per_gpio_clk_disable();
-	}
-
 	omap_sram_idle();
 
-	if (clocks_off_while_idle) {
-		omap_serial_enable_clocks(1, 0);
-		omap_serial_enable_clocks(1, 1);
-		omap_serial_enable_clocks(1, 2);
-		/* XXX This is for gpio fclk hack. Will be removed as
-		 * gpio driver * handles fcks correctly */
-		per_gpio_clk_enable();
-	}
-
-	omap2_gpio_resume_after_retention();
 restore:
 	/* Restore next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
@@ -748,16 +727,17 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") || !strcmp(pwrst->pwrdm->name, "mpu_pwrdm") || !strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
-		pwrst->next_state = PWRDM_POWER_ON;
-	else
-		pwrst->next_state = PWRDM_POWER_OFF;
+	pwrst->next_state = PWRDM_POWER_OFF;
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
 		pwrdm_enable_hdwr_sar(pwrdm);
 
-	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") || !strcmp(pwrst->pwrdm->name, "mpu_pwrdm") ||
+	    !strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
+		return set_pwrdm_state(pwrst->pwrdm, PWRDM_POWER_ON);
+	else
+		return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
 void omap_push_sram_idle()
-- 
1.5.5

