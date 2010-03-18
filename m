From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH 4/4] omap3: srf: remove hardcoded opp dependency
Date: Thu, 18 Mar 2010 13:44:51 -0500
Message-ID: <1268937891-19445-5-git-send-email-nm@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <1268937891-19445-3-git-send-email-nm@ti.com>
 <1268937891-19445-4-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47610 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab0CRSpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 14:45:20 -0400
In-Reply-To: <1268937891-19445-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-Omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Thara Gopinath <thara@ti.com>

referencing l3 threshold based on OPP ID is hardcoded for OMAP3430
This is wrong when we consider OMAP3630 and beyond. use the store
and restore of data to handle this information

Cc: Ambresh K <ambresh@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/cpufreq34xx.c  |   13 +++++++++++++
 arch/arm/mach-omap2/resource34xx.c |   17 +++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index f0ed3ae..b0a03fe 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -112,6 +112,8 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 void __init omap3_pm_init_opp_table(void)
 {
 	int r;
+	unsigned long freq, l3_thresh;
+	struct omap_opp *opp;
 	struct omap_opp_def **omap3_opp_def_list;
 	struct omap_opp_def *omap34xx_opp_def_list[] = {
 		omap34xx_mpu_rate_table,
@@ -131,5 +133,16 @@ void __init omap3_pm_init_opp_table(void)
 	r |= opp_init_list(OPP_L3, omap3_opp_def_list[1]);
 	r |= opp_init_list(OPP_DSP, omap3_opp_def_list[2]);
 	BUG_ON(r);
+
+	/* First get the l3 thresh from highest l3 opp */
+	freq = ULONG_MAX;
+	opp = opp_find_freq_floor(OPP_L3, &freq);
+	l3_thresh = freq * 4 / 1000;
+	/* Now setup the L3 bandwidth restrictions for right mpu freqs */
+	freq = cpu_is_omap3630() ? 500000000 : 600000000;
+	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq))) {
+		opp_store_data(opp, "l3thresh", (void *) l3_thresh);
+		freq++;
+	}
 }
 
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index c6cce8b..b17ce90 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -448,17 +448,18 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 	int ret = -EINVAL;
 
 	if (resp == vdd1_resp) {
-		if (target_level < 3)
+		struct omap_opp *opp;
+		void *data;
+		opp = opp_find_by_opp_id(OPP_MPU, target_level);
+		data = opp_get_data(opp, "l3thresh");
+		if (IS_ERR(data))
 			resource_release("vdd2_opp", &vdd2_dev);
 
 		ret = resource_set_opp_level(VDD1_OPP, target_level, 0);
-		/*
-		 * For VDD1 OPP3 and above, make sure the interconnect
-		 * is at 100Mhz or above.
-		 * throughput in KiB/s for 100 Mhz = 100 * 1000 * 4.
-		 */
-		if (target_level >= 3)
-			resource_request("vdd2_opp", &vdd2_dev, 400000);
+
+		if (!IS_ERR(data))
+			resource_request("vdd2_opp", &vdd2_dev,
+					(unsigned long) data);
 
 	} else if (resp == vdd2_resp) {
 		unsigned long req_l3_freq;
-- 
1.6.3.3

