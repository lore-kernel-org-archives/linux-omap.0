From: Nishanth Menon <nm@ti.com>
Subject: [RFC] [PATCH 2/2] DSPBRIDGE: pm: use pm-wip-opp APIs for opp list
Date: Wed, 20 Jan 2010 16:19:13 -0600
Message-ID: <1264025953-4620-4-git-send-email-nm@ti.com>
References: <1264025953-4620-1-git-send-email-nm@ti.com>
 <1264025953-4620-2-git-send-email-nm@ti.com>
 <1264025953-4620-3-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59053 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab0ATWTR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 17:19:17 -0500
In-Reply-To: <1264025953-4620-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Use the PM-WIP-OPP branch apis for generating the opp list for DSP.
This allows for scaling accross 3430,3440,3450 and 3630 series.

Caveat: does not handle dynamic addition of opp after the
bridgedriver is inserted - this can be done once the framework for
the same is made available

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
caveat: this does not use the ENUM implementation yet, this can be once it is
merged to pm-wip-opp branch.

 arch/arm/mach-omap2/dspbridge.c |   99 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 26b860f..935afd7 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -15,6 +15,20 @@
 
 #ifdef CONFIG_BRIDGE_DVFS
 #include <mach/omap-pm.h>
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
@@ -42,7 +56,90 @@ static struct dspbridge_platform_data dspbridge_pdata __initdata = {
 static int get_opp_table(struct dspbridge_platform_data *pdata)
 {
 #ifdef CONFIG_BRIDGE_DVFS
-	/* Do nothing now  - fill based on PM implementation */
+	int mpu_freqs;
+	int dsp_freqs;
+	int i;
+	struct omap_opp *opp;
+	unsigned long freq, old_rate;
+
+	mpu_freqs = opp_get_opp_count(mpu_opps);
+	dsp_freqs = opp_get_opp_count(dsp_opps);
+	if (mpu_freqs < 0 || dsp_freqs < 0 || mpu_freqs != dsp_freqs) {
+		pr_err("mpu and dsp frequencies are inconsistent! "
+			"mpu_freqs=%d dsp_freqs=%d\n", mpu_freqs, dsp_freqs);
+		return -EINVAL;
+	}
+	/* allocate memory if we have opps initialized */
+	pdata->mpu_speeds = kzalloc(sizeof(u32) * mpu_freqs,
+			GFP_KERNEL);
+	if (!pdata->mpu_speeds) {
+		pr_err("unable to allocate memory for the mpu"
+		"frequencies\n");
+		return -ENOMEM;
+	}
+	opp = mpu_opps;
+	i = 0;
+	freq = 0;
+	while (!IS_ERR(opp = opp_find_freq_ceil(opp, &freq))) {
+		pdata->mpu_speeds[i] = freq;
+		freq++;
+		i++;
+	}
+	pdata->mpu_num_speeds = mpu_freqs;
+	pdata->mpu_min_speed = pdata->mpu_speeds[0];
+	pdata->mpu_max_speed = pdata->mpu_speeds[mpu_freqs - 1];
+	/* need an initial terminator */
+	pdata->dsp_freq_table = kzalloc(
+			sizeof(struct dsp_shm_freq_table) *
+			(dsp_freqs + 1), GFP_KERNEL);
+	if (!pdata->dsp_freq_table) {
+		pr_err("unable to allocate memory for the dsp"
+			"frequencies\n");
+		return -ENOMEM;
+	}
+
+	opp = dsp_opps;
+	i = 1;
+	freq = 0;
+	old_rate = 0;
+	/*
+	 * the freq table is in terms of khz.. so we need to
+	 * divide by 1000
+	 */
+	while (!IS_ERR(opp = opp_find_freq_ceil(opp, &freq))) {
+		/* dsp frequencies are in khz */
+		u32 rate = freq / 1000;
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
+	}
+	/* the last entry should map with maximum rate */
+	pdata->dsp_freq_table[i - 1].thresh_max_freq = old_rate;
+	pdata->dsp_num_speeds = dsp_freqs;
 #endif
 	return 0;
 }
-- 
1.6.3.3

