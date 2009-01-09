From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 8/8] PM: OMAP3: Added support for possibly failing clk_set_rate to DVFS
Date: Fri,  9 Jan 2009 17:49:08 +0200
Message-ID: <1231516148-10260-9-git-send-email-tero.kristo@nokia.com>
References: <>
 <1231516148-10260-1-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-2-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-3-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-4-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-5-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-6-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-7-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-8-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49416 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbZAIP7g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 10:59:36 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n09FxL3C017085
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:59:35 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n09FwtlR031435
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:59:07 +0200
In-Reply-To: <1231516148-10260-8-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

clk_set_rate() can fail in a case where a driver denies frequency change,
this can happen after Paul's clk notifier code has been applied. This patch
makes DVFS VDD2 control handle this situation correctly.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c    |    5 ++++-
 arch/arm/mach-omap2/resource34xx.c |   18 ++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 6c5254c..17102ba 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -960,6 +960,7 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 	unsigned long found_speed = 0, curr_mpu_speed;
 	int index = 0;
 	int l3_div;
+	int ret;
 
 	if ((clk != &virt_vdd1_prcm_set) && (clk != &virt_vdd2_prcm_set))
 		return -EINVAL;
@@ -1003,7 +1004,9 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 	} else {
 		l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
 			OMAP3430_CLKSEL_L3_MASK;
-		clk_set_rate(dpll3_clk, prcm_vdd->rate * l3_div);
+		ret = clk_set_rate(dpll3_clk, prcm_vdd->rate * l3_div);
+		if (ret)
+			return ret;
 		curr_vdd2_prcm_set = prcm_vdd;
 	}
 
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index aec2bcb..2328323 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -188,6 +188,7 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 	struct cpufreq_freqs freqs_notify;
 #endif
 	struct shared_resource *resp;
+	int ret;
 
 	if (res == VDD1_OPP)
 		resp = vdd1_resp;
@@ -260,7 +261,9 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 			ID_OPP_NO(l3_opps[target_level].opp_id);
 		if (resp->curr_level > target_level) {
 			/* Scale Frequency and then voltage */
-			clk_set_rate(vdd2_clk, l3_freq);
+			ret = clk_set_rate(vdd2_clk, l3_freq);
+			if (ret)
+				return ret;
 #ifdef CONFIG_OMAP_SMARTREFLEX
 			sr_voltagescale_vcbypass(t_opp,
 					l3_opps[target_level].vsel);
@@ -271,7 +274,18 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 			sr_voltagescale_vcbypass(t_opp,
 					l3_opps[target_level].vsel);
 #endif
-			clk_set_rate(vdd2_clk, l3_freq);
+			ret = clk_set_rate(vdd2_clk, l3_freq);
+			if (ret) {
+#ifdef CONFIG_OMAP_SMARTREFLEX
+				/* Setting clock failed, revert voltage */
+				t_opp = ID_VDD(PRCM_VDD2) |
+					ID_OPP_NO(l3_opps[resp->curr_level].
+							opp_id);
+				sr_voltagescale_vcbypass(t_opp,
+					l3_opps[resp->curr_level].vsel);
+#endif
+				return ret;
+			}
 		}
 		resp->curr_level = curr_vdd2_prcm_set->opp_id;
 	}
-- 
1.5.4.3

