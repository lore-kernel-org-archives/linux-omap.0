From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/11] ARM: OMAP: Add fuctional clock enabler for iva2
Date: Thu,  8 May 2008 15:49:32 -0700
Message-ID: <1210286975-29506-9-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
 <1210286975-29506-3-git-send-email-tony@atomide.com>
 <1210286975-29506-4-git-send-email-tony@atomide.com>
 <1210286975-29506-5-git-send-email-tony@atomide.com>
 <1210286975-29506-6-git-send-email-tony@atomide.com>
 <1210286975-29506-7-git-send-email-tony@atomide.com>
 <1210286975-29506-8-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:52097 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761687AbYEHWtu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:50 -0400
In-Reply-To: <1210286975-29506-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Add fuctional clock enabler for iva2

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.h       |    5 +++--
 arch/arm/mach-omap2/cm-regbits-34xx.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index a728117..3f133a0 100644
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
1.5.3.6

