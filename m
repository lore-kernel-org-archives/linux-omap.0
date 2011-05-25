From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH V3 7/8] OMAP2+: cpufreq: put clk if cpu_init failed
Date: Wed, 25 May 2011 16:38:52 -0700
Message-ID: <1306366733-8439-8-git-send-email-nm@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33704 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932218Ab1EYXjZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:39:25 -0400
Received: by mail-gx0-f176.google.com with SMTP id 7so110902gxk.35
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:39:24 -0700 (PDT)
In-Reply-To: <1306366733-8439-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Release the mpu_clk in fail paths.

Reported-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index f026ac4..594100e 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -226,8 +226,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
-	if (policy->cpu >= NR_CPUS)
-		return -EINVAL;
+	if (policy->cpu >= NR_CPUS) {
+		result = -EINVAL;
+		goto fail1;
+	}
 
 	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
 
@@ -235,7 +237,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	if (result || !freq_table) {
 		dev_err(mpu_dev, "%s: cpu%d: unable to get freq table [%d]\n",
 			__func__, policy->cpu, result);
-		return result;
+		goto fail1;
 	}
 
 	mutex_lock(&freq_table_lock);
@@ -244,8 +246,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 		mutex_unlock(&freq_table_lock);
 		dev_err(mpu_dev, "%s: cpu%d: unable to get cpuinfo [%d]\n",
 			__func__, policy->cpu, result);
-		freq_table_free();
-		return result;
+		goto fail2;
 	}
 	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
 	mutex_unlock(&freq_table_lock);
@@ -271,6 +272,12 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 300 * 1000;
 
 	return 0;
+
+fail2:
+	freq_table_free();
+fail1:
+	clk_put(mpu_clk);
+	return result;
 }
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
-- 
1.7.1

