From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/2] Fix omap_getspeed.
Date: Tue,  2 Dec 2008 17:31:16 +0200
Message-ID: <1228231877-18114-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1228231877-18114-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19759 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbYLBPbh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 10:31:37 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB2FVE63027724
	for <linux-omap@vger.kernel.org>; Tue, 2 Dec 2008 17:31:35 +0200
In-Reply-To: <1228231877-18114-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |    1 +
 arch/arm/plat-omap/cpu-omap.c   |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index f771b56..da27e49 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -938,6 +938,7 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 
 	if (clk == &virt_vdd1_prcm_set) {
 		curr_mpu_speed = curr_vdd1_prcm_set->rate;
+		clk->rate = prcm_vdd->rate;
 		clk_set_rate(dpll1_clk, prcm_vdd->rate);
 		clk_set_rate(dpll2_clk, dsp_opps[index].rate);
 		curr_vdd1_prcm_set = prcm_vdd;
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index ae0817d..0a7ce46 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -146,6 +146,12 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 							VERY_HI_RATE) / 1000;
 	}
 
+	clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
+
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
+	policy->cur = omap_getspeed(0);
+
 	/* FIXME: what's the actual transition time? */
 	policy->cpuinfo.transition_latency = 10 * 1000 * 1000;
 	return 0;
-- 
1.5.6.3

