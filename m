From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 05/08] OMAP3 SRF: Update OMAP-PM layer
Date: Mon, 10 Nov 2008 16:58:47 +0530
Message-ID: <00c301c94327$7f2fbbb0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37981 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496AbYKJL2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:28:55 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAABSmhq002249
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 05:28:53 -0600
Received: from wipultra1382 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAABSlIs013047
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 16:58:47 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch updates the omap-pm apis with calls to SRF
implementation.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/omap-pm-srf.c |   51 +++++++++++++--------------------------
 1 files changed, 17 insertions(+), 34 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/omap-pm-srf.c	2008-11-10 12:09:13.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c	2008-11-10 12:09:14.000000000 +0530
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
+#include <linux/module.h>
 
 #include <mach/omap-pm.h>
 #include <mach/powerdomain.h>
@@ -173,6 +174,7 @@ void omap_pm_set_max_sdma_lat(struct dev
 	}
 }
 
+static struct device dummy_dsp_dev;
 
 /*
  * DSP Bridge-specific constraints
@@ -188,6 +190,7 @@ const struct omap_opp *omap_pm_dsp_get_o
 
 	return NULL;
 }
+EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);
 
 void omap_pm_dsp_set_min_opp(u8 opp_id)
 {
@@ -199,34 +202,21 @@ void omap_pm_dsp_set_min_opp(u8 opp_id)
 	pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be %d\n", opp_id);
 
 	/*
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
+	 * For now pass a dummy_dev struct for SRF to identify the caller.
+	 * Maybe its good to have DSP pass this as an argument
 	 */
+	resource_request("vdd1_opp", &dummy_dsp_dev, opp_id);
+	return;
 }
+EXPORT_SYMBOL(omap_pm_dsp_set_min_opp);
 
 u8 omap_pm_dsp_get_opp(void)
 {
 	pr_debug("OMAP PM: DSP requests current DSP OPP ID\n");
-
-	/*
-	 * For l-o dev tree, call clk_get_rate() on VDD1 OPP clock
-	 *
-	 * CDP12.14+:
-	 * Call clk_get_rate() on the OPP custom clock, map that to an
-	 * OPP ID using the tables defined in board-*.c/chip-*.c files.
-	 */
-
+	return resource_get_level("vdd1_opp");
 	return 0;
 }
+EXPORT_SYMBOL(omap_pm_dsp_get_opp);
 
 /*
  * CPUFreq-originated constraint
@@ -248,6 +238,8 @@ struct cpufreq_frequency_table **omap_pm
 	return NULL;
 }
 
+static struct device dummy_cpufreq_dev;
+
 void omap_pm_cpu_set_freq(unsigned long f)
 {
 	if (f == 0) {
@@ -258,26 +250,17 @@ void omap_pm_cpu_set_freq(unsigned long 
 	pr_debug("OMAP PM: CPUFreq requests CPU frequency to be set to %lu\n",
 		 f);
 
-	/*
-	 * For l-o dev tree, determine whether MPU freq or DSP OPP id
-	 * freq is higher.  Find the OPP ID corresponding to the
-	 * higher frequency.  Call clk_round_rate() and clk_set_rate()
-	 * on the OPP custom clock.
-	 *
-	 * CDP should just be able to set the VDD1 OPP clock rate here.
-	 */
+	resource_request("mpu_freq", &dummy_cpufreq_dev, f);
+	return;
 }
+EXPORT_SYMBOL(omap_pm_cpu_set_freq);
 
 unsigned long omap_pm_cpu_get_freq(void)
 {
 	pr_debug("OMAP PM: CPUFreq requests current CPU frequency\n");
-
-	/*
-	 * Call clk_get_rate() on the mpu_ck.
-	 */
-
-	return 0;
+	return resource_get_level("mpu_freq");
 }
+EXPORT_SYMBOL(omap_pm_cpu_get_freq);
 
 /*
  * Device context loss tracking

