From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 07/08] OMAP3 SRF: VDD2 scaling support
Date: Mon, 10 Nov 2008 16:59:02 +0530
Message-ID: <00c501c94327$8822d720$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50571 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499AbYKJL3K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:29:10 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAABT3f7028042
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 05:29:09 -0600
Received: from wipultra1382 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAABT2HX013100
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 16:59:02 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Adds VDD2 scaling support and updates
omap_pm_set_min_bus_tput API.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |   63 ++++++++++++++++++++++++++++---------
 arch/arm/plat-omap/omap-pm-srf.c   |   15 ++------
 2 files changed, 53 insertions(+), 25 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.c	2008-11-10 15:44:18.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-11-10 15:38:00.000000000 +0530
@@ -134,7 +134,8 @@ int set_pd_latency(struct shared_resourc
 
 static struct clk *vdd1_clk;
 static struct clk *vdd2_clk;
-static struct device dummy_srf_dev;
+static struct device dummy_mpu_dev;
+static struct device dummy_dsp_dev;
 
 /**
  * init_opp - Initialize the OPP resource
@@ -157,7 +158,9 @@ void init_opp(struct shared_resource *re
 
 int set_opp(struct shared_resource *resp, u32 target_level)
 {
-	unsigned long mpu_freq;
+	unsigned long mpu_freq, l3_freq, tput, t_opp;;
+	int ind;
+	struct bus_throughput_db *tput_db;
 
 	if (resp->curr_level == target_level)
 		return 0;
@@ -165,20 +168,53 @@ int set_opp(struct shared_resource *resp
 	if (strcmp(resp->name, "vdd1_opp") == 0) {
 		mpu_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
 					target_level);
+		t_opp = ID_VDD(PRCM_VDD1) |
+			ID_OPP_NO(mpu_opps[target_level].opp_id);
 		if (resp->curr_level > target_level) {
 			/* Scale Frequency and then voltage */
 			clk_set_rate(vdd1_clk, mpu_freq);
-			sr_voltagescale_vcbypass(PRCM_VDD1,
-					mpu_opps[target_level-1].vsel);
+			sr_voltagescale_vcbypass(t_opp,
+					mpu_opps[target_level].vsel);
 		} else {
 			/* Scale Voltage and then frequency */
-			sr_voltagescale_vcbypass(PRCM_VDD1,
-					mpu_opps[target_level-1].vsel);
+			sr_voltagescale_vcbypass(t_opp,
+					mpu_opps[target_level].vsel);
 			clk_set_rate(vdd1_clk, mpu_freq);
 		}
 		resp->curr_level = curr_vdd1_prcm_set->opp_id;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
-		/* Not supported yet */
+		tput_db = resp->resource_data;
+		tput = target_level;
+		/* using the throughput db map to the appropriate L3 Freq */
+		for (ind = 1; ind < MAX_VDD2_OPP; ind++)
+			if (tput_db->throughput[ind] > tput)
+				target_level = ind;
+
+		/* Set the highest OPP possible */
+		if (ind == MAX_VDD2_OPP)
+			target_level = ind-1;
+
+		if (resp->curr_level == target_level)
+			return 0;
+
+		resp->curr_level = target_level;
+
+		l3_freq = get_freq(l3_opps + MAX_VDD2_OPP,
+					target_level);
+		t_opp = ID_VDD(PRCM_VDD2) |
+			ID_OPP_NO(l3_opps[target_level].opp_id);
+		if (resp->curr_level > target_level) {
+			/* Scale Frequency and then voltage */
+			clk_set_rate(vdd2_clk, l3_freq);
+			sr_voltagescale_vcbypass(t_opp,
+					l3_opps[target_level].vsel);
+		} else {
+			/* Scale Voltage and then frequency */
+			sr_voltagescale_vcbypass(t_opp,
+					l3_opps[target_level].vsel);
+			clk_set_rate(vdd2_clk, l3_freq);
+		}
+		resp->curr_level = curr_vdd2_prcm_set->opp_id;
 	}
 	return 0;
 }
@@ -220,16 +256,13 @@ int set_freq(struct shared_resource *res
 {
 	unsigned int vdd1_opp;
 
-	if (strcmp(resp->name, "mpu_freq") == 0)
+	if (strcmp(resp->name, "mpu_freq") == 0) {
 		vdd1_opp = get_opp(mpu_opps + MAX_VDD1_OPP, target_level);
-	else if (strcmp(resp->name, "dsp_freq") == 0)
+		resource_request("vdd1_opp", &dummy_mpu_dev, vdd1_opp);
+	} else if (strcmp(resp->name, "dsp_freq") == 0) {
 		vdd1_opp = get_opp(dsp_opps + MAX_VDD1_OPP, target_level);
-
-	if (vdd1_opp == MIN_VDD1_OPP)
-		resource_release("vdd1_opp", &dummy_srf_dev);
-	else
-		resource_request("vdd1_opp", &dummy_srf_dev, vdd1_opp);
-
+		resource_request("vdd1_opp", &dummy_dsp_dev, vdd1_opp);
+	}
 	resp->curr_level = target_level;
 	return 0;
 }
Index: linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/omap-pm-srf.c	2008-11-10 15:44:18.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c	2008-11-10 15:44:19.000000000 +0530
@@ -82,21 +82,16 @@ void omap_pm_set_min_bus_tput(struct dev
 		return;
 	};
 
-	if (r == 0)
+	if (r == 0) {
 		pr_debug("OMAP PM: remove min bus tput constraint: "
 			 "dev %s for agent_id %d\n", dev_name(dev), agent_id);
-	else
+		resource_release("vdd2_opp", dev);
+	} else {
 		pr_debug("OMAP PM: add min bus tput constraint: "
 			 "dev %s for agent_id %d: rate %ld KiB\n",
 			 dev_name(dev), agent_id, r);
-
-	/*
-	 * This code should model the interconnect and compute the
-	 * required clock frequency, convert that to a VDD2 OPP ID, then
-	 * set the VDD2 OPP appropriately.
-	 *
-	 * TI CDP code can call constraint_set here on the VDD2 OPP.
-	 */
+		resource_request("vdd2_opp", dev, r);
+	}
 }
 
 void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)

