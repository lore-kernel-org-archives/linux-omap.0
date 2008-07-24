From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 3/3] Add hooks for counting off on power transitions
Date: Thu, 24 Jul 2008 16:00:34 +0300
Message-ID: <1216904434-7545-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
 <1216904434-7545-2-git-send-email-peter.de-schrijver@nokia.com>
 <1216904434-7545-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24060 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbYGXNBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2008 09:01:09 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6OD0o9n021150
	for <linux-omap@vger.kernel.org>; Thu, 24 Jul 2008 08:01:07 -0500
In-Reply-To: <1216904434-7545-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c |   10 ++++++++++
 arch/arm/mach-omap2/pm34xx.c      |    6 +++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index e975ca1..fac5778 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -571,6 +571,11 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	/*Hook to inform the OMAP PM layer that the pwrdm has become active */
 	omap_pm_pwrdm_active(clkdm->pwrdm);
 
+	if (clkdm != NULL && clkdm->pwrdm != NULL) {
+		pwrdm_wait_transition(clkdm->pwrdm);
+		pwrdm_check_off_mode(clkdm->pwrdm);
+	}
+
 	return 0;
 }
 
@@ -625,6 +630,11 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	/*Hook to inform the OMAP PM layer that the pwrdm has become inactive */
 	omap_pm_pwrdm_inactive(clkdm->pwrdm);
 
+	if (clkdm != NULL && clkdm->pwrdm != NULL) {
+		pwrdm_wait_transition(clkdm->pwrdm);
+		pwrdm_save_state(clkdm->pwrdm);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8b6b09e..f70035a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -269,6 +269,8 @@ void omap_sram_idle(void)
 		return;
 	}
 
+	pwrdm_save_state_all();
+
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		set_pwrdm_state(neon_pwrdm, mpu_next_state);
@@ -346,6 +348,8 @@ void omap_sram_idle(void)
 		}
 		omap2_gpio_resume_after_retention();
 	}
+
+	pwrdm_count_off_mode();
 }
 
 static int omap3_fclks_active(void)
@@ -848,7 +852,7 @@ int __init omap3_pm_init(void)
 		goto err2;
 	}
 
-	ret = pwrdm_for_each(pwrdms_setup);
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
 		goto err2;
-- 
1.5.6.3

