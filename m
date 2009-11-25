From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 09/10 V3] omap3: pm: introduce 3630 opps
Date: Tue, 24 Nov 2009 22:09:18 -0600
Message-ID: <1259122159-1583-10-git-send-email-nm@ti.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
 <1259122159-1583-2-git-send-email-nm@ti.com>
 <1259122159-1583-3-git-send-email-nm@ti.com>
 <1259122159-1583-4-git-send-email-nm@ti.com>
 <1259122159-1583-5-git-send-email-nm@ti.com>
 <1259122159-1583-6-git-send-email-nm@ti.com>
 <1259122159-1583-7-git-send-email-nm@ti.com>
 <1259122159-1583-8-git-send-email-nm@ti.com>
 <1259122159-1583-9-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42823 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934507AbZKYEJ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Nov 2009 23:09:27 -0500
In-Reply-To: <1259122159-1583-9-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Introduce the OMAP3630 OPPs including the defined OPP tuples.

Further information on OMAP3630 can be found here:
http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12836&contentId=52606

OMAP36xx family introduces:
VDD1 with 4 OPPs, of which OPP3 & 4 are available only on devices yet
to be introduced in 36xx family. Meanwhile, VDD2 has 2 opps.

Device Support of OPPs->
           |<-3630-600->| (default)
           |<-      3630-800    ->| (device: TBD)
           |<-      3630-1000            ->| (device: TBD)
H/w OPP-> OPP50 OPP100       OPP-Turbo   OPP1G-SB
VDD1      OPP1  OPP2         OPP3        OPP4
VDD2      OPP1  OPP2         OPP2        OPP2

Note:
a) TI h/w naming for OPPs are now standardized in terms of OPP50, 100,
   Turbo and SB. This maps as shown above to the opp IDs (s/w term).
b) For boards which need custom VDD1/2 OPPs, the opp table can be
   updated by the board file on a need basis after the
   omap3_pm_init_opp_table call. The OPPs introduced here are the
   official OPP table at this point in time.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   49 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ad21f5f..05ecf02 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -143,6 +143,41 @@ static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
 	{.enabled = 0, .freq = 0, .u_volt = 0}
 };
 
+static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
+	/*OPP1 - OPP50*/
+	{.enabled = true,  .freq = 300000000, .u_volt = 930000},
+	/*OPP2 - OPP100*/
+	{.enabled = true,  .freq = 600000000, .u_volt = 1100000},
+	/*OPP3 - OPP-Turbo*/
+	{.enabled = false, .freq = 800000000, .u_volt = 1260000},
+	/*OPP4 - OPP-SB*/
+	{.enabled = false, .freq = 1000000000, .u_volt = 1310000},
+	/* Terminator */
+	{.enabled = 0, .freq = 0, .u_volt = 0}
+};
+
+static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
+	/*OPP1 - OPP50 */
+	{.enabled = true, .freq = 100000000, .u_volt = 930000},
+	/*OPP2 - OPP100, OPP-Turbo, OPP-SB*/
+	{.enabled = true, .freq = 200000000, .u_volt = 1137500},
+	/* Terminator */
+	{.enabled = 0, .freq = 0, .u_volt = 0}
+};
+
+static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
+	/*OPP1 - OPP50*/
+	{.enabled = true,  .freq = 260000000, .u_volt = 930000},
+	/*OPP2 - OPP100*/
+	{.enabled = true,  .freq = 520000000, .u_volt = 1100000},
+	/*OPP3 - OPP-Turbo*/
+	{.enabled = false, .freq = 660000000, .u_volt = 1260000},
+	/*OPP4 - OPP-SB*/
+	{.enabled = false, .freq = 875000000, .u_volt = 1310000},
+	/* Terminator */
+	{.enabled = 0, .freq = 0, .u_volt = 0}
+};
+
 struct omap_opp *omap3_mpu_rate_table;
 struct omap_opp *omap3_dsp_rate_table;
 struct omap_opp *omap3_l3_rate_table;
@@ -1299,18 +1334,28 @@ static void __init configure_vc(void)
 void __init omap3_pm_init_opp_table(void)
 {
 	int ret, i;
+	struct omap_opp_def **omap3_opp_def_list;
 	struct omap_opp_def *omap34xx_opp_def_list[] = {
 		omap34xx_mpu_rate_table,
 		omap34xx_l3_rate_table,
 		omap34xx_dsp_rate_table
 	};
+	struct omap_opp_def *omap36xx_opp_def_list[] = {
+		omap36xx_mpu_rate_table,
+		omap36xx_l3_rate_table,
+		omap36xx_dsp_rate_table
+	};
 	struct omap_opp **omap3_rate_tables[] = {
 		&omap3_mpu_rate_table,
 		&omap3_l3_rate_table,
 		&omap3_dsp_rate_table
 	};
-	for (i = 0; i < ARRAY_SIZE(omap34xx_opp_def_list); i++) {
-		ret = opp_init(omap3_rate_tables[i], omap34xx_opp_def_list[i]);
+
+	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
+				omap34xx_opp_def_list;
+
+	for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
+		ret = opp_init(omap3_rate_tables[i], omap3_opp_def_list[i]);
 		/* We dont want half configured system at the moment */
 		BUG_ON(ret);
 	}
-- 
1.6.3.3

