From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH V3 6/8] OMAP2+: cpufreq: fix freq_table leak
Date: Wed, 25 May 2011 16:38:51 -0700
Message-ID: <1306366733-8439-7-git-send-email-nm@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40923 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753571Ab1EYXjW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:39:22 -0400
Received: by ywg8 with SMTP id 8so134945ywg.34
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:39:20 -0700 (PDT)
In-Reply-To: <1306366733-8439-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Since we have multiple CPUs, the cpuinit call for CPU1 causes
freq_table of CPU0 to be overwritten. Instead, we maintain
a counter to keep track of cpus who use the cpufreq table
allocate it once(one freq table for all CPUs) and free them
once the last user is done with it. We also need to protect
freq_table and this new counter from updates from multiple
contexts to be on a safe side.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   62 +++++++++++++++++++++++++++----
 1 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 3ff3302..f026ac4 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -39,6 +39,9 @@
 #include <mach/hardware.h>
 
 static struct cpufreq_frequency_table *freq_table;
+static int freq_table_users;
+static DEFINE_MUTEX(freq_table_lock);
+
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
 static struct device *mpu_dev;
@@ -46,9 +49,17 @@ static bool use_opp;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
+	int r = -EINVAL;
+
+	mutex_lock(&freq_table_lock);
 	if (!freq_table)
-		return -EINVAL;
-	return cpufreq_frequency_table_verify(policy, freq_table);
+		goto out;
+
+	r = cpufreq_frequency_table_verify(policy, freq_table);
+
+out:
+	mutex_unlock(&freq_table_lock);
+	return r;
 }
 
 static unsigned int omap_getspeed(unsigned int cpu)
@@ -74,9 +85,11 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (is_smp() && (num_online_cpus() < NR_CPUS))
 		return ret;
 
+	mutex_lock(&freq_table_lock);
 	if (!freq_table) {
 		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
 				policy->cpu);
+		mutex_unlock(&freq_table_lock);
 		return -EINVAL;
 	}
 
@@ -85,9 +98,13 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (ret) {
 		dev_dbg(mpu_dev, "%s: cpu%d: no freq match for %d(ret=%d)\n",
 			__func__, policy->cpu, target_freq, ret);
+		mutex_unlock(&freq_table_lock);
 		return ret;
 	}
+
 	freqs.new = freq_table[i].frequency;
+	mutex_unlock(&freq_table_lock);
+
 	if (!freqs.new) {
 		dev_err(mpu_dev, "%s: cpu%d: no match for freq %d\n", __func__,
 			policy->cpu, target_freq);
@@ -156,22 +173,48 @@ skip_lpj:
 
 static int freq_table_alloc(void)
 {
-	if (use_opp)
-		return opp_init_cpufreq_table(mpu_dev, &freq_table);
+	int ret = 0;
 
-	clk_init_cpufreq_table(&freq_table);
-	if (!freq_table)
-		return -ENOMEM;
+	mutex_lock(&freq_table_lock);
 
-	return 0;
+	freq_table_users++;
+	/* Did we allocate previously? */
+	if (freq_table_users - 1)
+		goto out;
+
+	/* no, so we allocate */
+	if (use_opp) {
+		ret = opp_init_cpufreq_table(mpu_dev, &freq_table);
+	} else {
+		clk_init_cpufreq_table(&freq_table);
+		if (!freq_table)
+			ret = -ENOMEM;
+	}
+	/* if we did not allocate cleanly.. reduce user count */
+	if (!ret)
+		freq_table_users--;
+
+out:
+	mutex_unlock(&freq_table_lock);
+	return ret;
 }
 
 static void freq_table_free(void)
 {
+	mutex_lock(&freq_table_lock);
+
+	if (!freq_table_users)
+		goto out;
+	freq_table_users--;
+	if (freq_table_users)
+		goto out;
+
 	if (use_opp)
 		opp_free_cpufreq_table(mpu_dev, &freq_table);
 	else
 		clk_exit_cpufreq_table(&freq_table);
+out:
+	mutex_unlock(&freq_table_lock);
 }
 
 static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
@@ -195,14 +238,17 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 		return result;
 	}
 
+	mutex_lock(&freq_table_lock);
 	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
 	if (result) {
+		mutex_unlock(&freq_table_lock);
 		dev_err(mpu_dev, "%s: cpu%d: unable to get cpuinfo [%d]\n",
 			__func__, policy->cpu, result);
 		freq_table_free();
 		return result;
 	}
 	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+	mutex_unlock(&freq_table_lock);
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
-- 
1.7.1

