From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 3/8] OMAP3: Fix rate calculation bug in omap3_select_table_rate
Date: Fri,  9 Jan 2009 17:49:03 +0200
Message-ID: <1231516148-10260-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1231516148-10260-1-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-2-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58261 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbZAIQA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 11:00:26 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n09G0K3l003836
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 18:00:24 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n09FwtlM031435
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:58:59 +0200
In-Reply-To: <1231516148-10260-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

L3 divisor is not taken into account when trying to set DPLL3 clock.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index b565ee6..8b375a9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -959,6 +959,7 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 	struct omap_opp *prcm_vdd = NULL;
 	unsigned long found_speed = 0, curr_mpu_speed;
 	int index = 0;
+	int l3_div;
 
 	if ((clk != &virt_vdd1_prcm_set) && (clk != &virt_vdd2_prcm_set))
 		return -EINVAL;
@@ -1000,7 +1001,9 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 					curr_mpu_speed/1000, found_speed/1000);
 #endif
 	} else {
-		clk_set_rate(dpll3_clk, prcm_vdd->rate);
+		l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		clk_set_rate(dpll3_clk, prcm_vdd->rate * l3_div);
 		curr_vdd2_prcm_set = prcm_vdd;
 	}
 
-- 
1.5.4.3

