From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 1/2] arm: omap3: pm34xx.c: Fix omap3_pm_init() error out paths
Date: Thu, 15 Mar 2012 16:07:12 -0700
Message-ID: <1331852833-4357-2-git-send-email-mgreer@animalcreek.com>
References: <1331852833-4357-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:60775 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161077Ab2COXHV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 19:07:21 -0400
In-Reply-To: <1331852833-4357-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Mark A. Greer" <mgreer@animalcreek.com>, Tero Kristo <t-kristo@ti.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

It appears that the error paths were overlooked when the
omap3_pm_init() routine had the prcm chain handler code
added.  Fix this by adding a goto target and reordering
the error handling code.  Also fix how the irq argument
for free_irq() is determined.

CC: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/pm34xx.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 27fc7a2..af8d741 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -817,13 +817,13 @@ static int __init omap3_pm_init(void)
 
 	if (ret) {
 		pr_err("pm: Failed to request pm_io irq\n");
-		goto err1;
+		goto err2;
 	}
 
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
-		goto err2;
+		goto err3;
 	}
 
 	(void) clkdm_for_each(clkdms_setup, NULL);
@@ -831,7 +831,8 @@ static int __init omap3_pm_init(void)
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
-		goto err2;
+		ret = -EINVAL;
+		goto err3;
 	}
 
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
@@ -879,14 +880,17 @@ static int __init omap3_pm_init(void)
 	}
 
 	omap3_save_scratchpad_contents();
-err1:
 	return ret;
-err2:
-	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
+
+err3:
 	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
 		list_del(&pwrst->node);
 		kfree(pwrst);
 	}
+	free_irq(omap_prcm_event_to_irq("io"), omap3_pm_init);
+err2:
+	free_irq(omap_prcm_event_to_irq("wkup"), NULL);
+err1:
 	return ret;
 }
 
-- 
1.7.9.4

