From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH 6/6 v2] OMAP2+: cpufreq: fix freq_table leak
Date: Wed, 18 May 2011 02:37:46 -0500
Message-ID: <1305704266-17623-7-git-send-email-nm@ti.com>
References: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40034 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755038Ab1ERHiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 03:38:06 -0400
Received: by mail-yx0-f177.google.com with SMTP id 35so523536yxh.36
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:38:04 -0700 (PDT)
In-Reply-To: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Since we have two cpus the cpuinit call for cpu1 causes
freq_table of cpu0 to be overwritten. instead, we maintain
a counter to keep track of cpus who use the cpufreq table
allocate it once(one freq table for all CPUs) and free them
once the last user is done with it.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   33 ++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index d0b4f97..fc3d0fb 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -42,6 +42,9 @@
 #define VERY_HI_RATE	900000000
 
 static struct cpufreq_frequency_table *freq_table;
+static int freq_table_users;
+static DEFINE_MUTEX(freq_table_lock);
+
 static struct clk *mpu_clk;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
@@ -172,6 +175,18 @@ skip_lpj:
 	return ret;
 }
 
+static void freq_table_free(void)
+{
+	if (!freq_table_users)
+		return;
+	freq_table_users--;
+	if (freq_table_users)
+		return;
+	clk_exit_cpufreq_table(&freq_table);
+	kfree(freq_table);
+	freq_table = NULL;
+}
+
 static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
@@ -199,14 +214,18 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 		return -EINVAL;
 	}
 
+	mutex_lock(&freq_table_lock);
 	/*
 	 * if we dont get cpufreq table using opp, use traditional omap2 lookup
 	 * as a fallback
 	 */
-	if (opp_init_cpufreq_table(mpu_dev, &freq_table))
-		clk_init_cpufreq_table(&freq_table);
+	if (!freq_table) {
+		if (opp_init_cpufreq_table(mpu_dev, &freq_table))
+			clk_init_cpufreq_table(&freq_table);
+	}
 
 	if (freq_table) {
+		freq_table_users++;
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
 		if (!result) {
 			cpufreq_frequency_table_get_attr(freq_table,
@@ -215,10 +234,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 			clk_exit_cpufreq_table(&freq_table);
 			WARN(true, "%s: fallback to clk_round(freq_table=%d)\n",
 					__func__, result);
-			kfree(freq_table);
-			freq_table = NULL;
+			freq_table_free();
 		}
 	}
+	mutex_unlock(&freq_table_lock);
 
 	if (!freq_table) {
 		policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
@@ -251,9 +270,9 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
-	clk_exit_cpufreq_table(&freq_table);
-	kfree(freq_table);
-	freq_table = NULL;
+	mutex_lock(&freq_table_lock);
+	freq_table_free();
+	mutex_unlock(&freq_table_lock);
 	clk_put(mpu_clk);
 	return 0;
 }
-- 
1.7.1

