From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF, reduces OFF latency by 20ms
Date: Tue, 16 Jun 2009 17:22:31 +0530
Message-ID: <1245153154-1876-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60098 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbZFPLwm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2009 07:52:42 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5GBqcIj019674
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 06:52:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: dderrick@ti.com, r-woodruff2@ti.com, Rajendra Nayak <rnayak@ti.com>

If autoidle for DPLL4 is enabled in the stored scratchpad
value of CM_AUTOIDLE_PLL then there is an added delay by
the boot ROM when coming out of OFF mode.
The patch disables this bitfield in the stored scratchpad value.

This should significantly reduce CORE OFF latency and also
bring down the threshold for CORE OFF, making OFF affordable
even with smaller sleep times.
This patch however does not optimize the C state threshold for
CORE OFF states based on the new latency.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/control.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index c9407c0..a7159a9 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -238,6 +238,13 @@ void omap3_save_scratchpad_contents(void)
 			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_block_contents.cm_autoidle_pll =
 			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+	/*
+	 * ROM restore takes 20mS longer if PER idle is enabled before OFF.
+	 * Clear feature before sleep. The origional idle state is
+	 * restored by software as part of wake procedure.
+	 */
+	prcm_block_contents.cm_autoidle_pll &= ~OMAP3430_AUTO_PERIPH_DPLL_MASK;
+
 	prcm_block_contents.cm_clksel1_pll =
 			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
 	prcm_block_contents.cm_clksel2_pll =
-- 
1.5.4.7

