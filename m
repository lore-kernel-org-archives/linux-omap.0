From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/3] omap2plus: cpufreq: Add SMP support to cater OMAP4430
Date: Fri, 25 Feb 2011 11:40:39 +0530
Message-ID: <1298614239-32196-4-git-send-email-santosh.shilimkar@ti.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52169 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab1BYGKp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 01:10:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1P6Agjc010789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 00:10:44 -0600
In-Reply-To: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, vishwanath.bs@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP SMP configuartion, both processors share the voltage
and clock. So both CPUs needs to be scaled together and hence
needs software co-ordination.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
cc: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   71 ++++++++++++++++++++++++++----
 1 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 48da867..8c903c1 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -26,9 +26,11 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/opp.h>
+#include <linux/cpu.h>
 
 #include <asm/system.h>
 #include <asm/smp_plat.h>
+#include <asm/cpu.h>
 
 #include <plat/clock.h>
 #include <plat/omap-pm.h>
@@ -63,7 +65,7 @@ static unsigned int omap_getspeed(unsigned int cpu)
 {
 	unsigned long rate;
 
-	if (cpu)
+	if (cpu >= NR_CPUS)
 		return 0;
 
 	rate = clk_get_rate(mpu_clk) / 1000;
@@ -74,9 +76,13 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-	int ret = 0;
+	int i, ret = 0;
 	struct cpufreq_freqs freqs;
 
+	/* Wait untill all CPU's are initialized */
+	if (is_smp() && (num_online_cpus() < NR_CPUS))
+		return ret;
+
 	/* Ensure desired rate is within allowed range.  Some govenors
 	 * (ondemand) will just pass target_freq=0 to get the minimum. */
 	if (target_freq < policy->min)
@@ -84,15 +90,25 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (target_freq > policy->max)
 		target_freq = policy->max;
 
-	freqs.old = omap_getspeed(0);
+	freqs.old = omap_getspeed(policy->cpu);
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
-	freqs.cpu = 0;
+	freqs.cpu = policy->cpu;
 
 	if (freqs.old == freqs.new)
 		return ret;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	if (!is_smp()) {
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+		goto set_freq;
+	}
+
+	/* notifiers */
+	for_each_cpu(i, policy->cpus) {
+		freqs.cpu = i;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
 
+set_freq:
 #ifdef CONFIG_CPU_FREQ_DEBUG
 	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old, freqs.new);
 #endif
@@ -100,6 +116,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
 	if (ret)
 		return ret;
+	freqs.new = omap_getspeed(policy->cpu);
 
 	/*
 	 * Generic CPUFREQ driver jiffy update is under !SMP. So jiffies
@@ -107,12 +124,32 @@ static int omap_target(struct cpufreq_policy *policy,
 	 * CONFIG_SMP enabled. Below code is added only to manage that
 	 * scenario
 	 */
-	if (!is_smp())
+	if (!is_smp()) {
 		loops_per_jiffy =
 			 cpufreq_scale(loops_per_jiffy, freqs.old, freqs.new);
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+		goto skip_lpj;
+	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+#ifdef CONFIG_SMP
+	/*
+	 * Note that loops_per_jiffy is not updated on SMP systems in
+	 * cpufreq driver. So, update the per-CPU loops_per_jiffy value
+	 * on frequency transition. We need to update all dependent cpus
+	 */
+	for_each_cpu(i, policy->cpus)
+		per_cpu(cpu_data, i).loops_per_jiffy =
+			cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
+					freqs.old, freqs.new);
+#endif
+
+	/* notifiers */
+	for_each_cpu(i, policy->cpus) {
+		freqs.cpu = i;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
 
+skip_lpj:
 	return ret;
 }
 
@@ -120,15 +157,16 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
 	struct device *mpu_dev;
+	static cpumask_var_t cpumask;
 
 	mpu_clk = clk_get(NULL, "cpu_ck");
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
-	if (policy->cpu != 0)
+	if (policy->cpu >= NR_CPUS)
 		return -EINVAL;
 
-	policy->cur = policy->min = policy->max = omap_getspeed(0);
+	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
 
 	mpu_dev = omap2_get_mpuss_device();
 	if (!mpu_dev) {
@@ -150,7 +188,20 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
-	policy->cur = omap_getspeed(0);
+	policy->cur = omap_getspeed(policy->cpu);
+
+	/*
+	 * On OMAP SMP configuartion, both processors share the voltage
+	 * and clock. So both CPUs needs to be scaled together and hence
+	 * needs software co-ordination. Use cpufreq affected_cpus
+	 * interface to handle this scenario. Additional is_smp() check
+	 * is to keep SMP_ON_UP builf working.
+	 */
+	if (is_smp()) {
+		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+		cpumask_or(cpumask, cpumask_of(policy->cpu), cpumask);
+		cpumask_copy(policy->cpus, cpumask);
+	}
 
 	/* FIXME: what's the actual transition time? */
 	policy->cpuinfo.transition_latency = 300 * 1000;
-- 
1.6.0.4

