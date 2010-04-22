From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH 3/3 v2] DSPBRIDGE: pm: use pm-wip-opp APIs for opp list
Date: Wed, 21 Apr 2010 19:17:59 -0500
Message-ID: <1271895479-27744-4-git-send-email-nm@ti.com>
References: <1271895479-27744-1-git-send-email-nm@ti.com>
 <1271895479-27744-2-git-send-email-nm@ti.com>
 <1271895479-27744-3-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49513 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab0DVASL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 20:18:11 -0400
In-Reply-To: <1271895479-27744-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ramesh Gupta <grgupta@ti.com>

Use the PM-WIP-OPP branch apis for generating the opp list for DSP.
This allows for scaling accross 3430,3440,3450 and 3630 series.

Caveat: does not handle dynamic addition of opp after the
bridgedriver is inserted - this can be done once the framework for
the same is made available

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Ramesh Gupta <grgupta@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Ref:
v1: http://marc.info/?t=126402609100005&r=1&w=2
changes for v2:
 rebase on patch 2/2

 arch/arm/mach-omap2/dspbridge.c |  138 ++++++++++++++++++++++++---------------
 1 files changed, 85 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 8527a48..b2d08dc 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -15,6 +15,20 @@
 
 #ifdef CONFIG_BRIDGE_DVFS
 #include <plat/omap-pm.h>
+#include <plat/opp.h>
+/*
+ * The DSP load balancer works on the following logic:
+ * Opp frequencies:
+ * 0 <---------> Freq 1 <------------> Freq 2 <---------> Freq 3
+ * DSP Thresholds for the frequencies:
+ * 0M<-------X-> Freq 1 <-------M--X-> Freq 2 <----M--X-> Freq 3
+ * Where, M is the minimal threshold and X is maximum threshold
+ *
+ * if from Freq x to Freq y; where x > y, transition happens on M
+ * if from Freq x to Freq y; where x < y, transition happens on X
+ */
+#define BRIDGE_THRESH_HIGH_PERCENT	95
+#define BRIDGE_THRESH_LOW_PERCENT	88
 #endif
 
 #include <dspbridge/host_os.h>
@@ -42,72 +56,90 @@ static struct dspbridge_platform_data dspbridge_pdata __initdata = {
 static int __init get_opp_table(struct dspbridge_platform_data *pdata)
 {
 #ifdef CONFIG_BRIDGE_DVFS
-	/*
-	 * TODO: The following code is a direct replacement
-	 * improvements are possible.
-	 * XXX: Does not support 3630
-	 */
+	int mpu_freqs;
+	int dsp_freqs;
 	int i;
-	/* legacy values for 3430 */
-	u32 vdd1_dsp_freq[6][4] = {
-		{0, 0, 0, 0},
-		/*OPP1*/
-		{0, 90000, 0, 86000},
-		/*OPP2*/
-		{0, 180000, 80000, 170000},
-		/*OPP3*/
-		{0, 360000, 160000, 340000},
-		/*OPP4*/
-		{0, 396000, 325000, 376000},
-		/*OPP5*/
-		{0, 430000, 355000, 430000},
-	};
-	struct omap_opp vdd1_rate_table_bridge[] = {
-		{0, 0, 0},
-		/*OPP1*/
-		{125000000, VDD1_OPP1, 0},
-		/*OPP2*/
-		{250000000, VDD1_OPP2, 0},
-		/*OPP3*/
-		{500000000, VDD1_OPP3, 0},
-		/*OPP4*/
-		{550000000, VDD1_OPP4, 0},
-		/*OPP5*/
-		{600000000, VDD1_OPP5, 0},
-	};
-	pdata->mpu_num_speeds = VDD1_OPP5;
-	pdata->mpu_speeds = kzalloc(sizeof(u32) * (pdata->mpu_num_speeds + 1),
+	struct omap_opp *opp;
+	unsigned long freq, old_rate;
+
+	mpu_freqs = opp_get_opp_count(OPP_MPU);
+	dsp_freqs = opp_get_opp_count(OPP_DSP);
+	if (mpu_freqs < 0 || dsp_freqs < 0 || mpu_freqs != dsp_freqs) {
+		pr_err("%s:mpu and dsp frequencies are inconsistent! "
+			"mpu_freqs=%d dsp_freqs=%d\n", __func__, mpu_freqs,
+			dsp_freqs);
+		return -EINVAL;
+	}
+	/* allocate memory if we have opps initialized */
+	pdata->mpu_speeds = kzalloc(sizeof(u32) * mpu_freqs,
 			GFP_KERNEL);
 	if (!pdata->mpu_speeds) {
-		pr_err("%s: unable to allocate memory for the mpu"
-		"frequencies\n", __func__);
+		pr_err("%s:unable to allocate memory for the mpu"
+			"frequencies\n", __func__);
 		return -ENOMEM;
 	}
-	pdata->dsp_num_speeds = VDD1_OPP5;
+	i = 0;
+	freq = 0;
+	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq))) {
+		pdata->mpu_speeds[i] = freq;
+		freq++;
+		i++;
+	}
+	pdata->mpu_num_speeds = mpu_freqs;
+	pdata->mpu_min_speed = pdata->mpu_speeds[0];
+	pdata->mpu_max_speed = pdata->mpu_speeds[mpu_freqs - 1];
+	/* need an initial terminator */
 	pdata->dsp_freq_table = kzalloc(
 			sizeof(struct dsp_shm_freq_table) *
-			(pdata->dsp_num_speeds + 1), GFP_KERNEL);
+			(dsp_freqs + 1), GFP_KERNEL);
 	if (!pdata->dsp_freq_table) {
 		pr_err("%s: unable to allocate memory for the dsp"
-		"frequencies\n", __func__);
-		kfree(pdata->mpu_speeds);
-		pdata->mpu_speeds = NULL;
+			"frequencies\n", __func__);
 		return -ENOMEM;
 	}
-	for (i = 0; i <= pdata->mpu_num_speeds; i++)
-		pdata->mpu_speeds[i] = vdd1_rate_table_bridge[i].rate;
-	pdata->mpu_max_speed = pdata->mpu_speeds[VDD1_OPP5];
-	pdata->mpu_min_speed = pdata->mpu_speeds[VDD1_OPP1];
-
-	for (i = 0; i <= pdata->dsp_num_speeds; i++) {
-		pdata->dsp_freq_table[i].u_volts =
-				vdd1_dsp_freq[i][0];
-		pdata->dsp_freq_table[i].dsp_freq = vdd1_dsp_freq[i][1];
-		pdata->dsp_freq_table[i].thresh_min_freq =
-			vdd1_dsp_freq[i][2];
-		pdata->dsp_freq_table[i].thresh_max_freq =
-			vdd1_dsp_freq[i][3];
+
+	i = 1;
+	freq = 0;
+	old_rate = 0;
+	/*
+	 * the freq table is in terms of khz.. so we need to
+	 * divide by 1000
+	 */
+	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_DSP, &freq))) {
+		/* dsp frequencies are in khz */
+		u32 rate = freq / 1000;
+
+		/*
+		 * On certain 34xx silicons, certain OPPs are duplicated
+		 * for DSP - handle those by copying previous opp value
+		 */
+		if (rate == old_rate) {
+			memcpy(&pdata->dsp_freq_table[i],
+				&pdata->dsp_freq_table[i-1],
+				sizeof(struct dsp_shm_freq_table));
+		} else {
+			pdata->dsp_freq_table[i].dsp_freq = rate;
+			pdata->dsp_freq_table[i].u_volts =
+				opp_get_voltage(opp);
+			/*
+			 * min threshold:
+			 * NOTE: index 1 needs a min of 0! else no
+			 * scaling happens at DSP!
+			 */
+			pdata->dsp_freq_table[i].thresh_min_freq =
+				((old_rate * BRIDGE_THRESH_LOW_PERCENT) / 100);
+
+			/* max threshold */
+			pdata->dsp_freq_table[i].thresh_max_freq =
+				((rate * BRIDGE_THRESH_HIGH_PERCENT) / 100);
+		}
+		old_rate = rate;
+		freq++;
+		i++;
 	}
+	/* the last entry should map with maximum rate */
+	pdata->dsp_freq_table[i - 1].thresh_max_freq = old_rate;
+	pdata->dsp_num_speeds = dsp_freqs;
 #endif
 	return 0;
 }
-- 
1.6.3.3

