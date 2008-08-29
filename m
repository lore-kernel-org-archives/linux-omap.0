From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/1] ARM:OMAP3: Smartreflex disable/enable fix
Date: Fri, 29 Aug 2008 13:05:44 +0300
Message-ID: <1220004344-32542-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23311 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYH2KBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 06:01:54 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7TA18LS012996
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 05:01:52 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Smartreflex modules have to be disabled when device enters WFI.
Previously only suspend idle path had these calls. By moving the
disable/enable calls to omap_sram_idle, all idle paths will be covered.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a16eb33..e2d1119 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -166,12 +166,19 @@ static void omap_sram_idle(void)
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}
+	/* Disable smartreflex before entering WFI */
+	disable_smartreflex(SR1);
+	disable_smartreflex(SR2);
 
 	omap2_gpio_prepare_for_retention();
 
 	_omap_sram_idle(NULL, save_state);
 
 	omap2_gpio_resume_after_retention();
+
+	/* Enable smartreflex after WFI */
+	enable_smartreflex(SR1);
+	enable_smartreflex(SR2);
 }
 
 /*
@@ -297,10 +304,6 @@ static int omap3_pm_suspend(void)
 	struct power_state *pwrst;
 	int state, ret = 0;
 
-	/* XXX Disable smartreflex before entering suspend */
-	disable_smartreflex(SR1);
-	disable_smartreflex(SR2);
-
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
@@ -332,10 +335,6 @@ restore:
 		printk(KERN_INFO "Successfully put all powerdomains "
 		       "to target state\n");
 
-	/* XXX Enable smartreflex after suspend */
-	enable_smartreflex(SR1);
-	enable_smartreflex(SR2);
-
 	return ret;
 }
 
-- 
1.5.4.3

