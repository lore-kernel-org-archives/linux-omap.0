From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 10/10] OPP layer and additional cleanups
Date: Thu, 31 Dec 2009 18:59:39 +0530
Message-ID: <1262266179.20175.186.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47343 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbZLaN3r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:29:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

1. Honor the CPUFREQ_RELATION{H|L} flags.
2. Introduce the L3 frequency change notifier call back so that L3 frequency
   can be cleanly handled along with MPU.

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 78986f0..26fcae1 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -33,6 +33,8 @@
 #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 #include <plat/omap-pm.h>
 #include <plat/opp.h>
+#include <plat/resource.h>
+#include "../mach-omap2/pm.h"
 #endif
 
 #define VERY_HI_RATE	900000000
@@ -48,6 +50,7 @@ static struct cpufreq_frequency_table *freq_table;
 #endif
 
 static struct clk *mpu_clk;
+static struct device l3_dev;
 
 /* TODO: Add support for SDRAM timing changes */
 
@@ -87,6 +90,10 @@ static int omap_target(struct cpufreq_policy *policy,
 #ifdef CONFIG_ARCH_OMAP1
 	struct cpufreq_freqs freqs;
 #endif
+#ifdef CONFIG_ARCH_OMAP3
+	struct omap_opp *opp;
+	unsigned long freq;
+#endif
 	int ret = 0;
 
 	/* Ensure desired rate is within allowed range.  Some govenors
@@ -111,15 +118,66 @@ static int omap_target(struct cpufreq_policy *policy,
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	if (mpu_opps) {
-		unsigned long freq = target_freq * 1000;
-		if (!IS_ERR(opp_find_freq_ceil(mpu_opps, &freq)))
-			omap_pm_cpu_set_freq(freq);
+	freq = target_freq * 1000;
+	opp = find_opp_by_freq(OPP_MPU, freq, OPP_EQ | OPP_ENABLED);
+	if (!opp) {
+		if (relation == CPUFREQ_RELATION_H)
+			opp = find_opp_by_freq(OPP_MPU, freq,
+						OPP_H | OPP_ENABLED);
+		else if (relation == CPUFREQ_RELATION_L)
+			opp = find_opp_by_freq(OPP_MPU, freq,
+						OPP_L | OPP_ENABLED);
 	}
+
+	if (opp)
+		omap_pm_cpu_set_freq(opp_to_freq(opp));
+	else
+		ret = -EPERM;
 #endif
 	return ret;
 }
 
+static int l3_cpufreq_notifier(struct notifier_block *nb,
+				unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	struct omap_opp *mpu_target_opp;
+	unsigned long l3_target_freq;
+
+	switch (val) {
+	case CPUFREQ_PRECHANGE:
+		mpu_target_opp = find_opp_by_freq(OPP_MPU, freq->new * 1000,
+					OPP_EQ | OPP_ENABLED);
+		l3_target_freq = get_l3_target_freq(mpu_target_opp);
+		if (resource_get_level("l3_freq") != l3_target_freq)
+			resource_request("l3_freq", &l3_dev, l3_target_freq);
+		break;
+
+	case CPUFREQ_POSTCHANGE:
+		break;
+
+	case CPUFREQ_RESUMECHANGE:
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block l3_cpufreq_notifier_block = {
+	.notifier_call = l3_cpufreq_notifier
+};
+
+static void __init l3_cpufreq_init(void)
+{
+	if (cpufreq_register_notifier(&l3_cpufreq_notifier_block,
+					CPUFREQ_TRANSITION_NOTIFIER))
+		pr_err("omap-cpufreq: L3 cpufreq registration failed\n");
+	return;
+}
+
 static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
@@ -131,12 +189,10 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 	if (policy->cpu != 0)
 		return -EINVAL;
 
-	policy->cur = policy->min = policy->max = omap_getspeed(0);
-
 	if (!cpu_is_omap34xx())
 		clk_init_cpufreq_table(&freq_table);
 	else
-		opp_init_cpufreq_table(mpu_opps, &freq_table);
+		opp_init_cpufreq_table(&freq_table);
 
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
@@ -151,10 +207,11 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
-	policy->cur = omap_getspeed(0);
+	policy->cur = omap_getspeed(smp_processor_id());
 
 	/* FIXME: what's the actual transition time? */
 	policy->cpuinfo.transition_latency = 300 * 1000;
+	l3_cpufreq_init();
 
 	return 0;
 }


