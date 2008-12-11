From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 19/23] OMAP3: Fix rate calculation bug in omap3_select_table_rate
Date: Thu, 11 Dec 2008 17:52:38 +0200
Message-ID: <1229010762-3150-20-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-14-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-15-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-16-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-17-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-18-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-19-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34967 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211AbYLKP7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:16 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBBFwj2u020861
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:09 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBBFwci0011022
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:05 +0200
In-Reply-To: <1229010762-3150-19-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

L3 divisor is not taken into account when trying to set DPLL3 clock.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 47a8465..cfd7f0f 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -939,6 +939,7 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 	struct omap_opp *prcm_vdd;
 	unsigned long found_speed = 0, curr_mpu_speed;
 	int index;
+	int l3_div;
 
 	if ((clk != &virt_vdd1_prcm_set) && (clk != &virt_vdd2_prcm_set))
 		return -EINVAL;
@@ -984,7 +985,9 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 					curr_mpu_speed/1000, found_speed/1000);
 #endif
 	} else {
-		clk_set_rate(dpll3_clk, prcm_vdd->rate);
+		l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		clk_set_rate(dpll3_clk, prcm_vdd->rate * l3_div);
 		curr_vdd2_prcm_set = prcm_vdd;
 		omap2_clksel_recalc(&core_ck);
 		propagate_rate(&core_ck);
-- 
1.5.4.3

