From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 04/10 V4] omap3: pm: srf: use opp accessor functions
Date: Wed,  9 Dec 2009 00:17:09 -0600
Message-ID: <1260339435-20294-5-git-send-email-nm@ti.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
 <1260339435-20294-2-git-send-email-nm@ti.com>
 <1260339435-20294-3-git-send-email-nm@ti.com>
 <1260339435-20294-4-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36536 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511AbZLIGRY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 01:17:24 -0500
In-Reply-To: <1260339435-20294-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

With the accessor functions, many of the direct accesses are
redundant. However we do not want to rewrite SRF at this point of time
We do the following here:
Remove get_opp and introduce three SRF specific accessor functions:
	opp_to_freq, freq_to_opp - need this coz of usage of opp IDs
	NOTE: These functions should be removed at a later point
	of time.
get_opp is removed because, with the above functions, it is
redundant.

NOTE: this implementation is just a start and leaves scope for
further cleanups which can be added on top.

NOTE: this adds the following warnings:
arch/arm/mach-omap2/resource34xx.c: In function 'opp_to_freq':
arch/arm/mach-omap2/resource34xx.c:184: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
arch/arm/mach-omap2/resource34xx.c: In function 'freq_to_opp':
arch/arm/mach-omap2/resource34xx.c:213: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
arch/arm/mach-omap2/resource34xx.c: In function 'init_opp':
arch/arm/mach-omap2/resource34xx.c:237: warning: 'freq_to_opp' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:204)
arch/arm/mach-omap2/resource34xx.c:244: warning: 'freq_to_opp' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:204)
arch/arm/mach-omap2/resource34xx.c: In function 'program_opp_freq':
arch/arm/mach-omap2/resource34xx.c:297: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c:298: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c:303: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c: In function 'program_opp':
arch/arm/mach-omap2/resource34xx.c:346: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
arch/arm/mach-omap2/resource34xx.c:347: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
arch/arm/mach-omap2/resource34xx.c:351: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c:376: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c: In function 'resource_set_opp_level':
arch/arm/mach-omap2/resource34xx.c:414: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c:415: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c:417: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c: In function 'set_opp':
arch/arm/mach-omap2/resource34xx.c:491: warning: 'freq_to_opp' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:204)
arch/arm/mach-omap2/resource34xx.c: In function 'validate_opp':
arch/arm/mach-omap2/resource34xx.c:510: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c:512: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c: In function 'init_freq':
arch/arm/mach-omap2/resource34xx.c:535: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c:538: warning: 'opp_to_freq' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:175)
arch/arm/mach-omap2/resource34xx.c: In function 'set_freq':
arch/arm/mach-omap2/resource34xx.c:554: warning: 'freq_to_opp' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:204)
arch/arm/mach-omap2/resource34xx.c:559: warning: 'freq_to_opp' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:204)
arch/arm/mach-omap2/resource34xx.c: In function 'validate_freq':
arch/arm/mach-omap2/resource34xx.c:573: warning: 'freq_to_opp' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:204)
arch/arm/mach-omap2/resource34xx.c:575: warning: 'freq_to_opp' is deprecated (declared at arch/arm/mach-omap2/resource34xx.c:204)

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Tero Kristo <Tero.Kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |  242 ++++++++++++++++++++++++++----------
 1 files changed, 176 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index af6b3c1..1f2c713 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -19,6 +19,8 @@
 #include <linux/pm_qos_params.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
 
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
@@ -155,21 +157,61 @@ static int curr_vdd1_opp;
 static int curr_vdd2_opp;
 static DEFINE_MUTEX(dvfs_mutex);
 
-static unsigned short get_opp(struct omap_opp *opp_freq_table,
+/* Introducing deprecated function because we got to.. */
+#define IS_OPP_TERMINATOR(opps, i) (!(opps)[(i)].enabled &&	\
+		!(opps)[(i)].rate && !(opps)[(i)].vsel)
+
+/**
+ * opp_to_freq - convert OPPID to frequency (DEPRECATED)
+ * @freq: return frequency back to caller
+ * @opps: opp list
+ * @opp_id: OPP ID we are searching for
+ *
+ * return 0 and freq is populated if we find the opp_id, else,
+ * we return error
+ *
+ * NOTE: this function is a standin for the timebeing as opp_id is deprecated
+ */
+static int __deprecated opp_to_freq(unsigned long *freq,
+		const struct omap_opp *opps, u8 opp_id)
+{
+	int i = 1;
+
+	BUG_ON(!freq || !opps);
+
+	/* The first entry is a dummy one, loop till we hit terminator */
+	while (!IS_OPP_TERMINATOR(opps, i)) {
+		if (opps[i].enabled && (opps[i].opp_id == opp_id)) {
+			*freq = opps[i].rate;
+			return 0;
+		}
+		i++;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * freq_to_opp - convert a frequency back to OPP ID (DEPRECATED)
+ * @opp_id: opp ID returned back to caller
+ * @opps: opp list
+ * @freq: frequency we are searching for
+ *
+ * return 0 and opp_id is populated if we find the freq, else, we return error
+ *
+ * NOTE: this function is a standin for the timebeing as opp_id is deprecated
+ */
+static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
 		unsigned long freq)
 {
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
+	struct omap_opp *opp;
+
+	BUG_ON(!opp_id || !opps);
+	opp = opp_find_freq_approx(opps, &freq, OPP_SEARCH_HIGH);
+	if (IS_ERR(opp))
+		return -EINVAL;
+	*opp_id = opp->opp_id;
+	return 0;
 }
 
 /**
@@ -178,6 +220,8 @@ static unsigned short get_opp(struct omap_opp *opp_freq_table,
 void init_opp(struct shared_resource *resp)
 {
 	struct clk *l3_clk;
+	int ret;
+	u8 opp_id;
 	resp->no_of_users = 0;
 
 	if (!mpu_opps || !dsp_opps || !l3_opps)
@@ -190,17 +234,18 @@ void init_opp(struct shared_resource *resp)
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
 
@@ -242,24 +287,40 @@ static int program_opp_freq(int res, int target_level, int current_level)
 {
 	int ret = 0, l3_div;
 	int *curr_opp;
+	unsigned long mpu_freq, dsp_freq, l3_freq;
+#ifndef CONFIG_CPU_FREQ
+	unsigned long mpu_cur_freq;
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
@@ -278,6 +339,7 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 		int current_level)
 {
 	int i, ret = 0, raise;
+	unsigned long freq;
 #ifdef CONFIG_OMAP_SMARTREFLEX
 	unsigned long t_opp, c_opp;
 
@@ -285,13 +347,10 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
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
@@ -303,10 +362,25 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 			ret = program_opp_freq(res, target_level,
 					current_level);
 #ifdef CONFIG_OMAP_SMARTREFLEX
-		else
-			sr_voltagescale_vcbypass(t_opp, c_opp,
-				opp[target_level].vsel,
-				opp[current_level].vsel);
+		else {
+			u8 vc, vt;
+			struct omap_opp *oppx;
+			/*
+			 * transitioning from good to good OPP
+			 * none of the following should fail..
+			 */
+			oppx = opp_find_freq_exact(opp, freq, true);
+			BUG_ON(IS_ERR(oppx));
+			vt = oppx->vsel;
+
+			BUG_ON(opp_to_freq(&freq, opp, current_level));
+			oppx = opp_find_freq_exact(opp, freq, true);
+			BUG_ON(IS_ERR(oppx));
+			vc = oppx->vsel;
+
+			/* ok to scale.. */
+			sr_voltagescale_vcbypass(t_opp, c_opp, vt, vc);
+		}
 #endif
 	}
 
@@ -315,7 +389,8 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 
 int resource_set_opp_level(int res, u32 target_level, int flags)
 {
-	unsigned long mpu_freq, mpu_old_freq;
+	unsigned long mpu_freq, mpu_old_freq, l3_freq;
+	int ret;
 #ifdef CONFIG_CPU_FREQ
 	struct cpufreq_freqs freqs_notify;
 #endif
@@ -334,6 +409,16 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
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
@@ -341,9 +426,6 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 			mutex_unlock(&dvfs_mutex);
 			return 0;
 		}
-		mpu_old_freq = mpu_opps[resp->curr_level].rate;
-		mpu_freq = mpu_opps[target_level].rate;
-
 #ifdef CONFIG_CPU_FREQ
 		freqs_notify.old = mpu_old_freq/1000;
 		freqs_notify.new = mpu_freq/1000;
@@ -371,15 +453,13 @@ int resource_set_opp_level(int res, u32 target_level, int flags)
 
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
@@ -389,21 +469,30 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 			resource_request("vdd2_opp", &vdd2_dev, 400000);
 
 	} else if (resp == vdd2_resp) {
-		tput = target_level;
+		unsigned long req_l3_freq;
+		struct omap_opp *oppx = NULL;
 
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
+		/* Do I have a best match? */
+		oppx = opp_find_freq_approx(l3_opps, &req_l3_freq,
+					OPP_SEARCH_HIGH);
+		if (IS_ERR(oppx)) {
+			/* Give me the best we got */
+			req_l3_freq = ULONG_MAX;
+			oppx = opp_find_freq_approx(l3_opps,
+					&req_l3_freq, OPP_SEARCH_LOW);
+		}
+
+		/* uh uh.. no OPPs?? */
+		BUG_ON(IS_ERR(oppx));
+
+		ret = freq_to_opp((u8 *)&target_level, l3_opps, req_l3_freq);
+		/* we dont expect this to fail */
+		BUG_ON(ret);
+
+		ret = resource_set_opp_level(VDD2_OPP, target_level, 0);
 	}
 	return 0;
 }
@@ -416,6 +505,11 @@ int set_opp(struct shared_resource *resp, u32 target_level)
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
 
@@ -425,6 +519,8 @@ int validate_opp(struct shared_resource *resp, u32 target_level)
 void init_freq(struct shared_resource *resp)
 {
 	char *linked_res_name;
+	int ret = -EINVAL;
+	unsigned long freq;
 	resp->no_of_users = 0;
 
 	if (!mpu_opps || !dsp_opps)
@@ -436,32 +532,46 @@ void init_freq(struct shared_resource *resp)
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

