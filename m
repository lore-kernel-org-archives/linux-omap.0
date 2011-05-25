From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH V3 5/8] OMAP2+: cpufreq: fix invalid cpufreq table with central alloc/free
Date: Wed, 25 May 2011 16:38:50 -0700
Message-ID: <1306366733-8439-6-git-send-email-nm@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:40224 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754631Ab1EYXjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:39:18 -0400
Received: by yia27 with SMTP id 27so92538yia.5
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:39:17 -0700 (PDT)
In-Reply-To: <1306366733-8439-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

By creating freq_table_[alloc|free] we can handle the differences
between OMAP2 and OMAP3+ systems and we have a centralized allocation
and cleanup strategy. We use this to cleanup the freq_table when
cpufreq_frequency_table_cpuinfo fails.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   48 +++++++++++++++++++++---------
 1 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 7c0eb77..3ff3302 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -154,6 +154,26 @@ skip_lpj:
 	return ret;
 }
 
+static int freq_table_alloc(void)
+{
+	if (use_opp)
+		return opp_init_cpufreq_table(mpu_dev, &freq_table);
+
+	clk_init_cpufreq_table(&freq_table);
+	if (!freq_table)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void freq_table_free(void)
+{
+	if (use_opp)
+		opp_free_cpufreq_table(mpu_dev, &freq_table);
+	else
+		clk_exit_cpufreq_table(&freq_table);
+}
+
 static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
@@ -167,21 +187,22 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 		return -EINVAL;
 
 	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
-	if (use_opp)
-		opp_init_cpufreq_table(mpu_dev, &freq_table);
-	else
-		clk_init_cpufreq_table(&freq_table);
 
-	if (!freq_table) {
-		dev_err(mpu_dev, "%s: cpu%d: unable to allocate freq table\n",
-				__func__, policy->cpu);
-		return -ENOMEM;
+	result = freq_table_alloc();
+	if (result || !freq_table) {
+		dev_err(mpu_dev, "%s: cpu%d: unable to get freq table [%d]\n",
+			__func__, policy->cpu, result);
+		return result;
 	}
 
 	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-	if (!result)
-		cpufreq_frequency_table_get_attr(freq_table,
-						policy->cpu);
+	if (result) {
+		dev_err(mpu_dev, "%s: cpu%d: unable to get cpuinfo [%d]\n",
+			__func__, policy->cpu, result);
+		freq_table_free();
+		return result;
+	}
+	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
@@ -208,10 +229,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (use_opp)
-		opp_free_cpufreq_table(mpu_dev, &freq_table);
-	else
-		clk_exit_cpufreq_table(&freq_table);
+	freq_table_free();
 	clk_put(mpu_clk);
 	return 0;
 }
-- 
1.7.1

