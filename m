From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 2/2] arm: omap3: pm34xx.c: Replace printk() with appropriate pr_*()
Date: Thu, 15 Mar 2012 16:07:13 -0700
Message-ID: <1331852833-4357-3-git-send-email-mgreer@animalcreek.com>
References: <1331852833-4357-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:60779 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161133Ab2COXHV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 19:07:21 -0400
In-Reply-To: <1331852833-4357-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Currently, pm34xx.c has a mix of printk() and pr_*() statements
so replace the printk() statements with the equivalent pr_*()
statements.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/pm34xx.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index af8d741..495e509 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -166,8 +166,7 @@ static void omap3_save_secure_ram_context(void)
 		pwrdm_set_next_pwrst(mpu_pwrdm, mpu_next_state);
 		/* Following is for error tracking, it should not happen */
 		if (ret) {
-			printk(KERN_ERR "save_secure_sram() returns %08x\n",
-				ret);
+			pr_err("save_secure_sram() returns %08x\n", ret);
 			while (1)
 				;
 		}
@@ -307,7 +306,7 @@ void omap_sram_idle(void)
 		break;
 	default:
 		/* Invalid state */
-		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
+		pr_err("Invalid mpu state in sram_idle\n");
 		return;
 	}
 
@@ -463,7 +462,7 @@ restore:
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
 		if (state > pwrst->next_state) {
-			printk(KERN_INFO "Powerdomain (%s) didn't enter "
+			pr_info("Powerdomain (%s) didn't enter "
 			       "target state %d\n",
 			       pwrst->pwrdm->name, pwrst->next_state);
 			ret = -1;
@@ -471,9 +470,9 @@ restore:
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
 	}
 	if (ret)
-		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
+		pr_err("Could not enter target state in pm_suspend\n");
 	else
-		printk(KERN_INFO "Successfully put all powerdomains "
+		pr_info("Successfully put all powerdomains "
 		       "to target state\n");
 
 	return ret;
@@ -822,7 +821,7 @@ static int __init omap3_pm_init(void)
 
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
-		printk(KERN_ERR "Failed to setup powerdomains\n");
+		pr_err("Failed to setup powerdomains\n");
 		goto err3;
 	}
 
@@ -830,7 +829,7 @@ static int __init omap3_pm_init(void)
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
-		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
+		pr_err("Failed to get mpu_pwrdm\n");
 		ret = -EINVAL;
 		goto err3;
 	}
@@ -865,7 +864,7 @@ static int __init omap3_pm_init(void)
 		omap3_secure_ram_storage =
 			kmalloc(0x803F, GFP_KERNEL);
 		if (!omap3_secure_ram_storage)
-			printk(KERN_ERR "Memory allocation failed when"
+			pr_err("Memory allocation failed when"
 					"allocating for secure sram context\n");
 
 		local_irq_disable();
-- 
1.7.9.4

