From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Enable SYSOFFMODE use
Date: Mon, 21 Jul 2008 19:02:03 +0300
Message-ID: <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61856 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbYGUQCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2008 12:02:36 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6LFtoCe019606
	for <linux-omap@vger.kernel.org>; Mon, 21 Jul 2008 11:02:34 -0500
In-Reply-To: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 0f3a659..b41fe96 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -396,17 +396,17 @@ static void sr_configure_vc(void)
 
 	/* Setup voltctrl and other setup times */
 	/* XXX CONFIG_SYSOFFMODE has not been implemented yet */
-#ifdef CONFIG_SYSOFFMODE
-	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET,
-			OMAP3430_GR_MOD,
+#ifdef CONFIG_OMAP_SYSOFFMODE
+	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
+			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTCTRL_OFFSET);
 
 	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
 			OMAP3_PRM_CLKSETUP_OFFSET);
 	prm_write_mod_reg((OMAP3430_VOLTSETUP_TIME2 <<
-			OMAP3430_VOLTSETUP_TIME2_OFFSET) |
+			OMAP3430_SETUP_TIME2_SHIFT) |
 			(OMAP3430_VOLTSETUP_TIME1 <<
-			OMAP3430_VOLTSETUP_TIME1_OFFSET),
+			OMAP3430_SETUP_TIME1_SHIFT),
 			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
 
 	prm_write_mod_reg(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_GR_MOD,
-- 
1.5.3.4

