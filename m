From: Romit Dasgupta <romit@ti.com>
Subject: [PM-WIP-OPP] [PATCH 1/2]: Introducing enum for OPP types
Date: Fri, 15 Jan 2010 16:33:00 +0530
Message-ID: <1263553380.3490.43.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59508 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0AOLDH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 06:03:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: nm@ti.com, linux-omap@vger.kernel.org

Using omap_opp * to refer to domain types restricts opp implementation
into maintaining pointers outside the opp layer. This causes issues such
as:
a) Describing cross domain dependencies (e.g. dsp vs mpu)

b) Ease of transitioning/supporting to multiple silicon variants and
families

c) Choice of varied options in implementing opp layer internals.

Since all we need a identifying a specific domain for query/operational 
purposes, we introduce enum for identifying OPP types instead of using 
opp layer's internal data structure pointer.
 
Currently, OMAP3 is the only silicon supporting the OPP layer, hence 
mpu_opps, l3_opps and dsp_opps are deprecated and replaced with
OPP_MPU, 
OPP_L3 and OPP_DSP respectively.

Signed-off-by: Romit Dasgupta <romit@ti.com>
---

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5c751c1..0930aef 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1347,7 +1347,6 @@ static void __init configure_vc(void)
 
 void __init omap3_pm_init_opp_table(void)
 {
-	int i;
 	struct omap_opp_def **omap3_opp_def_list;
 	struct omap_opp_def *omap34xx_opp_def_list[] = {
 		omap34xx_mpu_rate_table,
@@ -1359,19 +1358,13 @@ void __init omap3_pm_init_opp_table(void)
 		omap36xx_l3_rate_table,
 		omap36xx_dsp_rate_table
 	};
-	struct omap_opp **omap3_rate_tables[] = {
-		&mpu_opps,
-		&l3_opps,
-		&dsp_opps
-	};
 
 	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
 				omap34xx_opp_def_list;
-	for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
-		*omap3_rate_tables[i] = opp_init_list(omap3_opp_def_list[i]);
-		/* We dont want half configured system at the moment */
-		BUG_ON(IS_ERR(omap3_rate_tables[i]));
-	}
+
+	BUG_ON(opp_init_list(OPP_MPU, omap3_opp_def_list[0]));
+	BUG_ON(opp_init_list(OPP_L3, omap3_opp_def_list[1]));
+	BUG_ON(opp_init_list(OPP_DSP, omap3_opp_def_list[2]));
 }
 
 static int __init omap3_pm_early_init(void)
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 157b38e..5ec072e 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -161,7 +161,7 @@ static DEFINE_MUTEX(dvfs_mutex);
 /**
  * opp_to_freq - convert OPPID to frequency (DEPRECATED)
  * @freq: return frequency back to caller
- * @opps: opp list
+ * @opp_t: OPP type where we need to look.
  * @opp_id: OPP ID we are searching for
  *
  * return 0 and freq is populated if we find the opp_id, else,
@@ -169,14 +169,14 @@ static DEFINE_MUTEX(dvfs_mutex);
  *
  * NOTE: this function is a standin for the timebeing as opp_id is deprecated
  */
-static int __deprecated opp_to_freq(unsigned long *freq,
-		const struct omap_opp *opps, u8 opp_id)
+static int __deprecated opp_to_freq(unsigned long *freq, enum opp_t opp_t,
+				 u8 opp_id)
 {
 	struct omap_opp *opp;
 
-	BUG_ON(!freq || !opps);
+	BUG_ON(!freq || opp_t >= OPP_TYPES_MAX);
 
-	opp = opp_find_by_opp_id(opps, opp_id);
+	opp = opp_find_by_opp_id(opp_t, opp_id);
 	if (!opp)
 		return -EINVAL;
 
@@ -188,20 +188,20 @@ static int __deprecated opp_to_freq(unsigned long *freq,
 /**
  * freq_to_opp - convert a frequency back to OPP ID (DEPRECATED)
  * @opp_id: opp ID returned back to caller
- * @opps: opp list
+ * @opp_t: OPP type where we need to look.
  * @freq: frequency we are searching for
  *
  * return 0 and opp_id is populated if we find the freq, else, we return error
  *
  * NOTE: this function is a standin for the timebeing as opp_id is deprecated
  */
-static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
+static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_t,
 		unsigned long freq)
 {
 	struct omap_opp *opp;
 
-	BUG_ON(!opp_id || !opps);
-	opp = opp_find_freq_ceil(opps, &freq);
+	BUG_ON(opp_t >= OPP_TYPES_MAX);
+	opp = opp_find_freq_ceil(opp_t, &freq);
 	if (IS_ERR(opp))
 		return -EINVAL;
 	*opp_id = opp_get_opp_id(opp);
@@ -218,9 +218,6 @@ void init_opp(struct shared_resource *resp)
 	u8 opp_id;
 	resp->no_of_users = 0;
 
-	if (!mpu_opps || !dsp_opps || !l3_opps)
-		return;
-
 	/* Initialize the current level of the OPP resource
 	* to the  opp set by u-boot.
 	*/
@@ -228,14 +225,14 @@ void init_opp(struct shared_resource *resp)
 		vdd1_resp = resp;
 		dpll1_clk = clk_get(NULL, "dpll1_ck");
 		dpll2_clk = clk_get(NULL, "dpll2_ck");
-		ret = freq_to_opp(&opp_id, mpu_opps, dpll1_clk->rate);
+		ret = freq_to_opp(&opp_id, OPP_MPU, dpll1_clk->rate);
 		BUG_ON(ret); /* TBD Cleanup handling */
 		curr_vdd1_opp = opp_id;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		vdd2_resp = resp;
 		dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
 		l3_clk = clk_get(NULL, "l3_ick");
-		ret = freq_to_opp(&opp_id, l3_opps, l3_clk->rate);
+		ret = freq_to_opp(&opp_id, OPP_L3, l3_clk->rate);
 		BUG_ON(ret); /* TBD Cleanup handling */
 		curr_vdd2_opp = opp_id;
 	}
@@ -288,13 +285,13 @@ static int program_opp_freq(int res, int target_level, int current_level)
 
 	/* Check if I can actually switch or not */
 	if (res == VDD1_OPP) {
-		ret = opp_to_freq(&mpu_freq, mpu_opps, target_level);
-		ret |= opp_to_freq(&dsp_freq, dsp_opps, target_level);
+		ret = opp_to_freq(&mpu_freq, OPP_MPU, target_level);
+		ret |= opp_to_freq(&dsp_freq, OPP_DSP, target_level);
 #ifndef CONFIG_CPU_FREQ
-		ret |= opp_to_freq(&mpu_cur_freq, mpu_opps, current_level);
+		ret |= opp_to_freq(&mpu_cur_freq, OPP_MPU, current_level);
 #endif
 	} else {
-		ret = opp_to_freq(&l3_freq, l3_opps, target_level);
+		ret = opp_to_freq(&l3_freq, OPP_L3, target_level);
 	}
 	/* we would have caught all bad levels earlier.. */
 	if (unlikely(ret))
@@ -329,7 +326,7 @@ static int program_opp_freq(int res, int target_level, int current_level)
 	return target_level;
 }
 
-static int program_opp(int res, struct omap_opp *opp, int target_level,
+static int program_opp(int res, enum opp_t opp_t, int target_level,
 		int current_level)
 {
 	int i, ret = 0, raise;
@@ -342,7 +339,7 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 #endif
 
 	/* See if have a freq associated, if not, invalid opp */
-	ret = opp_to_freq(&freq, opp, target_level);
+	ret = opp_to_freq(&freq, opp_t, target_level);
 	if (unlikely(ret))
 		return ret;
 
@@ -365,13 +362,13 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 			 * transitioning from good to good OPP
 			 * none of the following should fail..
 			 */
-			oppx = opp_find_freq_exact(opp, freq, true);
+			oppx = opp_find_freq_exact(opp_t, freq, true);
 			BUG_ON(IS_ERR(oppx));
 			uvdc = opp_get_voltage(oppx);
 			vt = omap_twl_uv_to_vsel(uvdc);
 
-			BUG_ON(opp_to_freq(&freq, opp, current_level));
-			oppx = opp_find_freq_exact(opp, freq, true);
+			BUG_ON(opp_to_freq(&freq, opp_t, current_level));
+			oppx = opp_find_freq_exact(opp_t, freq, true);
 			BUG_ON(IS_ERR(oppx));
 			uvdc = opp_get_voltage(oppx);
 			vc = omap_twl_uv_to_vsel(uvdc);
@@ -404,15 +401,12 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 	if (resp->curr_level == target_level)
 		return 0;
 
-	if (!mpu_opps || !dsp_opps || !l3_opps)
-		return 0;
-
 	/* Check if I can actually switch or not */
 	if (res == VDD1_OPP) {
-		ret = opp_to_freq(&mpu_freq, mpu_opps, target_level);
-		ret |= opp_to_freq(&mpu_old_freq, mpu_opps, resp->curr_level);
+		ret = opp_to_freq(&mpu_freq, OPP_MPU, target_level);
+		ret |= opp_to_freq(&mpu_old_freq, OPP_MPU, resp->curr_level);
 	} else {
-		ret = opp_to_freq(&l3_freq, l3_opps, target_level);
+		ret = opp_to_freq(&l3_freq, OPP_L3, target_level);
 	}
 	if (ret)
 		return ret;
@@ -431,7 +425,7 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 		/* Send pre notification to CPUFreq */
 		cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
 #endif
-		resp->curr_level = program_opp(res, mpu_opps, target_level,
+		resp->curr_level = program_opp(res, OPP_MPU, target_level,
 			resp->curr_level);
 #ifdef CONFIG_CPU_FREQ
 		/* Send a post notification to CPUFreq */
@@ -442,7 +436,7 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 			mutex_unlock(&dvfs_mutex);
 			return 0;
 		}
-		resp->curr_level = program_opp(res, l3_opps, target_level,
+		resp->curr_level = program_opp(res, OPP_L3, target_level,
 			resp->curr_level);
 	}
 	mutex_unlock(&dvfs_mutex);
@@ -474,17 +468,17 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 		req_l3_freq = (target_level * 1000)/4;
 
 		/* Do I have a best match? */
-		oppx = opp_find_freq_ceil(l3_opps, &req_l3_freq);
+		oppx = opp_find_freq_ceil(OPP_L3, &req_l3_freq);
 		if (IS_ERR(oppx)) {
 			/* Give me the best we got */
 			req_l3_freq = ULONG_MAX;
-			oppx = opp_find_freq_floor(l3_opps, &req_l3_freq);
+			oppx = opp_find_freq_floor(OPP_L3, &req_l3_freq);
 		}
 
 		/* uh uh.. no OPPs?? */
 		BUG_ON(IS_ERR(oppx));
 
-		ret = freq_to_opp((u8 *)&target_level, l3_opps, req_l3_freq);
+		ret = freq_to_opp((u8 *)&target_level, OPP_L3, req_l3_freq);
 		/* we dont expect this to fail */
 		BUG_ON(ret);
 
@@ -503,9 +497,9 @@ int validate_opp(struct shared_resource *resp, u32 target_level)
 {
 	unsigned long x;
 	if (strcmp(resp->name, "mpu_freq") == 0)
-		return opp_to_freq(&x, mpu_opps, target_level);
+		return opp_to_freq(&x, OPP_MPU, target_level);
 	else if (strcmp(resp->name, "dsp_freq") == 0)
-		return opp_to_freq(&x, dsp_opps, target_level);
+		return opp_to_freq(&x, OPP_DSP, target_level);
 	return 0;
 }
 
@@ -519,19 +513,16 @@ void init_freq(struct shared_resource *resp)
 	unsigned long freq;
 	resp->no_of_users = 0;
 
-	if (!mpu_opps || !dsp_opps)
-		return;
-
 	linked_res_name = (char *)resp->resource_data;
 	/* Initialize the current level of the Freq resource
 	* to the frequency set by u-boot.
 	*/
 	if (strcmp(resp->name, "mpu_freq") == 0)
 		/* MPU freq in Mhz */
-		ret = opp_to_freq(&freq, mpu_opps, curr_vdd1_opp);
+		ret = opp_to_freq(&freq, OPP_MPU, curr_vdd1_opp);
 	else if (strcmp(resp->name, "dsp_freq") == 0)
 		/* DSP freq in Mhz */
-		ret = opp_to_freq(&freq, dsp_opps, curr_vdd1_opp);
+		ret = opp_to_freq(&freq, OPP_DSP, curr_vdd1_opp);
 	BUG_ON(ret);
 
 	resp->curr_level = freq;
@@ -543,16 +534,13 @@ int set_freq(struct shared_resource *resp, u32 target_level)
 	u8 vdd1_opp;
 	int ret = -EINVAL;
 
-	if (!mpu_opps || !dsp_opps)
-		return 0;
-
 	if (strcmp(resp->name, "mpu_freq") == 0) {
-		ret = freq_to_opp(&vdd1_opp, mpu_opps, target_level);
+		ret = freq_to_opp(&vdd1_opp, OPP_MPU, target_level);
 		if (!ret)
 			ret = resource_request("vdd1_opp", &dummy_mpu_dev,
 					vdd1_opp);
 	} else if (strcmp(resp->name, "dsp_freq") == 0) {
-		ret = freq_to_opp(&vdd1_opp, dsp_opps, target_level);
+		ret = freq_to_opp(&vdd1_opp, OPP_DSP, target_level);
 		if (!ret)
 			ret = resource_request("vdd1_opp", &dummy_dsp_dev,
 					vdd1_opp);
@@ -566,8 +554,8 @@ int validate_freq(struct shared_resource *resp, u32 target_level)
 {
 	u8 x;
 	if (strcmp(resp->name, "mpu_freq") == 0)
-		return freq_to_opp(&x, mpu_opps, target_level);
+		return freq_to_opp(&x, OPP_MPU, target_level);
 	else if (strcmp(resp->name, "dsp_freq") == 0)
-		return freq_to_opp(&x, dsp_opps, target_level);
+		return freq_to_opp(&x, OPP_DSP, target_level);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 3c37837..1c5ec37 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -152,12 +152,11 @@ static u8 get_vdd1_opp(void)
 	struct omap_opp *opp;
 	unsigned long freq;
 
-	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk) ||
-							mpu_opps == NULL)
+	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk))
 		return 0;
 
 	freq = sr1.vdd_opp_clk->rate;
-	opp = opp_find_freq_ceil(mpu_opps, &freq);
+	opp = opp_find_freq_ceil(OPP_MPU, &freq);
 	if (IS_ERR(opp))
 		return 0;
 	/*
@@ -176,12 +175,11 @@ static u8 get_vdd2_opp(void)
 	struct omap_opp *opp;
 	unsigned long freq;
 
-	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk) ||
-							l3_opps == NULL)
+	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk))
 		return 0;
 
 	freq = sr2.vdd_opp_clk->rate;
-	opp = opp_find_freq_ceil(l3_opps, &freq);
+	opp = opp_find_freq_ceil(OPP_L3, &freq);
 	if (IS_ERR(opp))
 		return 0;
 
@@ -310,7 +308,7 @@ static void sr_configure_vp(int srid)
 		if (!target_opp_no)
 			target_opp_no = VDD1_OPP3;
 
-		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
+		opp = opp_find_by_opp_id(OPP_MPU, target_opp_no);
 		BUG_ON(!opp); /* XXX ugh */
 
 		uvdc = opp_get_voltage(opp);
@@ -359,7 +357,7 @@ static void sr_configure_vp(int srid)
 		if (!target_opp_no)
 			target_opp_no = VDD2_OPP3;
 
-		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
+		opp = opp_find_by_opp_id(OPP_L3, target_opp_no);
 		BUG_ON(!opp); /* XXX ugh */
 
 		uvdc = opp_get_voltage(opp);
@@ -472,7 +470,7 @@ static int sr_reset_voltage(int srid)
 			return 1;
 		}
 
-		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
+		opp = opp_find_by_opp_id(OPP_MPU, target_opp_no);
 		if (!opp)
 			return 1;
 
@@ -490,7 +488,7 @@ static int sr_reset_voltage(int srid)
 			return 1;
 		}
 
-		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
+		opp = opp_find_by_opp_id(OPP_L3, target_opp_no);
 		if (!opp)
 			return 1;
 
@@ -546,11 +544,6 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 	int uvdc;
 	char vsel;
 
-	if (!(mpu_opps && l3_opps)) {
-		pr_notice("VSEL values not found\n");
-		return false;
-	}
-
 	sr->req_opp_no = target_opp_no;
 
 	if (sr->srid == SR1) {
@@ -575,7 +568,7 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			break;
 		}
 
-		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
+		opp = opp_find_by_opp_id(OPP_MPU, target_opp_no);
 		if (!opp)
 			return false;
 	} else {
@@ -594,7 +587,7 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			break;
 		}
 
-		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
+		opp = opp_find_by_opp_id(OPP_L3, target_opp_no);
 		if (!opp)
 			return false;
 	}
@@ -1010,12 +1003,6 @@ static int __init omap3_sr_init(void)
 	int ret = 0;
 	u8 RdReg;
 
-	/* Exit if OPP tables are not defined */
-        if (!(mpu_opps && l3_opps)) {
-                pr_err("SR: OPP rate tables not defined for platform, not enabling SmartReflex\n");
-		return -ENODEV;
-        }
-
 	/* Enable SR on T2 */
 	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
 			      R_DCDC_GLOBAL_CFG);
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 6bd62ea..dddc027 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -52,12 +52,6 @@ int omap_board_config_size;
 /* used by omap-smp.c and board-4430sdp.c */
 void __iomem *gic_cpu_base_addr;
 
-#ifdef CONFIG_OMAP_PM_NONE
-struct omap_opp *mpu_opps;
-struct omap_opp *dsp_opps;
-struct omap_opp *l3_opps;
-#endif
-
 static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
 {
 	struct omap_board_config_kernel *kinfo = NULL;
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 109203e..a69b557 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -87,6 +87,9 @@ static int omap_target(struct cpufreq_policy *policy,
 #ifdef CONFIG_ARCH_OMAP1
 	struct cpufreq_freqs freqs;
 #endif
+#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
+	unsigned long freq = target_freq * 1000;
+#endif
 	int ret = 0;
 
 	/* Ensure desired rate is within allowed range.  Some govenors
@@ -111,11 +114,8 @@ static int omap_target(struct cpufreq_policy *policy,
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	if (mpu_opps) {
-		unsigned long freq = target_freq * 1000;
-		if (!IS_ERR(opp_find_freq_ceil(mpu_opps, &freq)))
-			omap_pm_cpu_set_freq(freq);
-	}
+	if (opp_find_freq_ceil(OPP_MPU, &freq))
+		omap_pm_cpu_set_freq(freq);
 #endif
 	return ret;
 }
@@ -136,7 +136,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 	if (!cpu_is_omap34xx())
 		clk_init_cpufreq_table(&freq_table);
 	else
-		opp_init_cpufreq_table(mpu_opps, &freq_table);
+		opp_init_cpufreq_table(OPP_MPU, &freq_table);
 
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 9f91ad3..b4ef532 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -13,9 +13,16 @@
 #ifndef __ASM_ARM_OMAP_OPP_H
 #define __ASM_ARM_OMAP_OPP_H
 
-extern struct omap_opp *mpu_opps;
-extern struct omap_opp *dsp_opps;
-extern struct omap_opp *l3_opps;
+#ifdef CONFIG_ARCH_OMAP3
+enum opp_t {
+	OPP_MPU,
+	OPP_L3,
+	OPP_DSP,
+	OPP_TYPES_MAX
+};
+#else
+#error "You need to populate the OPP types for OMAP chip type."
+#endif
 
 struct omap_opp;
 
@@ -40,16 +47,16 @@ unsigned long opp_get_freq(const struct omap_opp *opp);
 /**
  * opp_get_opp_count() - Get number of opps enabled in the opp list
  * @num:	returns the number of opps
- * @oppl:	opp list
+ * @opp_t:	OPP type we want to count
  *
  * This functions returns the number of opps if there are any OPPs enabled,
  * else returns corresponding error value.
  */
-int opp_get_opp_count(struct omap_opp *oppl);
+int opp_get_opp_count(enum opp_t opp_t);
 
 /**
  * opp_find_freq_exact() - search for an exact frequency
- * @oppl:	OPP list
+ * @opp_t:	OPP type we want to search in.
  * @freq:	frequency to search for
  * @enabled:	enabled/disabled OPP to search for
  *
@@ -61,14 +68,14 @@ int opp_get_opp_count(struct omap_opp *oppl);
  * for exact matching frequency and is enabled. if true, the match is for exact
  * frequency which is disabled.
  */
-struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
+struct omap_opp *opp_find_freq_exact(enum opp_t opp_t,
 				     unsigned long freq, bool enabled);
 
 /* XXX This documentation needs fixing */
 
 /**
  * opp_find_freq_floor() - Search for an rounded freq
- * @oppl:	Starting list
+ * @opp_t:	OPP type we want to search in
  * @freq:	Start frequency
  *
  * Search for the lower *enabled* OPP from a starting freq
@@ -97,14 +104,13 @@ struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
  * NOTE: if we set freq as ULONG_MAX and search low, we get the
  * highest enabled frequency
  */
-struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
-				     unsigned long *freq);
+struct omap_opp *opp_find_freq_floor(enum opp_t opp_t, unsigned long *freq);
 
 /* XXX This documentation needs fixing */
 
 /**
  * opp_find_freq_ceil() - Search for an rounded freq
- * @oppl:	Starting list
+ * @opp_t:	OPP type where we want to search in
  * @freq:	Start frequency
  *
  * Search for the higher *enabled* OPP from a starting freq
@@ -130,7 +136,7 @@ struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
  *		freq++; * for next higher match *
  *	}
  */
-struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq);
+struct omap_opp *opp_find_freq_ceil(enum opp_t opp_t, unsigned long *freq);
 
 
 /**
@@ -170,35 +176,27 @@ struct omap_opp_def {
 
 /**
  * opp_init_list() - Initialize an opp list from the opp definitions
+ * @opp_t:	OPP type to initialize this list for.
  * @opp_defs:	Initial opp definitions to create the list.
  *
- * This function creates a list of opp definitions and returns a handle.
+ * This function creates a list of opp definitions and returns status.
  * This list can be used to further validation/search/modifications. New
  * opp entries can be added to this list by using opp_add().
  *
- * In the case of error, ERR_PTR is returned to the caller and should be
- * appropriately handled with IS_ERR.
+ * In the case of error, suitable error code is returned.
  */
-struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs);
+int  __init opp_init_list(enum opp_t opp_t,
+			 const struct omap_opp_def *opp_defs);
 
 /**
  * opp_add()  - Add an OPP table from a table definitions
- * @oppl:	List to add the OPP to
+ * @opp_t:	OPP type under which we want to add our new OPP.
  * @opp_def:	omap_opp_def to describe the OPP which we want to add to list.
  *
- * This function adds an opp definition to the opp list and returns
- * a handle representing the new OPP list. This handle is then used for further
- * validation, search, modification operations on the OPP list.
- *
- * This function returns the pointer to the allocated list through oppl if
- * success, else corresponding ERR_PTR value. Caller should NOT free the oppl.
- * opps_defs can be freed after use.
+ * This function adds an opp definition to the opp list and returns status.
  *
- * NOTE: caller should assume that on success, oppl is probably populated with
- * a new handle and the new handle should be used for further referencing
  */
-struct omap_opp *opp_add(struct omap_opp *oppl,
-			 const struct omap_opp_def *opp_def);
+int opp_add(enum opp_t opp_t, const struct omap_opp_def *opp_def);
 
 /**
  * opp_enable() - Enable a specific OPP
@@ -224,11 +222,11 @@ int opp_enable(struct omap_opp *opp);
  */
 int opp_disable(struct omap_opp *opp);
 
-struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
+struct omap_opp * __deprecated opp_find_by_opp_id(enum opp_t opp_t,
 						  u8 opp_id);
 u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
 
-void opp_init_cpufreq_table(struct omap_opp *opps,
+void opp_init_cpufreq_table(enum opp_t opp_t,
 			    struct cpufreq_frequency_table **table);
 
 
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index aeb372e..713a59f 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -26,10 +26,6 @@
 
 #include <plat/powerdomain.h>
 
-struct omap_opp *dsp_opps;
-struct omap_opp *mpu_opps;
-struct omap_opp *l3_opps;
-
 /*
  * Device-driver-originated constraints (via board-*.c files)
  */
diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index f7bf353..9b4cf7f 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -25,10 +25,6 @@
 #include <plat/resource.h>
 #include <plat/omap_device.h>
 
-struct omap_opp *dsp_opps;
-struct omap_opp *mpu_opps;
-struct omap_opp *l3_opps;
-
 #define LAT_RES_POSTAMBLE "_latency"
 #define MAX_LATENCY_RES_NAME 30
 
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 4fe1933..8fd9366 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -38,6 +38,8 @@ struct omap_opp {
 	u8 opp_id;
 };
 
+
+static struct omap_opp *_opp_list[OPP_TYPES_MAX];
 /*
  * DEPRECATED: Meant to detect end of opp array
  * This is meant to help co-exist with current SRF etc
@@ -65,17 +67,22 @@ unsigned long opp_get_freq(const struct omap_opp *opp)
 
 /**
  * opp_find_by_opp_id - look up OPP by OPP ID (deprecated)
- * @opps: pointer to an array of struct omap_opp
+ * @opp_t: OPP type where we want the look up to happen.
  *
  * Returns the struct omap_opp pointer corresponding to the given OPP
  * ID @opp_id, or returns NULL on error.
  */
-struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
+struct omap_opp * __deprecated opp_find_by_opp_id(enum opp_t opp_t,
 						  u8 opp_id)
 {
+	struct omap_opp *opps;
 	int i = 0;
 
-	if (!opps || !opp_id)
+	if (unlikely(opp_t >= OPP_TYPES_MAX || !opp_id))
+		return NULL;
+	opps = _opp_list[opp_t];
+
+	if (!opps)
 		return NULL;
 
 	while (!OPP_TERM(&opps[i])) {
@@ -93,14 +100,20 @@ u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
 	return opp->opp_id;
 }
 
-int opp_get_opp_count(struct omap_opp *oppl)
+int opp_get_opp_count(enum opp_t opp_t)
 {
 	u8 n = 0;
+	struct omap_opp *oppl;
 
-	if (unlikely(!oppl || IS_ERR(oppl))) {
+	if (unlikely(opp_t >= OPP_TYPES_MAX)) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return -EINVAL;
 	}
+
+	oppl = _opp_list[opp_t];
+	if (!oppl)
+		return -ENOENT;
+
 	while (!OPP_TERM(oppl)) {
 		if (oppl->enabled)
 			n++;
@@ -109,14 +122,21 @@ int opp_get_opp_count(struct omap_opp *oppl)
 	return n;
 }
 
-struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
+struct omap_opp *opp_find_freq_exact(enum opp_t opp_t,
 				     unsigned long freq, bool enabled)
 {
-	if (unlikely(!oppl || IS_ERR(oppl))) {
+	struct omap_opp *oppl;
+
+	if (unlikely(opp_t >= OPP_TYPES_MAX)) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
+	oppl = _opp_list[opp_t];
+
+	if (!oppl)
+		return NULL;
+
 	while (!OPP_TERM(oppl)) {
 		if ((oppl->rate == freq) && (oppl->enabled == enabled))
 			break;
@@ -126,13 +146,21 @@ struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
 	return OPP_TERM(oppl) ? ERR_PTR(-ENOENT) : oppl;
 }
 
-struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq)
+struct omap_opp *opp_find_freq_ceil(enum opp_t opp_t, unsigned long *freq)
 {
-	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
+	struct omap_opp *oppl;
+
+	if (unlikely(opp_t >= OPP_TYPES_MAX || !freq ||
+		 IS_ERR(freq))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
+	oppl = _opp_list[opp_t];
+
+	if (!oppl)
+		return NULL;
+
 	while (!OPP_TERM(oppl)) {
 		if (oppl->enabled && oppl->rate >= *freq)
 			break;
@@ -148,14 +176,19 @@ struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq)
 	return oppl;
 }
 
-struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl, unsigned long *freq)
+struct omap_opp *opp_find_freq_floor(enum opp_t opp_t, unsigned long *freq)
 {
-	struct omap_opp *prev_opp = oppl;
+	struct omap_opp *prev_opp, *oppl;
 
-	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
+	if (unlikely(opp_t >= OPP_TYPES_MAX || !freq ||
+		 IS_ERR(freq))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
+	oppl = prev_opp = _opp_list[opp_t];
+
+	if (!oppl)
+		return NULL;
 
 	while (!OPP_TERM(oppl)) {
 		if (oppl->enabled) {
@@ -185,19 +218,23 @@ static void omap_opp_populate(struct omap_opp *opp,
 	opp->u_volt = opp_def->u_volt;
 }
 
-struct omap_opp *opp_add(struct omap_opp *oppl,
-			 const struct omap_opp_def *opp_def)
+int opp_add(enum opp_t opp_t, const struct omap_opp_def *opp_def)
 {
-	struct omap_opp *opp, *oppt, *oppr;
+	struct omap_opp *opp, *oppt, *oppr, *oppl;
 	u8 n, i, ins;
 
-	if (unlikely(!oppl || IS_ERR(oppl) || !opp_def || IS_ERR(opp_def))) {
+	if (unlikely(opp_t >= OPP_TYPES_MAX || !opp_def ||
+			 IS_ERR(opp_def))) {
 		pr_err("%s: Invalid params being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	n = 0;
-	opp = oppl;
+	oppl = opp = _opp_list[opp_t];
+
+	if (!oppl)
+		return -ENOENT;
+
 	while (!OPP_TERM(opp)) {
 		n++;
 		opp++;
@@ -210,11 +247,11 @@ struct omap_opp *opp_add(struct omap_opp *oppl,
 	oppr = kzalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
 	if (!oppr) {
 		pr_err("%s: No memory for new opp array\n", __func__);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
 	/* Simple insertion sort */
-	opp = oppl;
+	opp = _opp_list[opp_t];
 	oppt = oppr;
 	ins = 0;
 	i = 1;
@@ -238,23 +275,27 @@ struct omap_opp *opp_add(struct omap_opp *oppl,
 		oppt++;
 	}
 
+	_opp_list[opp_t] = oppr;
+
 	/* Terminator implicitly added by kzalloc() */
 
 	/* Free the old list */
 	kfree(oppl);
 
-	return oppr;
+	return 0;
 }
 
-struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
+int __init opp_init_list(enum opp_t opp_t,
+				 const struct omap_opp_def *opp_defs)
 {
 	struct omap_opp_def *t = (struct omap_opp_def *)opp_defs;
-	struct omap_opp *opp, *oppl;
+	struct omap_opp *oppl;
 	u8 n = 0, i = 1;
 
-	if (unlikely(!opp_defs || IS_ERR(opp_defs))) {
+	if (unlikely(opp_t >= OPP_TYPES_MAX || !opp_defs ||
+			 IS_ERR(opp_defs))) {
 		pr_err("%s: Invalid params being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 	/* Grab a count */
 	while (t->enabled || t->freq || t->u_volt) {
@@ -269,22 +310,23 @@ struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
 	oppl = kzalloc(sizeof(struct omap_opp) * (n + 1), GFP_KERNEL);
 	if (!oppl) {
 		pr_err("%s: No memory for opp array\n", __func__);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
-	opp = oppl;
+
+	_opp_list[opp_t] = oppl;
 	while (n) {
-		omap_opp_populate(opp, opp_defs);
-		opp->opp_id = i;
+		omap_opp_populate(oppl, opp_defs);
+		oppl->opp_id = i;
 		n--;
-		opp++;
+		oppl++;
 		opp_defs++;
 		i++;
 	}
 
 	/* Terminator implicitly added by kzalloc() */
 
-	return oppl;
+	return 0;
 }
 
 int opp_enable(struct omap_opp *opp)
@@ -308,20 +350,21 @@ int opp_disable(struct omap_opp *opp)
 }
 
 /* XXX document */
-void opp_init_cpufreq_table(struct omap_opp *opps,
+void opp_init_cpufreq_table(enum opp_t opp_t,
 			    struct cpufreq_frequency_table **table)
 {
 	int i = 0, j;
 	int opp_num;
 	struct cpufreq_frequency_table *freq_table;
+	struct omap_opp *opp;
 
-	if (!opps) {
+	if (opp_t >= OPP_TYPES_MAX) {
 		pr_warning("%s: failed to initialize frequency"
 				"table\n", __func__);
 		return;
 	}
 
-	opp_num = opp_get_opp_count(opps);
+	opp_num = opp_get_opp_count(opp_t);
 	if (opp_num < 0) {
 		pr_err("%s: no opp table?\n", __func__);
 		return;
@@ -335,14 +378,14 @@ void opp_init_cpufreq_table(struct omap_opp *opps,
 		return;
 	}
 
+	opp = _opp_list[opp_t];
 	for (j = opp_num; j >= 0; j--) {
-		struct omap_opp *opp = &opps[j];
-
 		if (opp->enabled) {
 			freq_table[i].index = i;
 			freq_table[i].frequency = opp->rate / 1000;
 			i++;
 		}
+		opp++;
 	}
 
 	freq_table[i].index = i;


