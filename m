From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 9/9] omap3: pm: introduce 3630 opps
Date: Wed, 11 Nov 2009 23:45:21 -0600
Message-ID: <1258004721-7315-10-git-send-email-nm@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
 <1258004721-7315-2-git-send-email-nm@ti.com>
 <1258004721-7315-3-git-send-email-nm@ti.com>
 <1258004721-7315-4-git-send-email-nm@ti.com>
 <1258004721-7315-5-git-send-email-nm@ti.com>
 <1258004721-7315-6-git-send-email-nm@ti.com>
 <1258004721-7315-7-git-send-email-nm@ti.com>
 <1258004721-7315-8-git-send-email-nm@ti.com>
 <1258004721-7315-9-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59809 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399AbZKLFpr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Nov 2009 00:45:47 -0500
In-Reply-To: <1258004721-7315-9-git-send-email-nm@ti.com>
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
 arch/arm/mach-omap2/omap3-opp.h |    9 ++++
 arch/arm/mach-omap2/pm34xx.c    |   87 +++++++++++++++++++++++++++++++-------
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index 7f27f44..a5880b8 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -4,22 +4,31 @@
 #include <plat/omap-pm.h>
 
 /* MPU speeds */
+#define S1000M  1000000000
+#define S800M   800000000
 #define S600M   600000000
 #define S550M   550000000
 #define S500M   500000000
+#define S300M   300000000
 #define S250M   250000000
 #define S125M   125000000
 
 /* DSP speeds */
+#define S875M   875000000
+#define S660M   660000000
+#define S520M   520000000
 #define S430M   430000000
 #define S400M   400000000
 #define S360M   360000000
+#define S260M   260000000
 #define S180M   180000000
 #define S90M    90000000
 
 /* L3 speeds */
 #define S83M    83000000
+#define S100M   100000000
 #define S166M   166000000
+#define S200M   200000000
 
 extern struct omap_opp *omap3_mpu_rate_table;
 extern struct omap_opp *omap3_dsp_rate_table;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 511137c..ffed70f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -140,6 +140,41 @@ static __initdata struct omap_opp omap34xx_dsp_rate_table[] = {
 	{0, 0, 0, 0},
 };
 
+static __initdata struct omap_opp omap36xx_mpu_rate_table[] = {
+	{0, 0, 0, 0},
+	/*OPP1 - 930mV - OPP50*/
+	{true, S300M, VDD1_OPP1, 0x1A},
+	/*OPP2 - 1.100V - OPP100*/
+	{true, S600M, VDD1_OPP2, 0x28},
+	/*OPP3 - 1.260V - OPP-Turbo*/
+	{true, S800M, VDD1_OPP3, 0x34},
+	/*OPP4 - 1.310V - OPP-SB*/
+	{false, S1000M, VDD1_OPP4, 0x38},
+	{0, 0, 0, 0},
+};
+
+static __initdata struct omap_opp omap36xx_l3_rate_table[] = {
+	{0, 0, 0, 0},
+	/*OPP1 - 930mV - OPP50 */
+	{true, S100M, VDD2_OPP1, 0x1A},
+	/*OPP2 - 1.375V - OPP100, OPP-Turbo, OPP-SB*/
+	{true, S200M, VDD2_OPP2, 0x3E},
+	{0, 0, 0, 0},
+};
+
+static __initdata struct omap_opp omap36xx_dsp_rate_table[] = {
+	{0, 0, 0, 0},
+	/*OPP1 - OPP50*/
+	{true, S260M, VDD1_OPP1, 0x1A},
+	/*OPP2 - OPP100*/
+	{true, S520M, VDD1_OPP2, 0x28},
+	/*OPP3 - OPP-Turbo*/
+	{false, S660M, VDD1_OPP3, 0x34},
+	/*OPP4 - OPP-SB*/
+	{false, S875M, VDD1_OPP4, 0x38},
+	{0, 0, 0, 0},
+};
+
 struct omap_opp *omap3_mpu_rate_table;
 struct omap_opp *omap3_dsp_rate_table;
 struct omap_opp *omap3_l3_rate_table;
@@ -1283,22 +1318,42 @@ static void __init configure_vc(void)
 void __init omap3_pm_init_opp_table(void)
 {
 	/* Populate the base CPU rate tables here */
-	omap3_mpu_rate_table = kmalloc(sizeof(omap34xx_mpu_rate_table),
-			GFP_KERNEL);
-	omap3_dsp_rate_table = kmalloc(sizeof(omap34xx_dsp_rate_table),
-			GFP_KERNEL);
-	omap3_l3_rate_table = kmalloc(sizeof(omap34xx_l3_rate_table),
-			GFP_KERNEL);
-
-	BUG_ON(!omap3_mpu_rate_table || !omap3_dsp_rate_table ||
-		!omap3_l3_rate_table);
-
-	memcpy(omap3_mpu_rate_table, omap34xx_mpu_rate_table,
-			sizeof(omap34xx_mpu_rate_table));
-	memcpy(omap3_dsp_rate_table, omap34xx_dsp_rate_table,
-			sizeof(omap34xx_dsp_rate_table));
-	memcpy(omap3_l3_rate_table, omap34xx_l3_rate_table,
-			sizeof(omap34xx_l3_rate_table));
+	if (cpu_is_omap3630()) {
+		omap3_mpu_rate_table = kmalloc(sizeof(omap36xx_mpu_rate_table),
+				GFP_KERNEL);
+		omap3_dsp_rate_table = kmalloc(sizeof(omap36xx_dsp_rate_table),
+				GFP_KERNEL);
+		omap3_l3_rate_table = kmalloc(sizeof(omap36xx_l3_rate_table),
+				GFP_KERNEL);
+
+		BUG_ON(!omap3_mpu_rate_table || !omap3_dsp_rate_table ||
+			!omap3_l3_rate_table);
+
+		memcpy(omap3_mpu_rate_table, omap36xx_mpu_rate_table,
+				sizeof(omap36xx_mpu_rate_table));
+		memcpy(omap3_dsp_rate_table, omap36xx_dsp_rate_table,
+				sizeof(omap36xx_dsp_rate_table));
+		memcpy(omap3_l3_rate_table, omap36xx_l3_rate_table,
+				sizeof(omap36xx_l3_rate_table));
+	} else {
+		/* Default to 34xx devices */
+		omap3_mpu_rate_table = kmalloc(sizeof(omap34xx_mpu_rate_table),
+				GFP_KERNEL);
+		omap3_dsp_rate_table = kmalloc(sizeof(omap34xx_dsp_rate_table),
+				GFP_KERNEL);
+		omap3_l3_rate_table = kmalloc(sizeof(omap34xx_l3_rate_table),
+				GFP_KERNEL);
+
+		BUG_ON(!omap3_mpu_rate_table || !omap3_dsp_rate_table ||
+			!omap3_l3_rate_table);
+
+		memcpy(omap3_mpu_rate_table, omap34xx_mpu_rate_table,
+				sizeof(omap34xx_mpu_rate_table));
+		memcpy(omap3_dsp_rate_table, omap34xx_dsp_rate_table,
+				sizeof(omap34xx_dsp_rate_table));
+		memcpy(omap3_l3_rate_table, omap34xx_l3_rate_table,
+				sizeof(omap34xx_l3_rate_table));
+	}
 }
 
 static int __init omap3_pm_early_init(void)
-- 
1.6.3.3

