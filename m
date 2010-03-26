From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] OMAP3: clock: fix enable bit used for dpll4_m4x2 clock
Date: Fri, 26 Mar 2010 10:25:13 +0530
Message-ID: <1269579313-10064-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46948 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab0CZEzU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Mar 2010 00:55:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, ranjithl@ti.com

The enable bit for dpll4_m4x2 clock should be OMAP3430_PWRDN_DSS1_SHIFT.
The code erroneously uses OMAP3430_PWRDN_CAM_SHIFT which is meant for
dpll4_m5x2 clock.

This came into notice during a recent review of the clock tree.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..9cba556 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -895,7 +895,7 @@ static struct clk dpll4_m4x2_ck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m4_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
+	.enable_bit	= OMAP3430_PWRDN_DSS1_SHIFT,
 	.flags		= INVERT_ENABLE,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
-- 
1.6.2.4

