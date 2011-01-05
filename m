From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP: Cpufreq: Clean up to support multi omap builds
Date: Wed,  5 Jan 2011 21:53:33 +0530
Message-ID: <1294244613-25798-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35212 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab1AEQXt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 11:23:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, khilman@ti.com, Thara Gopinath <thara@ti.com>

This is an attempt to clean up the omap
cpufreq driver so that it functions properly even with
multi omap builds. The main changes involve removal of
static CONFIG_ARCH_X checks and introducing relevant
cpu_is_X checks instead.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
This patch is agains pm-cpufreq branch of Kevin Hilman's
OMAP PM tree as rest of the cpufreq driver patches for OMAP
are staged there. To test this patch i have applied it against
my dvfs tree (details of which are mentioned below) and tested
dvfs on OMAP3.
        http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=summary
        head - pm-improved-dvfs

 arch/arm/plat-omap/cpu-omap.c |  113 +++++++++++++++++++++++++++--------------
 1 files changed, 74 insertions(+), 39 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 1c1b80b..a5f787f 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -29,25 +29,20 @@
 
 #include <mach/hardware.h>
 #include <plat/clock.h>
-#include <asm/system.h>
-
-#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-#include <plat/omap-pm.h>
 #include <plat/common.h>
-#endif
+#include <plat/omap-pm.h>
+#include <asm/system.h>
 
 #define VERY_HI_RATE	900000000
 
-static struct cpufreq_frequency_table *freq_table;
-
-#ifdef CONFIG_ARCH_OMAP1
-#define MPU_CLK		"mpu"
-#elif defined(CONFIG_ARCH_OMAP3)
-#define MPU_CLK		"arm_fck"
-#else
-#define MPU_CLK		"virt_prcm_set"
-#endif
+#define OMAP1_MPU_CLK		"mpu"
+#define OMAP2_MPU_CLK		"virt_prcm_set"
+#define OMAP3_MPU_CLK		"dpll1_ck"
 
+static void (*arch_cpu_init) (void);
+static int (*arch_cpu_target) (unsigned long freq);
+static struct cpufreq_frequency_table *freq_table;
+static char *mpu_clk_name;
 static struct clk *mpu_clk;
 
 /* TODO: Add support for SDRAM timing changes */
@@ -81,17 +76,32 @@ static unsigned int omap_getspeed(unsigned int cpu)
 	return rate;
 }
 
+static int omap1_cpu_target(unsigned long freq)
+{
+	return clk_set_rate(mpu_clk, freq);
+}
+
+static int omap2plus_cpu_target(unsigned long freq)
+{
+#ifndef CONFIG_OMAP_PM_NONE
+	struct device *mpu_dev = omap2_get_mpuss_device();
+
+	if (!mpu_dev) {
+		pr_warning("%s: unable to get the mpu device\n", __func__);
+		return -EINVAL;
+	}
+
+	if (opp_find_freq_ceil(mpu_dev, &freq))
+		omap_pm_cpu_set_freq(freq);
+#endif
+	return 0;
+}
+
 static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-#ifdef CONFIG_ARCH_OMAP1
 	struct cpufreq_freqs freqs;
-#endif
-#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	unsigned long freq;
-	struct device *mpu_dev = omap2_get_mpuss_device();
-#endif
 	int ret = 0;
 
 	/* Ensure desired rate is within allowed range.  Some govenors
@@ -101,33 +111,49 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (target_freq > policy->max)
 		target_freq = policy->max;
 
-#ifdef CONFIG_ARCH_OMAP1
 	freqs.old = omap_getspeed(0);
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = 0;
-
 	if (freqs.old == freqs.new)
 		return ret;
+
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
 #ifdef CONFIG_CPU_FREQ_DEBUG
 	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
 	       freqs.old, freqs.new);
 #endif
-	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-#elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	freq = target_freq * 1000;
-	if (opp_find_freq_ceil(mpu_dev, &freq))
-		omap_pm_cpu_set_freq(freq);
-#endif
+
+	ret = arch_cpu_target(freqs.new * 1000);
+
+	if (!ret)
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
 	return ret;
 }
 
+static void omap1_cpu_init(void)
+{
+	clk_init_cpufreq_table(&freq_table);
+}
+
+static void omap3_cpu_init(void)
+{
+	struct device *mpu_dev = omap2_get_mpuss_device();
+
+	if (!mpu_dev) {
+		pr_warning("%s: unable to get the mpu device\n", __func__);
+		return;
+	}
+
+	opp_init_cpufreq_table(mpu_dev, &freq_table);
+}
+
 static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
 
-	mpu_clk = clk_get(NULL, MPU_CLK);
+	mpu_clk = clk_get(NULL, mpu_clk_name);
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
@@ -136,13 +162,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = policy->min = policy->max = omap_getspeed(0);
 
-	if (!cpu_is_omap34xx()) {
-		clk_init_cpufreq_table(&freq_table);
-	} else {
-		struct device *mpu_dev = omap2_get_mpuss_device();
-
-		opp_init_cpufreq_table(mpu_dev, &freq_table);
-	}
+	arch_cpu_init();
 
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
@@ -190,9 +210,25 @@ static struct cpufreq_driver omap_driver = {
 
 static int __init omap_cpufreq_init(void)
 {
+	if (cpu_class_is_omap1()) {
+		mpu_clk_name = OMAP1_MPU_CLK;
+		arch_cpu_init = omap1_cpu_init;
+		arch_cpu_target = omap1_cpu_target;
+	} else if (cpu_is_omap24xx()) {
+		mpu_clk_name = OMAP2_MPU_CLK;
+		arch_cpu_init = omap1_cpu_init;
+		arch_cpu_target = omap2plus_cpu_target;
+	} else if (cpu_is_omap34xx()) {
+		mpu_clk_name = OMAP3_MPU_CLK;
+		arch_cpu_init = omap3_cpu_init;
+		arch_cpu_target = omap2plus_cpu_target;
+	} else {
+		pr_warning("%s: cpufreq support not yet added\n", __func__);
+		return -EINVAL;
+	}
+
 	return cpufreq_register_driver(&omap_driver);
 }
-
 late_initcall(omap_cpufreq_init);
 
 /*
@@ -201,4 +237,3 @@ late_initcall(omap_cpufreq_init);
  * cpufreq_unregister_driver()
  * cpufreq_frequency_table_put_attr()
  */
-
-- 
1.7.0.4

