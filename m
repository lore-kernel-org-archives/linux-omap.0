From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: RFC: [PATCH] Change VDD2 setopp to use bus throughput
Date: Mon,  1 Dec 2008 19:18:37 +0200
Message-ID: <1228151917-13354-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53588 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbYLARS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 12:18:57 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB1HIe2h015102
	for <linux-omap@vger.kernel.org>; Mon, 1 Dec 2008 11:18:55 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

The following patch changes setopp to use bus throughput as its input instead
of the OPP number. The bus throughput to OPP mapping table is part of the
vdd2_opp resource, which makes it difficult to do this mapping on a higher
level. Comments on other/better approaches welcome !

Cheers,

Peter.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/resource34xx.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 6364818..857cb14 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -164,6 +164,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 	unsigned long mpu_freq, mpu_old_freq, l3_freq, t_opp;
 	int ind;
 	struct cpufreq_freqs freqs_notify;
+	struct bus_throughput_db *tput;
 
 	if (resp->curr_level == target_level)
 		return 0;
@@ -199,15 +200,23 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 		cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
 #endif
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
+		int target_opp;
+
+		tput = (struct bus_throughput_db *)(resp->resource_data);
+		for(target_opp=0; target_opp < MAX_VDD2_OPP; target_opp++) {
+			if (tput->throughput[target_opp] >= target_level)
+				break;
+		}
+
 		l3_freq = get_freq(l3_opps + MAX_VDD2_OPP,
-					target_level);
+					target_opp);
 		t_opp = ID_VDD(PRCM_VDD2) |
-				ID_OPP_NO(l3_opps[target_level].opp_id);
-		if (resp->curr_level > target_level) {
+				ID_OPP_NO(l3_opps[target_opp].opp_id);
+		if (resp->curr_level > target_opp) {
 			/* Scale Frequency and then voltage */
 			clk_set_rate(vdd2_clk, l3_freq);
 			sr_voltagescale_vcbypass(t_opp,
-						l3_opps[target_level].vsel);
+						l3_opps[target_opp].vsel);
 		} else {
 			/* Scale Voltage and then frequency */
 			sr_voltagescale_vcbypass(t_opp,
-- 
1.5.6.3

