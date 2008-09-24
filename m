From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 5/5] Add hooks to PM layer and clock tree for PM counters
Date: Wed, 24 Sep 2008 17:11:58 +0300
Message-ID: <1222265518-7230-6-git-send-email-peter.de-schrijver@nokia.com>
References: <1222265518-7230-1-git-send-email-peter.de-schrijver@nokia.com>
 <1222265518-7230-2-git-send-email-peter.de-schrijver@nokia.com>
 <1222265518-7230-3-git-send-email-peter.de-schrijver@nokia.com>
 <1222265518-7230-4-git-send-email-peter.de-schrijver@nokia.com>
 <1222265518-7230-5-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62302 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbYIXOMT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:12:19 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8OE6pEa007877
	for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 09:12:18 -0500
In-Reply-To: <1222265518-7230-5-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock.c       |    3 ++-
 arch/arm/mach-omap2/clockdomain.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c      |   10 +++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d0006c4..1c94c02 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1028,6 +1028,7 @@ void omap2_clk_disable_unused(struct clk *clk)
 
 	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
 	_omap2_clk_disable(clk);
-	pm_dbg_clk_state_switch(clk);
+	if (clk->clkdm.ptr != NULL)
+		pwrdm_clkdm_state_switch(clk->clkdm.ptr);
 }
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 9670ed1..74e0817 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -569,7 +569,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
-	pm_dbg_clkdm_state_switch(clkdm);
+	pwrdm_clkdm_state_switch(clkdm);
 
 	return 0;
 }
@@ -622,7 +622,7 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_sleep(clkdm);
 
-	pm_dbg_clkdm_state_switch(clkdm);
+	pwrdm_clkdm_state_switch(clkdm);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1b0272d..a2fa210 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -279,7 +279,7 @@ void omap_sram_idle(void)
 	disable_smartreflex(SR1);
 	disable_smartreflex(SR2);
 
-	pm_dbg_pre_suspend();
+	pwrdm_pre_suspend();
 
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
@@ -362,7 +362,7 @@ void omap_sram_idle(void)
 	enable_smartreflex(SR1);
 	enable_smartreflex(SR2);
 
-	pm_dbg_post_suspend();
+	pwrdm_post_suspend();
 }
 
 /*
@@ -472,7 +472,7 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (sleep_switch) {
 		cm_rmw_mod_reg_bits(0x3, 0x3, pwrdm->prcm_offs, 0x48);
 		pwrdm_wait_transition(pwrdm);
-		pm_dbg_pwrdm_state_switch(pwrdm);
+		pwrdm_state_switch(pwrdm);
 	}
 
 err:
@@ -795,7 +795,7 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm)
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *user)
 {
 	struct power_state *pwrst;
 	struct kobj_attribute *attr;
@@ -874,7 +874,7 @@ int __init omap3_pm_init(void)
 		goto err2;
 	}
 
-	ret = pwrdm_for_each(pwrdms_setup);
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
 		goto err2;
-- 
1.5.6.3

