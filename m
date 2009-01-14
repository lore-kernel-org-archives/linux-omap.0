From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Don't scale voltage in C1 state
Date: Wed, 14 Jan 2009 18:32:35 +0200
Message-ID: <1231950755-8620-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53192 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761008AbZANQdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 11:33:04 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0EGWZo8016735
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 10:33:01 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch prevents VDD1 and VDD2 to go to the lowest OPP when entering C1.
It improves wakeup latency from 600us to about 50us.

Now with signoff :)

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
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

