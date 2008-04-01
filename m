From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/2] ARM: OMAP: Add fuctional clock enabler for iva2
Date: Tue,  1 Apr 2008 10:11:22 +0300
Message-ID: <1207033882-15570-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27785 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYDAHLt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Apr 2008 03:11:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h       |    5 +++--
 arch/arm/mach-omap2/cm-regbits-34xx.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index d00ef1e..4d9a67b 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1046,12 +1046,13 @@ static struct clk iva2_ck = {
 	.name		= "iva2_ck",
 	.parent		= &dpll2_m2_ck,
 	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
 					  OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.clksel		= iva2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 9249129..3c38395 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -56,6 +56,7 @@
 
 /* CM_FCLKEN_IVA2 */
 #define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2			(1 << 0)
+#define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT		0
 
 /* CM_CLKEN_PLL_IVA2 */
 #define OMAP3430_IVA2_DPLL_RAMPTIME_SHIFT		8
-- 
1.5.4.3.325.g6d216

