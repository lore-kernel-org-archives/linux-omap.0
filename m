From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 07/10] cpufreq: OMAP: dont support !freq_table
Date: Thu, 22 Sep 2011 14:07:25 -0700
Message-ID: <1316725648-26710-8-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:41214 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753919Ab1IVVHz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 17:07:55 -0400
In-Reply-To: <1316725648-26710-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Nishanth Menon <nm@ti.com>

OMAP2+ all have frequency tables, hence the hacks we had for older
silicon do not need to be carried forward. As part of this change,
use cpufreq_frequency_table_target to find the best match for
frequency requested.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |   67 +++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index fe943b3..635778d 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -34,8 +34,6 @@
 
 #include <mach/hardware.h>
 
-#define VERY_HI_RATE	900000000
-
 #ifdef CONFIG_SMP
 struct lpj_info {
 	unsigned long	ref;
@@ -53,20 +51,9 @@ static struct device *mpu_dev;
 
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
@@ -84,18 +71,31 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-	int i, ret = 0;
+	unsigned int i;
+	int ret = 0;
 	struct cpufreq_freqs freqs;
 
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
 
 	if (freqs.old == freqs.new && policy->cur == freqs.new)
@@ -161,19 +161,18 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 		return -EINVAL;
 
 	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
-	opp_init_cpufreq_table(mpu_dev, &freq_table);
-
-	if (freq_table) {
-		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-		if (!result)
-			cpufreq_frequency_table_get_attr(freq_table,
-							policy->cpu);
-	} else {
-		policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
-		policy->cpuinfo.max_freq = clk_round_rate(mpu_clk,
-							VERY_HI_RATE) / 1000;
+	result = opp_init_cpufreq_table(mpu_dev, &freq_table);
+
+	if (result) {
+		dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
+				__func__, policy->cpu, result);
+		return result;
 	}
 
+	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	if (!result)
+		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 	policy->cur = omap_getspeed(policy->cpu);
-- 
1.7.6

