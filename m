From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH] PRCM: OMAP3: Fix to wrongly modified omap2_clk_wait_ready
Date: Mon,  9 Jun 2008 12:32:40 +0300
Message-ID: <1213003960-900-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55524 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYFIJcw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 05:32:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com

omap2_clk_wait_ready was wrongly modified to check
registers contents. This fix changes it back to check
addresses.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d3ab537..ed15868 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -246,8 +246,8 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* OMAP3: ignore DSS-mod clocks */
 	if (cpu_is_omap34xx() &&
-	    ((reg & ~0xff) == cm_read_mod_reg(OMAP3430_DSS_MOD, 0) ||
-	     (((reg & ~0xff) == cm_read_mod_reg(CORE_MOD, 0)) &&
+	    ((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
+	     (((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(CORE_MOD, 0)) &&
 	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
 		return;
 
-- 
1.5.5

