From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2 v2] DSPBRIDGE: pm: use old implementation for opps
Date: Tue,  2 Feb 2010 01:17:26 -0600
Message-ID: <1265095046-25253-3-git-send-email-nm@ti.com>
References: <1265095046-25253-1-git-send-email-nm@ti.com>
 <1265095046-25253-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52310 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038Ab0BBHRc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 02:17:32 -0500
In-Reply-To: <1265095046-25253-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Romit Dasgupta <romit@ti.com>

Use the old implementation for OPP list generation and update.
this is a 1-1 implementation of what we had previously without
support for 3630.

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Romit Dasgupta <romit@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Ref:
v1: http://marc.info/?t=126402609100007&r=1&w=2
v2: comment fixes from v1

 arch/arm/mach-omap2/dspbridge.c |   65 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 8b71e5f..0bcbf2e 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -42,7 +42,70 @@ static struct dspbridge_platform_data dspbridge_pdata __initdata = {
 static int get_opp_table(struct dspbridge_platform_data *pdata)
 {
 #ifdef CONFIG_BRIDGE_DVFS
-	/* Do nothing now  - fill based on PM implementation */
+	/*
+	 * TODO: The following code is a direct replacement
+	 * improvements are possible.
+	 */
+	/* legacy values for 3430 */
+	u32 vdd1_dsp_freq[6][4] = {
+		{0, 0, 0, 0},
+		/*OPP1*/
+		{0, 90000, 0, 86000},
+		/*OPP2*/
+		{0, 180000, 80000, 170000},
+		/*OPP3*/
+		{0, 360000, 160000, 340000},
+		/*OPP4*/
+		{0, 396000, 325000, 376000},
+		/*OPP5*/
+		{0, 430000, 355000, 430000},
+	};
+	struct omap_opp vdd1_rate_table_bridge[] = {
+		{0, 0, 0},
+		/*OPP1*/
+		{S125M, VDD1_OPP1, 0},
+		/*OPP2*/
+		{S250M, VDD1_OPP2, 0},
+		/*OPP3*/
+		{S500M, VDD1_OPP3, 0},
+		/*OPP4*/
+		{S550M, VDD1_OPP4, 0},
+		/*OPP5*/
+		{S600M, VDD1_OPP5, 0},
+	};
+	pdata->mpu_num_speeds = VDD1_OPP5;
+	pdata->mpu_speeds = kzalloc(sizeof(u32) * (pdata->mpu_num_speeds + 1),
+			GFP_KERNEL);
+	if (!pdata->mpu_speeds) {
+		pr_err("%s: unable to allocate memory for the mpu"
+		"frequencies\n", __func__);
+		return -ENOMEM;
+	}
+	pdata->dsp_num_speeds = VDD1_OPP5;
+	pdata->dsp_freq_table = kzalloc(
+			sizeof(struct dsp_shm_freq_table) *
+			(pdata->dsp_num_speeds + 1), GFP_KERNEL);
+	if (!pdata->dsp_freq_table) {
+		pr_err("%s: unable to allocate memory for the dsp"
+		"frequencies\n", __func__);
+		kfree(pdata->mpu_speeds);
+		pdata->mpu_speeds = NULL;
+		return -ENOMEM;
+	}
+	for (i = 0; i <= pdata->mpu_num_speeds; i++)
+		pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
+	pdata->mpu_max_speed = pdata->mpu_speed[VDD1_OPP5];
+	pdata->mpu_min_speed = pdata->mpu_speed[VDD1_OPP1];
+
+	for (i = 0; i <= pdata->dsp_num_speeds; i++) {
+		pdata->dsp_freq_table[i].u_volts =
+				vdd1_dsp_freq[i][0];
+		pdata->dsp_freq_table[i].dsp_freq = vdd1_dsp_freq[i][1];
+		pdata->dsp_freq_table[i].thresh_min_freq =
+			vdd1_dsp_freq[i][2];
+		pdata->dsp_freq_table[i].thresh_max_freq =
+			vdd1_dsp_freq[i][3];
+	}
 #endif
 	return 0;
 }
-- 
1.6.3.3

