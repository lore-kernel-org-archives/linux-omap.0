From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 11/12] OMAP: SRF: update to new device-based OPP API
Date: Wed, 16 Jun 2010 17:17:12 -0700
Message-ID: <1276733833-18510-12-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61763 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759045Ab0FQARk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:40 -0400
Received: by mail-px0-f174.google.com with SMTP id 8so4194812pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:40 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/resource34xx.c |   95 ++++++++++++++++++++++-------------
 1 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 7f39fc3..70b41bc 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -170,14 +170,15 @@ static DEFINE_MUTEX(dvfs_mutex);
  *
  * NOTE: this function is a standin for the timebeing as opp_id is deprecated
  */
-static int __deprecated opp_to_freq(unsigned long *freq, enum opp_t opp_type,
+static int __deprecated opp_to_freq(unsigned long *freq, struct device *dev,
 				 u8 opp_id)
 {
 	struct omap_opp *opp;
 
-	BUG_ON(!freq || opp_type >= OPP_TYPES_MAX);
+	if (WARN_ON(!freq))
+		return -EINVAL;
 
-	opp = opp_find_by_opp_id(opp_type, opp_id);
+	opp = opp_find_by_opp_id(dev, opp_id);
 	if (IS_ERR(opp))
 		return -EINVAL;
 
@@ -189,20 +190,19 @@ static int __deprecated opp_to_freq(unsigned long *freq, enum opp_t opp_type,
 /**
  * freq_to_opp - convert a frequency back to OPP ID (DEPRECATED)
  * @opp_id: opp ID returned back to caller
- * @opp_type: OPP type where we need to look.
+ * @opp_dev: device where we need to look for OPPs
  * @freq: frequency we are searching for
  *
  * return 0 and opp_id is populated if we find the freq, else, we return error
  *
  * NOTE: this function is a standin for the timebeing as opp_id is deprecated
  */
-static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_type,
+static int __deprecated freq_to_opp(u8 *opp_id, struct device *dev,
 		unsigned long freq)
 {
 	struct omap_opp *opp;
 
-	BUG_ON(opp_type >= OPP_TYPES_MAX);
-	opp = opp_find_freq_ceil(opp_type, &freq);
+	opp = opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp))
 		return -EINVAL;
 	*opp_id = opp_get_opp_id(opp);
@@ -223,10 +223,12 @@ void init_opp(struct shared_resource *resp)
 	* to the  opp set by u-boot.
 	*/
 	if (strcmp(resp->name, "vdd1_opp") == 0) {
+		struct device *dev = omap_get_mpu_device();
+
 		vdd1_resp = resp;
 		dpll1_clk = clk_get(NULL, "dpll1_ck");
 		dpll2_clk = clk_get(NULL, "dpll2_ck");
-		ret = freq_to_opp(&opp_id, OPP_MPU, dpll1_clk->rate);
+		ret = freq_to_opp(&opp_id, dev, dpll1_clk->rate);
 		if (ret) {
 			pr_err("%s: initializing %s failed! !match for %ld\n",
 				__func__, resp->name, dpll1_clk->rate);
@@ -241,10 +243,12 @@ void init_opp(struct shared_resource *resp)
 		}
 		curr_vdd1_opp = opp_id;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
+		struct device *dev = omap_get_l3_device();
+
 		vdd2_resp = resp;
 		dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
 		l3_clk = clk_get(NULL, "l3_ick");
-		ret = freq_to_opp(&opp_id, OPP_L3, l3_clk->rate);
+		ret = freq_to_opp(&opp_id, dev, l3_clk->rate);
 		if (ret) {
 			pr_err("%s: initializing %s failed! !match for %ld\n",
 				__func__, resp->name, l3_clk->rate);
@@ -305,16 +309,20 @@ static int program_opp_freq(int res, int target_level, int current_level)
 #ifndef CONFIG_CPU_FREQ
 	unsigned long mpu_cur_freq;
 #endif
+	struct device *l3_dev = omap_get_l3_device();
 
 	/* Check if I can actually switch or not */
 	if (res == VDD1_OPP) {
-		ret = opp_to_freq(&mpu_freq, OPP_MPU, target_level);
-		ret |= opp_to_freq(&dsp_freq, OPP_DSP, target_level);
+		struct device *mpu_dev = omap_get_mpu_device();
+		struct device *dsp_dev = omap_get_dsp_device();
+
+		ret = opp_to_freq(&mpu_freq, mpu_dev, target_level);
+		ret |= opp_to_freq(&dsp_freq, dsp_dev, target_level);
 #ifndef CONFIG_CPU_FREQ
-		ret |= opp_to_freq(&mpu_cur_freq, OPP_MPU, current_level);
+		ret |= opp_to_freq(&mpu_cur_freq, mpu_dev, current_level);
 #endif
 	} else {
-		ret = opp_to_freq(&l3_freq, OPP_L3, target_level);
+		ret = opp_to_freq(&l3_freq, l3_dev, target_level);
 	}
 	/* we would have caught all bad levels earlier.. */
 	if (unlikely(ret))
@@ -349,14 +357,14 @@ static int program_opp_freq(int res, int target_level, int current_level)
 	return target_level;
 }
 
-static int program_opp(int res, enum opp_t opp_type, int target_level,
+static int program_opp(int res, struct device *dev, int target_level,
 		int current_level)
 {
 	int i, ret = 0, raise;
 	unsigned long freq;
 
 	/* See if have a freq associated, if not, invalid opp */
-	ret = opp_to_freq(&freq, opp_type, target_level);
+	ret = opp_to_freq(&freq, dev, target_level);
 	if (unlikely(ret))
 		return ret;
 
@@ -379,12 +387,12 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
 			 * transitioning from good to good OPP
 			 * none of the following should fail..
 			 */
-			oppx = opp_find_freq_exact(opp_type, freq, true);
+			oppx = opp_find_freq_exact(dev, freq, true);
 			BUG_ON(IS_ERR(oppx));
 			uvdc_target = opp_get_voltage(oppx);
 
-			BUG_ON(opp_to_freq(&freq, opp_type, current_level));
-			oppx = opp_find_freq_exact(opp_type, freq, true);
+			BUG_ON(opp_to_freq(&freq, dev, current_level));
+			oppx = opp_find_freq_exact(dev, freq, true);
 			BUG_ON(IS_ERR(oppx));
 			uvdc_current = opp_get_voltage(oppx);
 
@@ -405,6 +413,9 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 	struct cpufreq_freqs freqs_notify;
 #endif
 	struct shared_resource *resp;
+	struct device *mpu_dev = omap_get_mpu_device();
+	struct device *dsp_dev = omap_get_dsp_device();
+	struct device *l3_dev = omap_get_l3_device();
 
 	if (res == VDD1_OPP)
 		resp = vdd1_resp;
@@ -418,10 +429,10 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 
 	/* Check if I can actually switch or not */
 	if (res == VDD1_OPP) {
-		ret = opp_to_freq(&mpu_freq, OPP_MPU, target_level);
-		ret |= opp_to_freq(&mpu_old_freq, OPP_MPU, resp->curr_level);
+		ret = opp_to_freq(&mpu_freq, mpu_dev, target_level);
+		ret |= opp_to_freq(&mpu_old_freq, mpu_dev, resp->curr_level);
 	} else {
-		ret = opp_to_freq(&l3_freq, OPP_L3, target_level);
+		ret = opp_to_freq(&l3_freq, l3_dev, target_level);
 	}
 	if (ret)
 		return ret;
@@ -440,7 +451,7 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 		/* Send pre notification to CPUFreq */
 		cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
 #endif
-		resp->curr_level = program_opp(res, OPP_MPU, target_level,
+		resp->curr_level = program_opp(res, mpu_dev, target_level,
 			resp->curr_level);
 #ifdef CONFIG_CPU_FREQ
 		/* Send a post notification to CPUFreq */
@@ -451,7 +462,7 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 			mutex_unlock(&dvfs_mutex);
 			return 0;
 		}
-		resp->curr_level = program_opp(res, OPP_L3, target_level,
+		resp->curr_level = program_opp(res, l3_dev, target_level,
 			resp->curr_level);
 	}
 	mutex_unlock(&dvfs_mutex);
@@ -478,23 +489,24 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 	} else if (resp == vdd2_resp) {
 		unsigned long req_l3_freq;
 		struct omap_opp *oppx = NULL;
+		struct device *l3_dev = omap_get_l3_device();
 
 		/* Convert the tput in KiB/s to Bus frequency in MHz */
 		req_l3_freq = (target_level * 1000)/4;
 
 		/* Do I have a best match? */
-		oppx = opp_find_freq_ceil(OPP_L3, &req_l3_freq);
+		oppx = opp_find_freq_ceil(l3_dev, &req_l3_freq);
 		if (IS_ERR(oppx)) {
 			/* Give me the best we got */
 			req_l3_freq = ULONG_MAX;
-			oppx = opp_find_freq_floor(OPP_L3, &req_l3_freq);
+			oppx = opp_find_freq_floor(l3_dev, &req_l3_freq);
 		}
 
 		/* uh uh.. no OPPs?? */
 		BUG_ON(IS_ERR(oppx));
 
 		target_level = 0;
-		ret = freq_to_opp((u8 *)&target_level, OPP_L3, req_l3_freq);
+		ret = freq_to_opp((u8 *)&target_level, l3_dev, req_l3_freq);
 		/* we dont expect this to fail */
 		BUG_ON(ret);
 
@@ -512,10 +524,13 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 int validate_opp(struct shared_resource *resp, u32 target_level)
 {
 	unsigned long x;
+	struct device *mpu_dev = omap_get_mpu_device();
+	struct device *dsp_dev = omap_get_dsp_device();
+
 	if (strcmp(resp->name, "mpu_freq") == 0)
-		return opp_to_freq(&x, OPP_MPU, target_level);
+		return opp_to_freq(&x, mpu_dev, target_level);
 	else if (strcmp(resp->name, "dsp_freq") == 0)
-		return opp_to_freq(&x, OPP_DSP, target_level);
+		return opp_to_freq(&x, dsp_dev, target_level);
 	return 0;
 }
 
@@ -527,6 +542,9 @@ void init_freq(struct shared_resource *resp)
 	char *linked_res_name;
 	int ret = -EINVAL;
 	unsigned long freq = 0;
+	struct device *mpu_dev = omap_get_mpu_device();
+	struct device *dsp_dev = omap_get_dsp_device();
+
 	resp->no_of_users = 0;
 
 	linked_res_name = (char *)resp->resource_data;
@@ -535,14 +553,16 @@ void init_freq(struct shared_resource *resp)
 	*/
 	if (strcmp(resp->name, "mpu_freq") == 0)
 		/* MPU freq in Mhz */
-		ret = opp_to_freq(&freq, OPP_MPU, curr_vdd1_opp);
+		ret = opp_to_freq(&freq, mpu_dev, curr_vdd1_opp);
 	else if (strcmp(resp->name, "dsp_freq") == 0)
 		/* DSP freq in Mhz */
-		ret = opp_to_freq(&freq, OPP_DSP, curr_vdd1_opp);
+		ret = opp_to_freq(&freq, dsp_dev, curr_vdd1_opp);
 	if (ret)
-		pr_err("%s: initializing frequency failed!\n", __func__);
+		pr_err("%s: initializing frequency failed for %s!\n",
+		       __func__, resp->name);
 
 	resp->curr_level = freq;
+
 	return;
 }
 
@@ -550,14 +570,16 @@ int set_freq(struct shared_resource *resp, u32 target_level)
 {
 	u8 vdd1_opp;
 	int ret = -EINVAL;
+	struct device *mpu_dev = omap_get_mpu_device();
+	struct device *dsp_dev = omap_get_dsp_device();
 
 	if (strcmp(resp->name, "mpu_freq") == 0) {
-		ret = freq_to_opp(&vdd1_opp, OPP_MPU, target_level);
+		ret = freq_to_opp(&vdd1_opp, mpu_dev, target_level);
 		if (!ret)
 			ret = resource_request("vdd1_opp", &dummy_mpu_dev,
 					vdd1_opp);
 	} else if (strcmp(resp->name, "dsp_freq") == 0) {
-		ret = freq_to_opp(&vdd1_opp, OPP_DSP, target_level);
+		ret = freq_to_opp(&vdd1_opp, dsp_dev, target_level);
 		if (!ret)
 			ret = resource_request("vdd1_opp", &dummy_dsp_dev,
 					vdd1_opp);
@@ -570,9 +592,12 @@ int set_freq(struct shared_resource *resp, u32 target_level)
 int validate_freq(struct shared_resource *resp, u32 target_level)
 {
 	u8 x;
+	struct device *mpu_dev = omap_get_mpu_device();
+	struct device *dsp_dev = omap_get_dsp_device();
+
 	if (strcmp(resp->name, "mpu_freq") == 0)
-		return freq_to_opp(&x, OPP_MPU, target_level);
+		return freq_to_opp(&x, mpu_dev, target_level);
 	else if (strcmp(resp->name, "dsp_freq") == 0)
-		return freq_to_opp(&x, OPP_DSP, target_level);
+		return freq_to_opp(&x, dsp_dev, target_level);
 	return 0;
 }
-- 
1.7.0.2

