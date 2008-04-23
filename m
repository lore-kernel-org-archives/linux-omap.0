From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: PRCM: 34XX: Add PARENT_CONTROLS_CLOCK flag to dpll5_m2_ck
Date: Wed, 23 Apr 2008 16:12:19 +0300
Message-ID: <874p9s3ebw.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43231 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbYDWNNG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2008 09:13:06 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3NDCpaK014276
	for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2008 16:13:01 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch removes following message on dpll5_m2_ck enable and
disable:

clock.c: Enable for dpll5_m2_ck without enable code
clock: clk_disable called on independent clock dpll5_m2_ck which has no enable_reg

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 9ca2cdf..16ae5bb 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -916,7 +916,8 @@ static struct clk dpll5_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
 	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
 	.clksel		= div16_dpll5_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
-- 
1.5.5

