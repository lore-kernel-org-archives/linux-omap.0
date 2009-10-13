From: "Dasgupta, Romit" <romit@ti.com>
Subject: FW: [PATCH] omap-pm: Fixes behaviour of some shared resource
 framework functions
Date: Tue, 13 Oct 2009 11:28:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDE2057D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48888 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744AbZJMF7e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 01:59:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9D5wtjM000914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 00:58:58 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9D5wsMj015841
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 11:28:55 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Kevin,
                       Are there any comments on this patch? If not, will it be queued?

Thanks,
-Romit


-----Original Message-----
From: Dasgupta, Romit 
Sent: Wednesday, October 07, 2009 6:12 PM
To: Kevin H
Cc: linux-omap@vger.kernel.org
Subject: [PATCH] omap-pm: Fixes behaviour of some shared resource framework functions

(Tested on Zoom2).

'omap_pm_dsp_set_min_opp' & 'omap_pm_cpu_set_freq' were using their own
struct device *. This is a problem because invoking these functions from
different clients would result in setting of the resource level as requested by
the last caller. Fixes this by introducing a struct device * to the parameter
list for these functions.
Signed-off-by: Romit Dasgupta <romit@ti.com>
---

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 8e67861..e9adc67 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -47,6 +47,7 @@ static struct cpufreq_frequency_table *freq_table;
 #define MPU_CLK		"virt_prcm_set"
 #endif
 
+DEFINE_PER_CPU(struct device , cpu_freq_dev);
 static struct clk *mpu_clk;
 
 /* TODO: Add support for SDRAM timing changes */
@@ -115,8 +116,9 @@ static int omap_target(struct cpufreq_policy *policy,
 		int ind;
 		for (ind = 1; ind <= MAX_VDD1_OPP; ind++) {
 			if (mpu_opps[ind].rate/1000 >= target_freq) {
-				omap_pm_cpu_set_freq
-					(mpu_opps[ind].rate);
+				omap_pm_cpu_set_freq(
+					&__get_cpu_var(cpu_freq_dev),
+					mpu_opps[ind].rate);
 				break;
 			}
 		}
diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h b/arch/arm/plat-omap/include/mach/omap-pm.h
index 583e540..5b26ba1 100644
--- a/arch/arm/plat-omap/include/mach/omap-pm.h
+++ b/arch/arm/plat-omap/include/mach/omap-pm.h
@@ -226,6 +226,7 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void);
 
 /**
  * omap_pm_dsp_set_min_opp - receive desired OPP target ID from DSP Bridge
+ * @dev: Identifies the client that wants to set the VDD1 OPP.
  * @opp_id: target DSP OPP ID
  *
  * Set a minimum OPP ID for the DSP.  This is intended to be called
@@ -233,7 +234,7 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void);
  * information that code receives from the DSP/BIOS load estimator is the
  * target OPP ID; hence, this interface.  No return value.
  */
-void omap_pm_dsp_set_min_opp(u8 opp_id);
+void omap_pm_dsp_set_min_opp(struct device *dev, u8 opp_id);
 
 /**
  * omap_pm_dsp_get_opp - report the current DSP OPP ID
@@ -283,6 +284,7 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void);
 
 /**
  * omap_pm_cpu_set_freq - set the current minimum MPU frequency
+ * @dev: Identifies the client that wants to set the frequency.
  * @f: MPU frequency in Hz
  *
  * Set the current minimum CPU frequency.  The actual CPU frequency
@@ -290,7 +292,7 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void);
  * Intended to be called by plat-omap/cpu_omap.c:omap_target().  No
  * return value.
  */
-void omap_pm_cpu_set_freq(unsigned long f);
+void omap_pm_cpu_set_freq(struct device *dev, unsigned long f);
 
 /**
  * omap_pm_cpu_get_freq - report the current CPU frequency
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 10463a4..6546527 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -159,7 +159,7 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void)
 }
 EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);
 
-void omap_pm_dsp_set_min_opp(u8 opp_id)
+void omap_pm_dsp_set_min_opp(struct device *dev, u8 opp_id)
 {
 	if (opp_id == 0) {
 		WARN_ON(1);
@@ -244,7 +244,7 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void)
 	return NULL;
 }
 
-void omap_pm_cpu_set_freq(unsigned long f)
+void omap_pm_cpu_set_freq(struct device *dev, unsigned long f)
 {
 	if (f == 0) {
 		WARN_ON(1);
diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index 4350650..aece740 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -169,8 +169,6 @@ void omap_pm_set_max_sdma_lat(struct device *dev, long t)
 	}
 }
 
-static struct device dummy_dsp_dev;
-
 /*
  * DSP Bridge-specific constraints
  */
@@ -187,20 +185,15 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void)
 }
 EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);
 
-void omap_pm_dsp_set_min_opp(u8 opp_id)
+void omap_pm_dsp_set_min_opp(struct device *dev, u8 opp_id)
 {
-	if (opp_id == 0) {
+	if (dev == NULL || opp_id == 0) {
 		WARN_ON(1);
 		return;
 	}
 
 	pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be %d\n", opp_id);
-
-	/*
-	 * For now pass a dummy_dev struct for SRF to identify the caller.
-	 * Maybe its good to have DSP pass this as an argument
-	 */
-	resource_request("vdd1_opp", &dummy_dsp_dev, opp_id);
+	resource_request("vdd1_opp", dev, opp_id);
 	return;
 }
 EXPORT_SYMBOL(omap_pm_dsp_set_min_opp);
@@ -246,19 +239,16 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void)
 	return NULL;
 }
 
-static struct device dummy_cpufreq_dev;
-
-void omap_pm_cpu_set_freq(unsigned long f)
+void omap_pm_cpu_set_freq(struct device *dev, unsigned long f)
 {
-	if (f == 0) {
+	if (dev == NULL || f == 0) {
 		WARN_ON(1);
 		return;
 	}
 
 	pr_debug("OMAP PM: CPUFreq requests CPU frequency to be set to %lu\n",
 		 f);
-
-	resource_request("mpu_freq", &dummy_cpufreq_dev, f);
+	resource_request("mpu_freq", dev, f);
 	return;
 }
 EXPORT_SYMBOL(omap_pm_cpu_set_freq);
