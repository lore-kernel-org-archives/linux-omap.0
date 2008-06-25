From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH] PRCM: 34XX: Fix wrong shift value used in dpll4_m4x2_ck enable bit
Date: Wed, 25 Jun 2008 08:38:02 +0300
Message-ID: <1214372282-1862-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65329 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbYFYFi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 01:38:29 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5P5c020003726
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 08:38:26 +0300
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5P5c2rE017788
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 08:38:02 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Enable bit for dpll4_m4x2_ck is OMAP3430_PWRDN_DSS1_SHIFT instead of
OMAP3430_PWRDN_CAM_SHIFT.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index b4dceea..4a8729a 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -819,7 +819,7 @@ static struct clk dpll4_m4x2_ck = {
 	.name		= "dpll4_m4x2_ck",
 	.parent		= &dpll4_m4_ck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
+	.enable_bit	= OMAP3430_PWRDN_DSS1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
-- 
1.5.5

