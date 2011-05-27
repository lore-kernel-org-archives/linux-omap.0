From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH v4 3/4] OMAP2+: cpufreq: put clk if cpu_init failed
Date: Thu, 26 May 2011 19:39:19 -0700
Message-ID: <1306463960-27340-4-git-send-email-nm@ti.com>
References: <1306463960-27340-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54347 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349Ab1E0Cjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 22:39:39 -0400
Received: by mail-yw0-f47.google.com with SMTP id 8so636143ywg.20
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 19:39:38 -0700 (PDT)
In-Reply-To: <1306463960-27340-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Release the mpu_clk in fail paths.

Reported-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index e10fcf8..40b2a7c 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -162,8 +162,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
-	if (policy->cpu >= NR_CPUS)
-		return -EINVAL;
+	if (policy->cpu >= NR_CPUS) {
+		result = -EINVAL;
+		goto fail_ck;
+	}
 
 	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
 	result = opp_init_cpufreq_table(mpu_dev, &freq_table);
@@ -171,12 +173,14 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	if (result) {
 		dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
 				__func__, policy->cpu, result);
-		return result;
+		goto fail_ck;
 	}
 
 	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
 	if (!result)
 		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+	else
+		goto fail_ck;
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
@@ -199,6 +203,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 300 * 1000;
 
 	return 0;
+
+fail_ck:
+	clk_put(mpu_clk);
+	return result;
 }
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
-- 
1.7.1

