From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH] OMAP3: Remove CONFIG_OMAP_SYSOFFMODE flag
Date: Tue, 26 Aug 2008 16:00:20 +0300
Message-ID: <1219755620-9773-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43921 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbYHZM52 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 08:57:28 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7QCvA9R023584
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 15:57:25 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Remove CONFIG_OMAP_SYSOFFMODE flag and do the full initialization of voltage
controller . Enabling automatic sending of OFF command and selecting wether
SYS_OFF_MODE signal is used should be determined dynamically. Hence they are
now not set in the initialization.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a16eb33..5633753 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -623,10 +623,7 @@ static void __init configure_vc(void)
 				OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
 	/* Setup voltctrl and other setup times */
-
-#ifdef CONFIG_OMAP_SYSOFFMODE
-	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
-			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
+	prm_write_mod_reg(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTCTRL_OFFSET);
 
 	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
@@ -641,11 +638,6 @@ static void __init configure_vc(void)
 			OMAP3_PRM_VOLTOFFSET_OFFSET);
 	prm_write_mod_reg(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTSETUP2_OFFSET);
-#else
-	prm_set_mod_reg_bits(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTCTRL_OFFSET);
-#endif
-
 }
 
 static int __init omap3_pm_early_init(void)
-- 
1.5.4.3

