From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/3] Add closures to clkdm_for_each
Date: Tue,  7 Oct 2008 16:33:14 +0300
Message-ID: <1223386396-29560-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1223386396-29560-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43263 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbYJGNdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 09:33:32 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97DXHJY020850
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 16:33:30 +0300
In-Reply-To: <1223386396-29560-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c             |   31 ++----------------------
 arch/arm/mach-omap2/pm24xx.c                  |    2 +-
 arch/arm/mach-omap2/pm34xx.c                  |   13 ++++------
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
 4 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 33290a7..f0f02a5 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -297,7 +297,8 @@ struct clockdomain *clkdm_lookup(const char *name)
  * anything else to indicate failure; or -EINVAL if the function pointer
  * is null.
  */
-int clkdm_for_each(int (*fn)(struct clockdomain *clkdm))
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
+			void *user)
 {
 	struct clockdomain *clkdm;
 	int ret = 0;
@@ -307,7 +308,7 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm))
 
 	mutex_lock(&clkdm_mutex);
 	list_for_each_entry(clkdm, &clkdm_list, node) {
-		ret = (*fn)(clkdm);
+		ret = (*fn)(clkdm, user);
 		if (ret)
 			break;
 	}
@@ -569,8 +570,6 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
-	pm_dbg_clkdm_state_switch(clkdm);
-
 	pwrdm_clkdm_state_switch(clkdm);
 
 	return 0;
@@ -624,31 +623,7 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_sleep(clkdm);
 
-	pm_dbg_clkdm_state_switch(clkdm);
-
 	pwrdm_clkdm_state_switch(clkdm);
 
 	return 0;
 }
-
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-int clkdm_dbg_show_counters(struct seq_file *s, void *unused)
-{
-	struct clockdomain *clkdm;
-
-	list_for_each_entry(clkdm, &clkdm_list, node) {
-		if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
-			strcmp(clkdm->name, "wkup_clkdm") == 0)
-			continue;
-		seq_printf(s, "%s->%s (%d)", clkdm->name,
-			   clkdm->pwrdm.ptr->name,
-			   atomic_read(&clkdm->usecount));
-		seq_printf(s, "\n");
-	}
-
-	return 0;
-}
-
-#endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 4be9385..3ec68f7 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -401,7 +401,7 @@ static void __init prcm_setup_regs(void)
 	omap2_clkdm_sleep(gfx_clkdm);
 
 	/* Enable clockdomain hardware-supervised control for all clkdms */
-	clkdm_for_each(_pm_clkdm_enable_hwsup);
+	clkdm_for_each(_pm_clkdm_enable_hwsup, NULL);
 
 	/* Enable clock autoidle for all domains */
 	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 90e108b..2688086 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -174,8 +174,6 @@ static void omap_sram_idle(void)
 	disable_smartreflex(SR1);
 	disable_smartreflex(SR2);
 
-	pm_dbg_pre_suspend();
-
 	pwrdm_pre_transition();
 
 	omap2_gpio_prepare_for_retention();
@@ -192,13 +190,12 @@ static void omap_sram_idle(void)
 
 	omap2_gpio_resume_after_retention();
 
-	pm_dbg_post_suspend();
+	pwrdm_post_transition();
 
 	/* Enable smartreflex after WFI */
 	enable_smartreflex(SR1);
 	enable_smartreflex(SR2);
 
-	pwrdm_post_transition();
 
 }
 
@@ -538,7 +535,7 @@ static void __init prcm_setup_regs(void)
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm)
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
 
@@ -558,7 +555,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
-static int __init clkdms_setup(struct clockdomain *clkdm)
+static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	omap2_clkdm_allow_idle(clkdm);
 	return 0;
@@ -584,13 +581,13 @@ int __init omap3_pm_init(void)
 		goto err1;
 	}
 
-	ret = pwrdm_for_each(pwrdms_setup);
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
 		goto err2;
 	}
 
-	(void) clkdm_for_each(clkdms_setup);
+	(void) clkdm_for_each(clkdms_setup, NULL);
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
diff --git a/arch/arm/plat-omap/include/mach/clockdomain.h b/arch/arm/plat-omap/include/mach/clockdomain.h
index b9d0dd2..99ebd88 100644
--- a/arch/arm/plat-omap/include/mach/clockdomain.h
+++ b/arch/arm/plat-omap/include/mach/clockdomain.h
@@ -95,7 +95,8 @@ int clkdm_register(struct clockdomain *clkdm);
 int clkdm_unregister(struct clockdomain *clkdm);
 struct clockdomain *clkdm_lookup(const char *name);
 
-int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
+			void *user);
 struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
 
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
-- 
1.5.6.3

