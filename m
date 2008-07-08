From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 08/09] omap pm srf updates
Date: Tue, 8 Jul 2008 17:09:32 +0530
Message-ID: <030f01c8e0ef$4a5996d0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49327 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723AbYGHLjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 07:39:42 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m68BdXjM021824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 06:39:41 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m68BdIxN005245
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 17:09:32 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Updates the omap-pm apis with calls to SRF implementation

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/plat-omap/omap-pm-srf.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/omap-pm-srf.c	2008-07-08 10:58:42.697655141 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c	2008-07-08 11:26:35.267751062 +0530
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
+#include <linux/module.h>
 
 #include <asm/arch/omap-pm.h>
 #include <asm/arch/powerdomain.h>
@@ -267,6 +268,7 @@ void omap_pm_set_max_dma_lat(struct devi
 	}
 }
 
+static struct device dummy_dsp_dev;
 
 /*
  * DSP Bridge-specific constraints
@@ -303,8 +305,13 @@ void omap_pm_dsp_set_min_opp(u8 opp_id)
 	 * if it is higher than the current OPP clock rate.
 	 *
 	 */
+	/* For now pass a dummy_dev struct for SRF to identify the caller.
+	 * Maybe its good to have DSP pass this as an argument
+	 */
+	resource_request("vdd1_opp", &dummy_dsp_dev, opp_id);
+	return;
 }
-
+EXPORT_SYMBOL(omap_pm_dsp_set_min_opp);
 /**
  * omap_pm_dsp_get_opp - report the current DSP OPP ID
  *
@@ -326,9 +333,9 @@ u8 omap_pm_dsp_get_opp(void)
 	 * Call clk_get_rate() on the OPP custom clock, map that to an
 	 * OPP ID using the tables defined in board-*.c/chip-*.c files.
 	 */
-
-	return 0;
+	return resource_get_level("vdd1_opp");
 }
+EXPORT_SYMBOL(omap_pm_dsp_get_opp);
 
 /*
  * CPUFreq-originated constraint
@@ -351,6 +358,7 @@ struct cpufreq_frequency_table **omap_pm
 	return NULL;
 }
 
+static struct device dummy_cpufreq_dev;
 /**
  * omap_pm_cpu_set_freq - set the current minimum MPU frequency
  * @f: MPU frequency in Hz
@@ -378,7 +386,10 @@ void omap_pm_cpu_set_freq(unsigned long 
 	 *
 	 * CDP should just be able to set the VDD1 OPP clock rate here.
 	 */
+	resource_request("mpu_freq", &dummy_cpufreq_dev, f);
+	return;
 }
+EXPORT_SYMBOL(omap_pm_cpu_set_freq);
 
 /**
  * omap_pm_cpu_get_freq - report the current CPU frequency
@@ -392,9 +403,9 @@ unsigned long omap_pm_cpu_get_freq(void)
 	/*
 	 * Call clk_get_rate() on the mpu_ck.
 	 */
-
-	return 0;
+	return resource_get_level("mpu_freq");
 }
+EXPORT_SYMBOL(omap_pm_cpu_get_freq);
 
 struct device omap_pm_dev;
 

