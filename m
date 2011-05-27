From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH v4 4/4] OMAP2+: cpufreq: fix freq_table leak
Date: Thu, 26 May 2011 19:39:20 -0700
Message-ID: <1306463960-27340-5-git-send-email-nm@ti.com>
References: <1306463960-27340-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53811 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349Ab1E0Cjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 22:39:43 -0400
Received: by mail-yi0-f52.google.com with SMTP id 10so758232yih.25
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 19:39:42 -0700 (PDT)
In-Reply-To: <1306463960-27340-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

We use a single frequency table for multiple CPUs. But, with
OMAP4, since we have multiple CPUs, the cpu_init call for CPU1
causes freq_table previously allocated for CPU0 to be overwritten.
In addition, we dont free the table on exit path.

We solve this by maintaining an atomic type counter to ensure
just a single table exists at a given time.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

NOTE: Depends on: http://marc.info/?t=130630947000002&r=1&w=2

 arch/arm/mach-omap2/omap2plus-cpufreq.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 40b2a7c..e101737 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -39,6 +39,7 @@
 #include <mach/hardware.h>
 
 static struct cpufreq_frequency_table *freq_table;
+static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
 static struct device *mpu_dev;
@@ -153,6 +154,12 @@ skip_lpj:
 	return ret;
 }
 
+static inline void freq_table_free(void)
+{
+	if (atomic_dec_and_test(&freq_table_users))
+		opp_free_cpufreq_table(mpu_dev, &freq_table);
+}
+
 static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
@@ -168,7 +175,9 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
-	result = opp_init_cpufreq_table(mpu_dev, &freq_table);
+
+	if (atomic_inc_return(&freq_table_users) == 1)
+		result = opp_init_cpufreq_table(mpu_dev, &freq_table);
 
 	if (result) {
 		dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
@@ -180,7 +189,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	if (!result)
 		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
 	else
-		goto fail_ck;
+		goto fail_table;
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
@@ -204,6 +213,8 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 
 	return 0;
 
+fail_table:
+	freq_table_free();
 fail_ck:
 	clk_put(mpu_clk);
 	return result;
@@ -211,6 +222,7 @@ fail_ck:
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
+	freq_table_free();
 	clk_put(mpu_clk);
 	return 0;
 }
-- 
1.7.1

