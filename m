From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 3/10] OPP layer and additional cleanups.
Date: Thu, 31 Dec 2009 18:59:12 +0530
Message-ID: <1262266152.20175.179.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40813 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbZLaN3U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:29:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Change in the resource arbitration APIs to use the OPP layer.

diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index f7437f7..f59c4aa 100644
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
@@ -158,42 +154,21 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void)
 	return NULL;
 }
 
-void omap_pm_dsp_set_min_opp(u8 opp_id)
+void omap_pm_dsp_set_min_freq(unsigned long freq)
 {
-	if (opp_id == 0) {
+	if (!freq) {
 		WARN_ON(1);
 		return;
 	}
 
-	pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be %d\n", opp_id);
+	pr_debug("OMAP PM: DSP requests minimum DSP freq to be %lu\n", freq);
 
-	/*
-	 *
-	 * For l-o dev tree, our VDD1 clk is keyed on OPP ID, so we
-	 * can just test to see which is higher, the CPU's desired OPP
-	 * ID or the DSP's desired OPP ID, and use whichever is
-	 * highest.
-	 *
-	 * In CDP12.14+, the VDD1 OPP custom clock that controls the DSP
-	 * rate is keyed on MPU speed, not the OPP ID.  So we need to
-	 * map the OPP ID to the MPU speed for use with clk_set_rate()
-	 * if it is higher than the current OPP clock rate.
-	 *
-	 */
 }
 
 
-u8 omap_pm_dsp_get_opp(void)
+unsigned long omap_pm_dsp_get_freq(void)
 {
-	pr_debug("OMAP PM: DSP requests current DSP OPP ID\n");
-
-	/*
-	 * For l-o dev tree, call clk_get_rate() on VDD1 OPP clock
-	 *
-	 * CDP12.14+:
-	 * Call clk_get_rate() on the OPP custom clock, map that to an
-	 * OPP ID using the tables defined in board-*.c/chip-*.c files.
-	 */
+	pr_debug("OMAP PM: DSP requests current DSP freq\n");
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index f7bf353..0736d6a 100644
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
 
@@ -78,16 +74,17 @@ void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 		WARN_ON(1);
 		return;
 	};
+#warning "Convert throughput to L3 frequency before invoking resource_request"
 
 	if (r == 0) {
 		pr_debug("OMAP PM: remove min bus tput constraint: "
 			 "dev %s for agent_id %d\n", dev_name(dev), agent_id);
-		resource_release("vdd2_opp", dev);
+		resource_release("l3_freq", dev);
 	} else {
 		pr_debug("OMAP PM: add min bus tput constraint: "
 			 "dev %s for agent_id %d: rate %ld KiB\n",
 			 dev_name(dev), agent_id, r);
-		resource_request("vdd2_opp", dev, r);
+		resource_request("l3_freq", dev, r);
 	}
 }
 
@@ -168,42 +165,27 @@ void omap_pm_set_max_sdma_lat(struct device *dev, long t)
 
 static struct device dummy_dsp_dev;
 
-/*
- * DSP Bridge-specific constraints
- */
-const struct omap_opp *omap_pm_dsp_get_opp_table(void)
-{
-	pr_debug("OMAP PM: DSP request for OPP table\n");
-
-	/*
-	 * Return DSP frequency table here:  The final item in the
-	 * array should have .rate = .opp_id = 0.
-	 */
-
-	return NULL;
-}
-
-void omap_pm_dsp_set_min_opp(u8 opp_id)
+void omap_pm_dsp_set_min_freq(unsigned long freq)
 {
-	if (opp_id == 0) {
+	if (!freq) {
 		WARN_ON(1);
 		return;
 	}
 
-	pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be %d\n", opp_id);
+	pr_debug("OMAP PM: DSP requests minimum DSP freq to be %lu\n", freq);
 
 	/*
 	 * For now pass a dummy_dev struct for SRF to identify the caller.
 	 * Maybe its good to have DSP pass this as an argument
 	 */
-	resource_request("vdd1_opp", &dummy_dsp_dev, opp_id);
+	resource_request("dsp_freq", &dummy_dsp_dev, freq);
 	return;
 }
 
-u8 omap_pm_dsp_get_opp(void)
+unsigned long omap_pm_dsp_get_freq(void)
 {
-	pr_debug("OMAP PM: DSP requests current DSP OPP ID\n");
-	return resource_get_level("vdd1_opp");
+	pr_debug("OMAP PM: DSP requests current DSP frequency\n");
+	return resource_get_level("dsp_freq");
 	return 0;
 }
 
Change in the resource arbitration APIs to use the OPP layer.



