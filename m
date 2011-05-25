From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH V3 4/8] OMAP2+: cpufreq: dont support !freq_table
Date: Wed, 25 May 2011 16:38:49 -0700
Message-ID: <1306366733-8439-5-git-send-email-nm@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46145 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754904Ab1EYXjO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:39:14 -0400
Received: by gwj20 with SMTP id 20so92188gwj.26
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:39:13 -0700 (PDT)
In-Reply-To: <1306366733-8439-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

OMAP2+ all have frequency tables, hence the hacks we had for older
silicon do not need to be carried forward. As part of this change,
use cpufreq_frequency_table_target to find the best match for
frequency requested.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   64 +++++++++++++++---------------
 1 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index dbbf8b2..7c0eb77 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -38,8 +38,6 @@
 
 #include <mach/hardware.h>
 
-#define VERY_HI_RATE	900000000
-
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
@@ -48,20 +46,9 @@ static bool use_opp;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
-	if (freq_table)
-		return cpufreq_frequency_table_verify(policy, freq_table);
-
-	if (policy->cpu)
+	if (!freq_table)
 		return -EINVAL;
-
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     policy->cpuinfo.max_freq);
-
-	policy->min = clk_round_rate(mpu_clk, policy->min * 1000) / 1000;
-	policy->max = clk_round_rate(mpu_clk, policy->max * 1000) / 1000;
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     policy->cpuinfo.max_freq);
-	return 0;
+	return cpufreq_frequency_table_verify(policy, freq_table);
 }
 
 static unsigned int omap_getspeed(unsigned int cpu)
@@ -79,22 +66,35 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-	int i, ret = 0;
+	unsigned int i;
+	int ret = 0;
 	struct cpufreq_freqs freqs;
 
 	/* Changes not allowed until all CPUs are online */
 	if (is_smp() && (num_online_cpus() < NR_CPUS))
 		return ret;
 
-	/* Ensure desired rate is within allowed range.  Some govenors
-	 * (ondemand) will just pass target_freq=0 to get the minimum. */
-	if (target_freq < policy->min)
-		target_freq = policy->min;
-	if (target_freq > policy->max)
-		target_freq = policy->max;
+	if (!freq_table) {
+		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
+				policy->cpu);
+		return -EINVAL;
+	}
+
+	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
+			relation, &i);
+	if (ret) {
+		dev_dbg(mpu_dev, "%s: cpu%d: no freq match for %d(ret=%d)\n",
+			__func__, policy->cpu, target_freq, ret);
+		return ret;
+	}
+	freqs.new = freq_table[i].frequency;
+	if (!freqs.new) {
+		dev_err(mpu_dev, "%s: cpu%d: no match for freq %d\n", __func__,
+			policy->cpu, target_freq);
+		return -EINVAL;
+	}
 
 	freqs.old = omap_getspeed(policy->cpu);
-	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = policy->cpu;
 
 	if (freqs.old == freqs.new)
@@ -172,17 +172,17 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	else
 		clk_init_cpufreq_table(&freq_table);
 
-	if (freq_table) {
-		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-		if (!result)
-			cpufreq_frequency_table_get_attr(freq_table,
-							policy->cpu);
-	} else {
-		policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
-		policy->cpuinfo.max_freq = clk_round_rate(mpu_clk,
-							VERY_HI_RATE) / 1000;
+	if (!freq_table) {
+		dev_err(mpu_dev, "%s: cpu%d: unable to allocate freq table\n",
+				__func__, policy->cpu);
+		return -ENOMEM;
 	}
 
+	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	if (!result)
+		cpufreq_frequency_table_get_attr(freq_table,
+						policy->cpu);
+
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 	policy->cur = omap_getspeed(policy->cpu);
-- 
1.7.1

