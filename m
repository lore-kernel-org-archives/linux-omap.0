From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] PM and clock domain hooks for off mode counters
Date: Fri,  5 Sep 2008 16:21:25 +0300
Message-ID: <1220620885-6096-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1220620885-6096-1-git-send-email-peter.de-schrijver@nokia.com>
 <1220620885-6096-2-git-send-email-peter.de-schrijver@nokia.com>
 <1220620885-6096-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23933 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYIENV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 09:21:59 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m85DLCfJ010839
	for <linux-omap@vger.kernel.org>; Fri, 5 Sep 2008 08:21:57 -0500
In-Reply-To: <1220620885-6096-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c |   10 ++++++++++
 arch/arm/mach-omap2/pm34xx.c      |    9 +++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index fa62f14..5b87b9b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -567,6 +567,11 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
+	if (clkdm != NULL && clkdm->pwrdm.ptr != NULL) {
+		pwrdm_wait_transition(clkdm->pwrdm.ptr);
+		pwrdm_check_off_mode(clkdm->pwrdm.ptr);
+	}
+
 	return 0;
 }
 
@@ -618,6 +623,11 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_sleep(clkdm);
 
+	if (clkdm != NULL && clkdm->pwrdm.ptr != NULL) {
+		pwrdm_wait_transition(clkdm->pwrdm.ptr);
+		pwrdm_save_pwrst(clkdm->pwrdm.ptr);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a16eb33..32f46c9 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -167,11 +167,16 @@ static void omap_sram_idle(void)
 		return;
 	}
 
+	pwrdm_save_pwrst_all();
+
 	omap2_gpio_prepare_for_retention();
 
 	_omap_sram_idle(NULL, save_state);
 
 	omap2_gpio_resume_after_retention();
+
+	pwrdm_count_off_mode();
+
 }
 
 /*
@@ -521,7 +526,7 @@ static void __init prcm_setup_regs(void)
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm)
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
 
@@ -561,7 +566,7 @@ int __init omap3_pm_init(void)
 		goto err1;
 	}
 
-	ret = pwrdm_for_each(pwrdms_setup);
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
 		goto err2;
-- 
1.5.6.3

