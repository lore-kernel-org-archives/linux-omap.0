From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 10/10] cpufreq: OMAP: fix freq_table leak
Date: Thu, 22 Sep 2011 14:07:28 -0700
Message-ID: <1316725648-26710-11-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57792 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754095Ab1IVVIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 17:08:05 -0400
In-Reply-To: <1316725648-26710-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Nishanth Menon <nm@ti.com>

We use a single frequency table for multiple CPUs. But, with
OMAP4, since we have multiple CPUs, the cpu_init call for CPU1
causes freq_table previously allocated for CPU0 to be overwritten.
In addition, we dont free the table on exit path.

We solve this by maintaining an atomic type counter to ensure
just a single table exists at a given time.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index a66c8b5..90918e1 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -45,6 +45,7 @@ static struct lpj_info global_lpj_ref;
 #endif
 
 static struct cpufreq_frequency_table *freq_table;
+static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
 static struct device *mpu_dev;
@@ -149,6 +150,12 @@ static int omap_target(struct cpufreq_policy *policy,
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
@@ -163,7 +170,9 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
-	result = opp_init_cpufreq_table(mpu_dev, &freq_table);
+
+	if (atomic_inc_return(&freq_table_users) == 1)
+		result = opp_init_cpufreq_table(mpu_dev, &freq_table);
 
 	if (result) {
 		dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
@@ -172,10 +181,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-	if (!result)
-		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-	else
-		goto fail_ck;
+	if (result)
+		goto fail_table;
+
+	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
@@ -198,6 +207,8 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 
 	return 0;
 
+fail_table:
+	freq_table_free();
 fail_ck:
 	clk_put(mpu_clk);
 	return result;
@@ -205,6 +216,7 @@ fail_ck:
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
+	freq_table_free();
 	clk_put(mpu_clk);
 	return 0;
 }
-- 
1.7.6

