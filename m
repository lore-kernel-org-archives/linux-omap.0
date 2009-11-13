From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/9] omap3: pm: srf: use opp accessor function
Date: Fri, 13 Nov 2009 00:05:16 -0600
Message-ID: <1258092322-30833-4-git-send-email-nm@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>
 <1258092322-30833-2-git-send-email-nm@ti.com>
 <1258092322-30833-3-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37267 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbZKMGFV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 01:05:21 -0500
In-Reply-To: <1258092322-30833-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

With the accessor functions, many of the direct accesses are
redundant. Cleanup of SRF to:
a) Remove get_opp as it redundant as freq_to_opp does exactly the
   samething.
b) Remove any direct dereference of opp tables except thru accessor
   functions.

NOTE: the implementation is just a start and leaves scope for
further performance and robustness improvements which can be added on
top.

Tested on: SDP3430, SDP3630

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: SuiLun Lam <s-lam@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |  178 ++++++++++++++++++++++--------------
 1 files changed, 109 insertions(+), 69 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index af6b3c1..15b5cb6 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -155,29 +155,14 @@ static int curr_vdd1_opp;
 static int curr_vdd2_opp;
 static DEFINE_MUTEX(dvfs_mutex);
 
-static unsigned short get_opp(struct omap_opp *opp_freq_table,
-		unsigned long freq)
-{
-	struct omap_opp *prcm_config;
-	prcm_config = opp_freq_table;
-
-	if (prcm_config->rate <= freq)
-		return prcm_config->opp_id; /* Return the Highest OPP */
-	for (; prcm_config->rate; prcm_config--)
-		if (prcm_config->rate < freq)
-			return (prcm_config+1)->opp_id;
-		else if (prcm_config->rate == freq)
-			return prcm_config->opp_id;
-	/* Return the least OPP */
-	return (prcm_config+1)->opp_id;
-}
-
 /**
  * init_opp - Initialize the OPP resource
  */
 void init_opp(struct shared_resource *resp)
 {
 	struct clk *l3_clk;
+	int ret;
+	u8 opp_id;
 	resp->no_of_users = 0;
 
 	if (!mpu_opps || !dsp_opps || !l3_opps)
@@ -190,17 +175,18 @@ void init_opp(struct shared_resource *resp)
 		vdd1_resp = resp;
 		dpll1_clk = clk_get(NULL, "dpll1_ck");
 		dpll2_clk = clk_get(NULL, "dpll2_ck");
-		resp->curr_level = get_opp(mpu_opps + MAX_VDD1_OPP,
-				dpll1_clk->rate);
-		curr_vdd1_opp = resp->curr_level;
+		ret = freq_to_opp(&opp_id, mpu_opps, dpll1_clk->rate);
+		BUG_ON(ret); /* TBD Cleanup handling */
+		curr_vdd1_opp = opp_id;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		vdd2_resp = resp;
 		dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
 		l3_clk = clk_get(NULL, "l3_ick");
-		resp->curr_level = get_opp(l3_opps + MAX_VDD2_OPP,
-				l3_clk->rate);
-		curr_vdd2_opp = resp->curr_level;
+		ret = freq_to_opp(&opp_id, l3_opps, l3_clk->rate);
+		BUG_ON(ret); /* TBD Cleanup handling */
+		curr_vdd2_opp = opp_id;
 	}
+	resp->curr_level = opp_id;
 	return;
 }
 
@@ -242,24 +228,40 @@ static int program_opp_freq(int res, int target_level, int current_level)
 {
 	int ret = 0, l3_div;
 	int *curr_opp;
+	unsigned long mpu_freq, dsp_freq, l3_freq;
+#ifndef CONFIG_CPU_FREQ
+	unsigned long mpu_cur_freq
+#endif
+
+	/* Check if I can actually switch or not */
+	if (res == VDD1_OPP) {
+		ret = opp_to_freq(&mpu_freq, mpu_opps, target_level);
+		ret |= opp_to_freq(&dsp_freq, dsp_opps, target_level);
+#ifndef CONFIG_CPU_FREQ
+		ret |= opp_to_freq(&mpu_cur_freq, mpu_opps, current_level);
+#endif
+	} else {
+		ret = opp_to_freq(&l3_freq, l3_opps, target_level);
+	}
+	/* we would have caught all bad levels earlier.. */
+	if (unlikely(ret))
+		return ret;
 
 	lock_scratchpad_sem();
 	if (res == VDD1_OPP) {
 		curr_opp = &curr_vdd1_opp;
-		clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
-		clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
+		clk_set_rate(dpll1_clk, mpu_freq);
+		clk_set_rate(dpll2_clk, dsp_freq);
 #ifndef CONFIG_CPU_FREQ
 		/*Update loops_per_jiffy if processor speed is being changed*/
 		loops_per_jiffy = compute_lpj(loops_per_jiffy,
-			mpu_opps[current_level].rate/1000,
-			mpu_opps[target_level].rate/1000);
+			mpu_cur_freq / 1000, mpu_freq / 1000);
 #endif
 	} else {
 		curr_opp = &curr_vdd2_opp;
 		l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
 			OMAP3430_CLKSEL_L3_MASK;
-		ret = clk_set_rate(dpll3_clk,
-				l3_opps[target_level].rate * l3_div);
+		ret = clk_set_rate(dpll3_clk, l3_freq * l3_div);
 	}
 	if (ret) {
 		unlock_scratchpad_sem();
@@ -278,6 +280,7 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 		int current_level)
 {
 	int i, ret = 0, raise;
+	unsigned long freq;
 #ifdef CONFIG_OMAP_SMARTREFLEX
 	unsigned long t_opp, c_opp;
 
@@ -285,13 +288,10 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level].opp_id);
 #endif
 
-	/* Only allow enabled OPPs */
-	if (!opp[target_level].enabled)
-		return -EINVAL;
-
-	/* Sanity check of the OPP params before attempting to set */
-	if (!opp[target_level].rate || !opp[target_level].vsel)
-		return -EINVAL;
+	/* See if have a freq associated, if not, invalid opp */
+	ret = opp_to_freq(&freq, opp, target_level);
+	if (unlikely(ret))
+		return ret;
 
 	if (target_level > current_level)
 		raise = 1;
@@ -303,10 +303,16 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 			ret = program_opp_freq(res, target_level,
 					current_level);
 #ifdef CONFIG_OMAP_SMARTREFLEX
-		else
+		else {
+			u8 v_current, v_target;
+			/* none of the following should fail.. */
+			BUG_ON(freq_to_vsel(&v_target, opp, freq));
+			BUG_ON(opp_to_freq(&freq, opp, current_level));
+			BUG_ON(freq_to_vsel(&v_current, opp, freq));
+			/* ok to scale.. */
 			sr_voltagescale_vcbypass(t_opp, c_opp,
-				opp[target_level].vsel,
-				opp[current_level].vsel);
+				v_target, v_current);
+		}
 #endif
 	}
 
@@ -315,7 +321,8 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 
 int resource_set_opp_level(int res, u32 target_level, int flags)
 {
-	unsigned long mpu_freq, mpu_old_freq;
+	unsigned long mpu_freq, mpu_old_freq, l3_freq;
+	int ret;
 #ifdef CONFIG_CPU_FREQ
 	struct cpufreq_freqs freqs_notify;
 #endif
@@ -334,6 +341,16 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 	if (!mpu_opps || !dsp_opps || !l3_opps)
 		return 0;
 
+	/* Check if I can actually switch or not */
+	if (res == VDD1_OPP) {
+		ret = opp_to_freq(&mpu_freq, mpu_opps, target_level);
+		ret |= opp_to_freq(&mpu_old_freq, mpu_opps, resp->curr_level);
+	} else {
+		ret = opp_to_freq(&l3_freq, l3_opps, target_level);
+	}
+	if (ret)
+		return ret;
+
 	mutex_lock(&dvfs_mutex);
 
 	if (res == VDD1_OPP) {
@@ -341,9 +358,6 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 			mutex_unlock(&dvfs_mutex);
 			return 0;
 		}
-		mpu_old_freq = mpu_opps[resp->curr_level].rate;
-		mpu_freq = mpu_opps[target_level].rate;
-
 #ifdef CONFIG_CPU_FREQ
 		freqs_notify.old = mpu_old_freq/1000;
 		freqs_notify.new = mpu_freq/1000;
@@ -371,15 +385,13 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 
 int set_opp(struct shared_resource *resp, u32 target_level)
 {
-	unsigned long tput;
-	unsigned long req_l3_freq;
-	int ind;
+	int ret = -EINVAL;
 
 	if (resp == vdd1_resp) {
 		if (target_level < 3)
 			resource_release("vdd2_opp", &vdd2_dev);
 
-		resource_set_opp_level(VDD1_OPP, target_level, 0);
+		ret = resource_set_opp_level(VDD1_OPP, target_level, 0);
 		/*
 		 * For VDD1 OPP3 and above, make sure the interconnect
 		 * is at 100Mhz or above.
@@ -389,21 +401,28 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 			resource_request("vdd2_opp", &vdd2_dev, 400000);
 
 	} else if (resp == vdd2_resp) {
-		tput = target_level;
+		unsigned long req_l3_freq;
 
 		/* Convert the tput in KiB/s to Bus frequency in MHz */
-		req_l3_freq = (tput * 1000)/4;
-
-		for (ind = 2; ind <= MAX_VDD2_OPP; ind++)
-			if ((l3_opps + ind)->rate >= req_l3_freq) {
-				target_level = ind;
-				break;
-			}
-
-		/* Set the highest OPP possible */
-		if (ind > MAX_VDD2_OPP)
-			target_level = ind-1;
-		resource_set_opp_level(VDD2_OPP, target_level, 0);
+		req_l3_freq = (target_level * 1000)/4;
+
+		/* Get the best freq around */
+		ret = get_next_freq(&req_l3_freq, l3_opps, true, true, false);
+
+		/* If we dont find a good freq, then use the highest
+		 * possible freq
+		 */
+		if (ret)
+			ret = get_limit_freq(&req_l3_freq, l3_opps, true, true);
+
+		/* uh uh.. no OPPs?? */
+		BUG_ON(ret);
+
+		ret = freq_to_opp((u8 *)&target_level, l3_opps, req_l3_freq);
+		/* we dont expect this to fail */
+		BUG_ON(ret);
+
+		ret = resource_set_opp_level(VDD2_OPP, target_level, 0);
 	}
 	return 0;
 }
@@ -416,6 +435,11 @@ int set_opp(struct shared_resource *resp, u32 target_level)
  */
 int validate_opp(struct shared_resource *resp, u32 target_level)
 {
+	unsigned long x;
+	if (strcmp(resp->name, "mpu_freq") == 0)
+		return opp_to_freq(&x, mpu_opps, target_level);
+	else if (strcmp(resp->name, "dsp_freq") == 0)
+		return opp_to_freq(&x, dsp_opps, target_level);
 	return 0;
 }
 
@@ -425,6 +449,8 @@ int validate_opp(struct shared_resource *resp, u32 target_level)
 void init_freq(struct shared_resource *resp)
 {
 	char *linked_res_name;
+	int ret = -EINVAL;
+	unsigned long freq;
 	resp->no_of_users = 0;
 
 	if (!mpu_opps || !dsp_opps)
@@ -436,32 +462,46 @@ void init_freq(struct shared_resource *resp)
 	*/
 	if (strcmp(resp->name, "mpu_freq") == 0)
 		/* MPU freq in Mhz */
-		resp->curr_level = mpu_opps[curr_vdd1_opp].rate;
+		ret = opp_to_freq(&freq, mpu_opps, curr_vdd1_opp);
 	else if (strcmp(resp->name, "dsp_freq") == 0)
 		/* DSP freq in Mhz */
-		resp->curr_level = dsp_opps[curr_vdd1_opp].rate;
+		ret = opp_to_freq(&freq, dsp_opps, curr_vdd1_opp);
+	BUG_ON(ret);
+
+	resp->curr_level = freq;
 	return;
 }
 
 int set_freq(struct shared_resource *resp, u32 target_level)
 {
-	unsigned int vdd1_opp;
+	u8 vdd1_opp;
+	int ret = -EINVAL;
 
 	if (!mpu_opps || !dsp_opps)
 		return 0;
 
 	if (strcmp(resp->name, "mpu_freq") == 0) {
-		vdd1_opp = get_opp(mpu_opps + MAX_VDD1_OPP, target_level);
-		resource_request("vdd1_opp", &dummy_mpu_dev, vdd1_opp);
+		ret = freq_to_opp(&vdd1_opp, mpu_opps, target_level);
+		if (!ret)
+			ret = resource_request("vdd1_opp", &dummy_mpu_dev,
+					vdd1_opp);
 	} else if (strcmp(resp->name, "dsp_freq") == 0) {
-		vdd1_opp = get_opp(dsp_opps + MAX_VDD1_OPP, target_level);
-		resource_request("vdd1_opp", &dummy_dsp_dev, vdd1_opp);
+		ret = freq_to_opp(&vdd1_opp, dsp_opps, target_level);
+		if (!ret)
+			ret = resource_request("vdd1_opp", &dummy_dsp_dev,
+					vdd1_opp);
 	}
-	resp->curr_level = target_level;
-	return 0;
+	if (!ret)
+		resp->curr_level = target_level;
+	return ret;
 }
 
 int validate_freq(struct shared_resource *resp, u32 target_level)
 {
+	u8 x;
+	if (strcmp(resp->name, "mpu_freq") == 0)
+		return freq_to_opp(&x, mpu_opps, target_level);
+	else if (strcmp(resp->name, "dsp_freq") == 0)
+		return freq_to_opp(&x, dsp_opps, target_level);
 	return 0;
 }
-- 
1.6.3.3

