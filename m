From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Don't scale voltage in C1 state
Date: Wed, 14 Jan 2009 18:06:36 +0200
Message-ID: <1231949196-7480-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47691 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbZANQGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 11:06:43 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0EG6VUC018296
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 18:06:40 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch prevents VDD1 and VDD2 to go to the lowest OPP when entering C1.
It improves wakeup latency from 600us to about 50us.

---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b0b2188..87ef55e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1052,7 +1052,7 @@ static void __init configure_vc(void)
 				OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
 	/* Setup voltctrl and other setup times */
-	prm_write_mod_reg(OMAP3430_AUTO_RET | OMAP3430_AUTO_SLEEP,
+	prm_write_mod_reg(OMAP3430_AUTO_RET,
 			  OMAP3430_GR_MOD, OMAP3_PRM_VOLTCTRL_OFFSET);
 
 	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
-- 
1.5.6.3

